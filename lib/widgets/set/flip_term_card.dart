import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quizlet/widgets/qtext.dart';

class FlipTermCard extends StatefulWidget {
  final String title;
  final String definition;

  const FlipTermCard({Key? key, required this.title, required this.definition})
      : super(key: key);

  @override
  _FlipTermCard createState() => _FlipTermCard();
}

class _FlipTermCard extends State<FlipTermCard> {
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: angle),
        duration: const Duration(milliseconds: 250),
        builder: (BuildContext context, double val, __) {
          if (val >= (pi / 2)) {
            isBack = false;
          } else {
            isBack = true;
          }
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(val),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: isBack
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color.fromRGBO(52, 58, 85, 1),
                      ),
                      child: Center(
                        child: QText(
                          color: Colors.white,
                          text: widget.title,
                        ),
                      ),
                    )
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateX(pi),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(52, 58, 85, 1),
                        ),
                        child: Center(
                          child: QText(
                            color: Colors.white,
                            text: widget.definition,
                          ),
                        ),
                      ),
                    ), //else we will display it here,
            ),
          );
        },
      ),
    );
  }
}
