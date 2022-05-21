// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/exam/exam_screen.dart';
import 'package:quizlet/screens/set/learn/learn_screen.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/review_term.dart';

class ResultExam extends StatefulWidget {
  int score;
  List<String> q;
  List<String> correctAns;
  List<String> incorrectAns;
  final List<CardModel2> questionLearn;
  bool isMultichoice;
  bool isWrite;
  ResultExam(
      this.score,
      this.q,
      this.correctAns,
      this.incorrectAns, {
        Key? key,
        required this.questionLearn,
        this.isMultichoice = true,
        this.isWrite = true
      }) : super(key: key);

  @override
  _ResultExamState createState() => _ResultExamState();
}

class _ResultExamState extends State<ResultExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 20, left: 20),
          child: Column(
            children: [
              const Text(
                "You Score",
                style: TextStyle(color: Colors.white, fontSize: 34.0),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "${((widget.score / widget.questionLearn.length) * 100).round()}%",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  itemCount: widget.questionLearn.length,
                  controller: PageController(viewportFraction: 0.93),
                  itemBuilder: (BuildContext context, int index) {
                    // return Center(
                    //     child: Text(
                    //         index.toString(),
                    //         style: TextStyle(color: Colors.white)
                    //     )
                    // );
                    return ReviewTerm(
                      term: widget.q[index],
                      correctAnswer: widget.correctAns[index],
                      incorrectAnswer: widget.incorrectAns[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExamScreen(
                            listQuestion: widget.questionLearn,
                            isWrite: widget.isWrite,
                            isMultichoice: widget.isMultichoice,
                          ),
                        ),
                      );
                    },
                    child: const Text('Repeat the set'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
