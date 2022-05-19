import 'package:flutter/material.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/learn/result_screen.dart';

// void main() => runApp(
//       LearnScreen(
//         questionLearn: question2s,
//       ),
//     );

class LearnScreen extends StatefulWidget {
  List<CardModel2> questionLearn;
  LearnScreen({Key? key, required this.questionLearn}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  int questionPos = 0;
  int selectedIndex = -1;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;

  List<String> q = [];
  List<String> correctAns = [];
  List<String> incorrectAns = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
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
            controller: _controller,
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
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1}/${widget.questionLearn.length}",
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
                      i < widget.questionLearn[index].listAnswer!.length;
                      i++)
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                        left: 12.0,
                        right: 12.0,
                      ),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.white),
                        ),
                        fillColor: btnPressed
                            ? (i == selectedIndex
                                ? (widget.questionLearn[index].listAnswer![i] ==
                                        widget.questionLearn[index].answer
                                    ? Colors.green
                                    : Colors.red)
                                : (widget.questionLearn[index].listAnswer![i] ==
                                        widget.questionLearn[index].answer
                                    ? Colors.green
                                    : const Color.fromRGBO(12, 12, 48, 1)))
                            : const Color.fromRGBO(12, 12, 48, 1),
                        onPressed: !answered
                            ? () {
                                q.add(widget.questionLearn[index].question.toString());
                                correctAns.add(widget.questionLearn[index].answer.toString());

                                if (widget.questionLearn[index].listAnswer![i] == widget.questionLearn[index].answer) {
                                  score++;
                                  incorrectAns.add("");
                                  setState(() {
                                    selectedIndex = i;
                                  });
                                } else {
                                  incorrectAns.add(widget.questionLearn[index].listAnswer![i]);
                                  setState(() {
                                    selectedIndex = i;
                                  });
                                }
                                setState(() {
                                  btnPressed = true;
                                  answered = true;
                                });
                                Future.delayed(const Duration(seconds: 1), () {
                                  if (_controller!.page?.toInt() ==
                                      widget.questionLearn.length - 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                            score,
                                            q,
                                            correctAns,
                                            incorrectAns,
                                            questionLearn: widget.questionLearn,
                                        ),
                                      ),
                                    );
                                  } else {
                                    _controller!.nextPage(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                    );
                                    setState(() {
                                      btnPressed = false;
                                      selectedIndex = -1;
                                    });
                                  }
                                });
                              }
                            : null,
                        child: Text(
                          widget.questionLearn[index].listAnswer![i],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
            itemCount: widget.questionLearn.length,
          ),
        ),
      ),
    );
  }
}
