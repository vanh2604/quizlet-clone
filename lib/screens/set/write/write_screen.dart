import 'package:flutter/material.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/write/result_write_screen.dart';
import 'package:quizlet/utils/colors.dart';

class WriteScreen extends StatefulWidget {
  final List<CardModel2> question2s;
  const WriteScreen({Key? key, required this.question2s}) : super(key: key);

  @override
  _WriteScreen createState() => _WriteScreen();
}

class _WriteScreen extends State<WriteScreen> {
  final FocusNode _focusNode = FocusNode();
  PageController? _pageController;
  bool _haveSummited = false;
  bool _isCorrectAnswer = false;
  bool _autofocus = true;
  int countEnterToAnswer = 0;
  int score = 0;

  List<String> q = [];
  List<String> correctAns = [];
  List<String> incorrectAns = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    widget.question2s.shuffle();

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
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _haveSummited = false;
            _isCorrectAnswer = false;
            _autofocus = true;
            countEnterToAnswer = 0;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return buildCardWrite(index);
        },
      ),
    );
  }

  Widget buildCardWrite(int index) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      "${widget.question2s[index].question}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                    for (int i = 0;
                        i < widget.question2s[index].listAnswer!.length;
                        i++)
                      Text(
                        widget.question2s[index].listAnswer![i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      )
                  ],
                ),
              ),
              Row(
                children: [
                  if ((countEnterToAnswer == 0) && _isCorrectAnswer)
                    const Icon(
                      Icons.circle,
                      color: Colors.green,
                    )
                  else
                    countEnterToAnswer >= 1
                        ? const Icon(
                            Icons.circle,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            color: Colors.white,
                          ),
                  if ((countEnterToAnswer == 0 || countEnterToAnswer == 1) &&
                      _isCorrectAnswer)
                    const Icon(
                      Icons.circle,
                      color: Colors.green,
                    )
                  else
                    countEnterToAnswer == 2
                        ? const Icon(
                            Icons.circle,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            color: Colors.white,
                          )
                ],
              )
            ],
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            focusNode: _focusNode,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: _haveSummited
                      ? _isCorrectAnswer
                          ? Colors.green
                          : Colors.orange
                      : Colors.white,
                  width: 5,
                ),
              ),
            ),
            autofocus: _autofocus,
            onFieldSubmitted: !_haveSummited
                ? (String? value) {
                    if (countEnterToAnswer == 0) {
                      q.add(widget.question2s[index].question.toString());
                    }
                    if (widget.question2s[index].answer!.contains(value!) &&
                        widget.question2s[index].answer! == value) {
                      score++;
                      incorrectAns.add("");
                      correctAns.add(widget.question2s[index].answer!);

                      setState(() {
                        _haveSummited = true;
                        _isCorrectAnswer = true;
                        _autofocus = true;
                      });
                    } else {
                      setState(() {
                        _haveSummited = true;
                        _isCorrectAnswer = false;
                        countEnterToAnswer++;
                        _autofocus = true;
                      });
                      if (countEnterToAnswer == 2) {
                        incorrectAns.add(value);
                        correctAns.add(widget.question2s[index].answer!);
                      }
                    }

                    Future.delayed(const Duration(seconds: 3), () {
                      if (_pageController!.page?.toInt() ==
                          widget.question2s.length - 1) {
                        q.add(widget.question2s[index].question.toString());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultWScreen(
                              score,
                              q,
                              correctAns,
                              incorrectAns,
                              questionLearn: widget.question2s,
                            ),
                          ),
                        );
                      } else if (_isCorrectAnswer || countEnterToAnswer == 2) {
                        _pageController!.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        setState(() {
                          _haveSummited = false;
                          _isCorrectAnswer = false;
                        });
                      }
                    });
                  }
                : null,
          ),
          const SizedBox(
            height: 10,
          ),
          if (_haveSummited)
            _isCorrectAnswer
                ? const Text("Correct", style: TextStyle(color: Colors.green))
                : const Text(
                    "Incorrect",
                    style: TextStyle(color: Colors.orange),
                  )
          else
            const Text(
              "Fill the blank",
              style: TextStyle(color: Colors.white),
            )
        ],
      ),
    );
  }
}
