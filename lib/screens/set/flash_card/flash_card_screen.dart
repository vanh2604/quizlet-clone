// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/flash_card/card_provider.dart';
import 'package:quizlet/screens/set/flash_card/swipe_card.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class FlashCardScreen extends StatelessWidget {
  List<CardModel2> listQuestions;
  FlashCardScreen({Key? key, required this.listQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MainPage(
        listQuestions: listQuestions,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  List<CardModel2> listQuestions;
  MainPage({Key? key, required this.listQuestions}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardProvider>(context);
    provider.setListQuestion(widget.listQuestions);
    final isEmpty = provider.isEmptyListData();
    final understandCount = provider.understandCount;
    final dontunderstandCount = provider.dontUnderstandCount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/set'));
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              // progress bar
              Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: buildProgressBar(),
              ),
              const SizedBox(
                height: 40,
              ),
              // swipe card
              Flexible(
                child: !isEmpty
                    ? buildCards()
                    : buildEndCard(
                        understandCount: understandCount,
                        dontUnderstandCount: dontunderstandCount,
                        listQuestions: widget.listQuestions,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              // count when pan left or pan right
              buildTermCount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final listQuestion = provider.listQuestion;
    return Stack(
      children: listQuestion
          .map(
            (q) => SwipeCard(
              urlImage: q.question.toString(),
              answer: q.answer.toString(),
              isFront: listQuestion.last == q,
            ),
          )
          .toList(),
    );
    // return Stack(
    //   children: urlImages
    //       .map(
    //         (urlImage) => SwipeCard(
    //           urlImage: urlImage,
    //           isFront: urlImages.last == urlImage,
    //         ),
    //       )
    //       .toList(),
    // );
  }

  Widget buildEndCard({
    required int understandCount,
    required int dontUnderstandCount,
    required List<CardModel2> listQuestions,
  }) {
    final String line1 =
        understandCount == (understandCount + dontUnderstandCount)
            ? "Congrats!"
            : "You can do it!";
    final String line2 =
        understandCount == (understandCount + dontUnderstandCount)
            ? "You've learnt everything"
            : "$understandCount down, $dontUnderstandCount to go.";
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(52, 58, 85, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QText(text: line1, color: Colors.white, isBold: true),
              const SizedBox(
                height: 10,
              ),
              QText(text: line2, color: Colors.white),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(140, 137, 204, 1),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>const FlashCardScreen()));
                    final provider =
                        Provider.of<CardProvider>(context, listen: false);
                    if (provider.isStarted) provider.isStarted = false;
                    // provider.isStarted ? provider.isStarted = false : null;
                    provider.setListQuestion(listQuestions);
                    provider.resetList();
                  },
                  child: const QText(
                    text: 'Retry',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          //child: FlipTermCard(definition:"",title:""),
        ),
      ),
    );
  }

  Widget buildProgressBar() {
    final provider = Provider.of<CardProvider>(context);
    final totalCard = provider.totalCard;
    int currentIndexCard = provider.getOrderCurrentIndexCard() + 1;
    if (currentIndexCard >= totalCard) {
      currentIndexCard = totalCard;
    }

    return Center(
      child: Column(
        children: [
          LinearProgressIndicator(
            backgroundColor: const Color.fromRGBO(71, 71, 94, 1),
            valueColor:
                const AlwaysStoppedAnimation(Color.fromRGBO(140, 137, 204, 1)),
            value: currentIndexCard / totalCard,
          )
        ],
      ),
    );
  }

  Widget buildCurrent() {
    final provider = Provider.of<CardProvider>(context);
    final totalCard = provider.totalCard;
    int currentIndexCard = provider.getOrderCurrentIndexCard() + 1;
    if (currentIndexCard >= totalCard) {
      currentIndexCard = totalCard;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: secondaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          child: QText(
            text: "$currentIndexCard/$totalCard",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildTermCount() {
    final provider = Provider.of<CardProvider>(context);
    final understandCount = provider.understandCount;
    final dontunderstandCount = provider.dontUnderstandCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
            color: Colors.orange,
          ),
          child: Center(
            child: QText(
              color: Colors.black,
              text: dontunderstandCount.toString(),
            ),
          ),
        ),
        buildCurrent(),
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
            color: Colors.green,
          ),
          child: Center(
            child: QText(
              color: Colors.white,
              text: understandCount.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
