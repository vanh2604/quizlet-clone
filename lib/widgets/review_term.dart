import 'package:flutter/material.dart';
import 'package:quizlet/widgets/qtext.dart';


class ReviewTerm extends StatelessWidget {
  final String term;
  final String correctAnswer;
  final String incorrectAnswer;
  const ReviewTerm({
    Key? key,
    required this.term,
    required this.correctAnswer,
    this.incorrectAnswer = ""
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const  EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(52, 58, 85, 1)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          SizedBox(height: 20,),
          Center(
            child: QText(text: term, color: Colors.white,)
          ),
          SizedBox(height: 20,),
          incorrectAnswer == ""?
            Center(child: QText(text: correctAnswer, color: Colors.green,),):
              Row(
                children: [
                  QText(text: "text", color: Colors.green),
                  QText(text: "text", color: Colors.red)
                ],
              ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: incorrectAnswer==""? Colors.green: Colors.orange
            ),
            child: incorrectAnswer!=""? Center(child: QText(text: "Incorrect", color: Colors.white)):Center(child: QText(text: "Correct", color: Colors.white))
          )
        ],
      ),
    );
  }
}
