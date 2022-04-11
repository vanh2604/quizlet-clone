import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'card_provider.dart';
import 'flip_Y_term_card.dart';



class SwipeCard extends StatefulWidget {
  final String urlImage;
  final bool isFront;
  bool isLast;
  SwipeCard({Key? key,
    required this.urlImage,
    required this.isFront,
    this.isLast=false
  }) : super(key: key);

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  @ override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });

  }

  @override
  Widget build(BuildContext context) {

    return SizedBox.expand(
      child: (widget.isFront? buildFrontCard() :buildCard())
    );
  }

  Widget buildCard() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(widget.urlImage),
          //         alignment: Alignment(-0.3,0),
          //         fit: BoxFit.fill
          //     ),
          // ),
          child: FlipYTermCard(definition:widget.urlImage+"_____",title:widget.urlImage,isFront: widget.isFront,),
        ),
      ),

    );
  }

  Widget buildFrontCard() {
    return GestureDetector(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final provider = Provider.of<CardProvider>(context, );
          final position = provider.position;
          final milliseconds = provider.isDragging ? 0: 100;
          final angle = provider.angle*pi/180;
          final center = constraints.smallest.center(Offset.zero);
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

          return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: milliseconds),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: Stack(children: [
                buildCard(),
                buildStamps(),
              ])
          );
        }
      ),
      onPanStart: (details) {
        final provider = Provider.of<CardProvider>(context,listen: false);
        //provider.startPosition(details);
      },
      onPanUpdate: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.updatePosition(details);
      },
      onPanEnd: (details) {
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.endPosition();
      },
    );
  }

  Widget buildStamps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();
    final opacity = provider.getStatusOpacity();
    switch (status) {
      case CardStatus.like:
        final child = buildStamp(color: Colors.green, text:"I understand",opacity:opacity);
        return Container(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: child);
      case CardStatus.dislike:
        final child = buildStamp(color: Colors.orangeAccent, text:"I dont understand",opacity:opacity);
        return Container(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: child);
      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required Color color,
    required String text,
    required double opacity 
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: color
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}



