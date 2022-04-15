import 'package:flutter/material.dart';
import 'package:quizlet/screens/set/learn/result_screen.dart';

import '../../../data/question_data.dart';


class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

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
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == questions.length - 1) {
                setState(() {
                  btnText = "See Results";
                });
              }
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
                      "${questions[index].question}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: const EdgeInsets.only(
                          bottom: 20.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),

                        fillColor: btnPressed ? (i==selected_index?(questions[index].answers!.values.toList()[i]?Colors.green:Colors.red):(questions[index].answers!.values.toList()[i]?Colors.green:const Color.fromRGBO(12, 12, 48, 1))): const Color.fromRGBO(12, 12, 48, 1),
                        onPressed: !answered?() {
                          if (questions[index].answers!.values.toList()[i]) {
                            score++;
                            print("yes");
                            setState(() {
                              selected_index = i;
                            });

                          } else {
                            setState(() {
                              selected_index = i;
                            });
                            print("no");
                          }
                          print(selected_index);
                          setState(() {
                            btnPressed = true;
                            answered = true;
                          });
                          Future.delayed(const Duration(seconds: 3),() {
                            if (_controller!.page?.toInt() == questions.length - 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen(score)));
                            } else {
                              _controller!.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
                              setState(() {
                                btnPressed = false;
                                selected_index= -1;
                              });
                            }
                          });

                        }:null,

                        child: Text(questions[index].answers!.keys.toList()[i],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            )),
                      ),
                    ),
                  // RawMaterialButton(
                  //   onPressed: () {
                  //     if (_controller!.page?.toInt() == questions.length - 1) {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ResultScreen(score)));
                  //     } else {
                  //       _controller!.nextPage(
                  //           duration: Duration(milliseconds: 200),
                  //           curve: Curves.easeInExpo);
                  //
                  //       setState(() {
                  //         btnPressed = false;
                  //       });
                  //     }
                  //   },
                  //   shape: StadiumBorder(),
                  //   fillColor: Colors.blue,
                  //   padding: EdgeInsets.all(18.0),
                  //   elevation: 0.0,
                  //   child: Text(
                  //     btnText,
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // )
                ],
              );
            },
            itemCount: questions.length,
          )),
    );
  }
}
