import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class ReviewTerm extends StatelessWidget {
  final String term;
  final String correctAnswer;
  final String incorrectAnswer;
  const ReviewTerm({
    Key? key,
    required this.term,
    required this.correctAnswer,
    this.incorrectAnswer = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: secondaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: QText(
              text: term,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (incorrectAnswer == "")
            Center(
              child: QText(
                text: correctAnswer,
                color: Colors.green,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: QText(text: correctAnswer, color: Colors.green),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Center(child: QText(text: incorrectAnswer, color: Colors.red))
                ],
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: incorrectAnswer == "" ? Colors.green : Colors.orange,
              ),
              child: incorrectAnswer != ""
                  ? const Center(
                      child: QText(text: "Incorrect", color: Colors.white),
                    )
                  : const Center(
                      child: QText(text: "Correct", color: Colors.white),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
