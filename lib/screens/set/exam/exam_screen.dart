// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/exam/result_exam.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class ExamScreen extends StatefulWidget {
  bool isMultichoice;
  bool isWrite;
  List<CardModel2> listQuestion;

  ExamScreen({
    Key? key,
    required this.listQuestion,
    this.isMultichoice = true,
    this.isWrite = true,
  }) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  // Write variable
  final FocusNode _focusNode = FocusNode();
  PageController? _pageController;
  bool _haveSummited = false;
  bool _autofocus = true;
  int countEnterToAnswer = 0;

  // Multichoice variable
  int questionPos = 0;
  int selectedIndex = -1;
  int score = 0;
  bool btnPressed = false;
  String btnText = "Next Question";
  bool answered = false;

  // Custom variable
  int countQuestion = 0;

  List<String> q = [];
  List<String> correctAns = [];
  List<String> incorrectAns = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    widget.listQuestion.shuffle();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _haveSummited = false;
            _autofocus = true;
            countEnterToAnswer = 0;
            btnPressed = false;
            answered = false;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return widget.isWrite && widget.isMultichoice
              ? (index.isOdd
                  ? buildWriteScreen(index)
                  : buildMultiQuestion(index))
              : widget.isWrite
                  ? buildWriteScreen(index)
                  : buildMultiQuestion(index);
        },
        //itemCount: widget.listQuestion.length,
      ),
    );
  }

  Widget buildWriteScreen(int index) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 300,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QText(
                      text:
                      "Question ${index + 1}/${widget.listQuestion.length}",
                      size: 28,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${widget.listQuestion[index].question}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                    for (int i = 0;
                        i < widget.listQuestion[index].listAnswer!.length;
                        i++)
                      QText(
                        text: widget.listQuestion[index].listAnswer![i],
                        color: Colors.white,
                        size: 22,
                      ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     if ((countEnterToAnswer == 0) && _isCorrectAnswer)
              //       const Icon(
              //         Icons.circle,
              //         color: Colors.green,
              //       )
              //     else
              //       countEnterToAnswer >= 1
              //           ? const Icon(
              //               Icons.circle,
              //               color: Colors.red,
              //             )
              //           : const Icon(
              //               Icons.circle_outlined,
              //               color: Colors.white,
              //             ),
              //     if ((countEnterToAnswer == 0 || countEnterToAnswer == 1) &&
              //         _isCorrectAnswer)
              //       const Icon(
              //         Icons.circle,
              //         color: Colors.green,
              //       )
              //     else
              //       countEnterToAnswer == 2
              //           ? const Icon(
              //               Icons.circle,
              //               color: Colors.red,
              //             )
              //           : const Icon(
              //               Icons.circle_outlined,
              //               color: Colors.white,
              //             )
              //   ],
              // )
            ],
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 5,
                ),
              ),
            ),
            autofocus: _autofocus,
            onFieldSubmitted: !_haveSummited
                ? (String? value) {
                    setState(() {
                      _haveSummited = true;
                    });
                    q.add(widget.listQuestion[index].question.toString());
                    correctAns
                        .add(widget.listQuestion[index].answer.toString());
                    if (value == widget.listQuestion[index].answer) {
                      score++;
                      incorrectAns.add("");
                    } else {
                      incorrectAns.add(value!);
                    }
                    // if (countEnterToAnswer == 0) {
                    //   q.add(widget.listQuestion[index].question.toString());
                    // }
                    // if (widget.listQuestion[index].answer!.contains(value!) &&
                    //     widget.listQuestion[index].answer! == value) {
                    //   score++;
                    //   incorrectAns.add("");
                    //   correctAns.add(widget.listQuestion[index].answer!);
                    //   setState(() {
                    //     _haveSummited = true;
                    //     _isCorrectAnswer = true;
                    //     _autofocus = true;
                    //   });
                    // } else {
                    //   setState(() {
                    //     _haveSummited = true;
                    //     _isCorrectAnswer = false;
                    //     countEnterToAnswer++;
                    //     _autofocus = true;
                    //   });
                    //   if (countEnterToAnswer == 2) {
                    //     incorrectAns.add(value);
                    //     correctAns.add(widget.listQuestion[index].answer!);
                    //   }
                    // }

                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (_pageController!.page?.toInt() ==
                          widget.listQuestion.length - 1) {
                        q.add(widget.listQuestion[index].question.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultExam(
                              score,
                              q,
                              correctAns,
                              incorrectAns,
                              questionLearn: widget.listQuestion,
                              isWrite: widget.isWrite,
                              isMulti: widget.isMultichoice,

                            ),
                          ),
                        );
                      } else {
                        _pageController!.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                        );
                        setState(() {
                          _haveSummited = false;
                        });
                      }
                    });
                  }
                : null,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Fill the blank",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget buildMultiQuestion(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 400,
              color: secondaryColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QText(
                      text:
                          "Question ${index + 1}/${widget.listQuestion.length}",
                      size: 28,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QText(
                      text: "${widget.listQuestion[index].question}",
                      color: Colors.white,
                      size: 22.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 250),
          for (int i = 0;
              i < widget.listQuestion[index].listAnswer!.length;
              i++)
            Container(
              width: double.infinity,
              height: 50.0,
              margin:
                  const EdgeInsets.only(bottom: 20.0, left: 12.0, right: 12.0),
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.white),
                ),
                fillColor: const Color.fromRGBO(12, 12, 48, 1),
                // btnPressed
                //     ? (i == selectedIndex
                //         ? (widget.listQuestion[index].listAnswer![i] ==
                //                 widget.listQuestion[index].answer
                //             ? Colors.green
                //             : Colors.red)
                //         : (widget.listQuestion[index].listAnswer![i] ==
                //                 widget.listQuestion[index].answer
                //             ? Colors.green
                //             : const Color.fromRGBO(12, 12, 48, 1)))
                //     :

                onPressed: !answered
                    ? () {
                        // q.add(
                        //   widget.listQuestion[index].question.toString(),
                        // );
                        // correctAns.add(
                        //   widget.listQuestion[index].answer.toString(),
                        // );
                        // if (widget.listQuestion[index].listAnswer![i] ==
                        //     widget.listQuestion[index].answer) {
                        //   score++;
                        //   incorrectAns.add("");
                        //   setState(() {
                        //     selectedIndex = i;
                        //   });
                        // } else {
                        //   incorrectAns.add(
                        //     widget.listQuestion[index].listAnswer![i],
                        //   );
                        //   setState(() {
                        //     selectedIndex = i;
                        //   });
                        // }
                        // setState(() {
                        //   btnPressed = true;
                        //   answered = true;
                        // });
                        q.add(
                          widget.listQuestion[index].question.toString(),
                        );
                        correctAns.add(
                          widget.listQuestion[index].answer.toString(),
                        );
                        if (widget.listQuestion[index].listAnswer![i] ==
                            widget.listQuestion[index].answer) {
                          score++;
                          incorrectAns.add("");
                          setState(() {
                            selectedIndex = i;
                          });
                        } else {
                          incorrectAns
                              .add(widget.listQuestion[index].listAnswer![i]);
                        }

                        setState(() {
                          btnPressed = true;
                          answered = true;
                        });
                        Future.delayed(const Duration(milliseconds: 200), () {
                          if (_pageController!.page?.toInt() ==
                              widget.listQuestion.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultExam(
                                  score,
                                  q,
                                  correctAns,
                                  incorrectAns,
                                  questionLearn: widget.listQuestion,
                                  isMulti: widget.isMultichoice,
                                  isWrite: widget.isWrite,
                                ),
                              ),
                            );
                          } else {
                            _pageController!.nextPage(
                              duration: const Duration(milliseconds: 250),
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
                  widget.listQuestion[index].listAnswer![i],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
