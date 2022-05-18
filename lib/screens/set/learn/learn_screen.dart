import 'package:flutter/material.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/learn/result_screen.dart';

import '../../../data/card_data.dart';

void main() => runApp(LearnScreen(
      questionLearn: questions,
    ));

class LearnScreen extends StatefulWidget {
  List<CardModel> questionLearn;
  LearnScreen({Key? key, required this.questionLearn}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  int question_pos = 0;
  int selected_index = -1;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    widget.questionLearn.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: PageView.builder(
              controller: _controller!,
              onPageChanged: (page) {
                setState(() {
                  btnPressed = false;
                  answered = false;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Question ${index + 1}/10",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 200.0,
                      child: Text(
                        "${widget.questionLearn[index].question}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    for (int i = 0;
                        i < widget.questionLearn[index].answer!.length;
                        i++)
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        margin: const EdgeInsets.only(
                            bottom: 20.0, left: 12.0, right: 12.0),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(color: Colors.white)),
                          fillColor: btnPressed
                              ? (i == selected_index
                                  ? (widget.questionLearn[index].answer!.values
                                          .toList()[i]
                                      ? Colors.green
                                      : Colors.red)
                                  : (widget.questionLearn[index].answer!.values
                                          .toList()[i]
                                      ? Colors.green
                                      : const Color.fromRGBO(12, 12, 48, 1)))
                              : const Color.fromRGBO(12, 12, 48, 1),
                          onPressed: !answered
                              ? () {
                                  if (widget.questionLearn[index].answer!.values
                                      .toList()[i]) {
                                    score++;
                                    setState(() {
                                      selected_index = i;
                                    });
                                  } else {
                                    setState(() {
                                      selected_index = i;
                                    });
                                  }
                                  setState(() {
                                    btnPressed = true;
                                    answered = true;
                                  });
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    if (_controller!.page?.toInt() ==
                                        widget.questionLearn.length - 1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResultScreen(score)));
                                    } else {
                                      _controller!.nextPage(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          curve: Curves.easeInOut);
                                      setState(() {
                                        btnPressed = false;
                                        selected_index = -1;
                                      });
                                    }
                                  });
                                }
                              : null,
                          child: Text(
                              widget.questionLearn[index].answer!.keys
                                  .toList()[i],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              )),
                        ),
                      ),
                  ],
                );
              },
              itemCount: widget.questionLearn.length,
            )),
      ),
    );
  }
}
