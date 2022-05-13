import 'package:flutter/material.dart';

import '../../../data/question_data.dart';

void main() => runApp(const WriteScreen());

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    questions.shuffle();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //appBar: AppBar(title: const Text('Focus Example')),
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (page){
            setState(() {
              _haveSummited = false;
              _isCorrectAnswer = false;
              _autofocus = true;
              countEnterToAnswer =0;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return buildCardWrite(index);
          },
        ),
      ),
    );
  }

  Widget buildCardWrite(int index) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
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
                        "${questions[index].question}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                      for(int i=0;i<questions[index].answers!.length;i++)
                        Text(
                          questions[index].answers!.keys.toList()[i],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        )
                    ],
                  )
              ),
              Row(
                children: [
                  (countEnterToAnswer==0) && _isCorrectAnswer?const Icon(Icons.circle,color: Colors.green,):countEnterToAnswer >= 1?const Icon(Icons.circle,color: Colors.red,):const Icon(Icons.circle_outlined,color: Colors.white,),
                  (countEnterToAnswer==0||countEnterToAnswer==1) && _isCorrectAnswer?const Icon(Icons.circle,color: Colors.green,):countEnterToAnswer == 2?const Icon(Icons.circle,color: Colors.red,):const Icon(Icons.circle_outlined,color: Colors.white,)
                ],
              )

            ],
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            focusNode: _focusNode,
            decoration:  InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _haveSummited? _isCorrectAnswer?Colors.green:Colors.orange:Colors.white,
                    width: 5
                ),
              ),
            ),
            autofocus: _autofocus,
            onFieldSubmitted: !_haveSummited?(String?value){
              if(questions[index].answers!.containsKey(value) && questions[index].answers![value] == true) {
                setState(() {
                  _haveSummited = true;
                  _isCorrectAnswer = true;
                  _autofocus = true;
                });
              } else {
                setState(() {
                  _haveSummited = true;
                  _isCorrectAnswer = false;
                  countEnterToAnswer ++;
                  _autofocus = true;
                });
              }

              Future.delayed(const Duration(seconds: 3),() {
                if(_isCorrectAnswer || countEnterToAnswer == 2){
                  _pageController!.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
                } else{
                  setState(() {
                    _haveSummited =  false;
                    _isCorrectAnswer = false;
                  });
                }
              });
            }:null,
          ),
          const SizedBox(height: 10,),
          _haveSummited?_isCorrectAnswer?const Text("Correct",style: TextStyle(color: Colors.green)):const Text("Incorrect",style: TextStyle(color: Colors.orange))
              :const Text("Fill the blank",style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}