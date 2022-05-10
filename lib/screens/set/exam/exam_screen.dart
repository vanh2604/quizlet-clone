import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet/data/question_data.dart';
import 'package:quizlet/model/question_model.dart';
import 'package:quizlet/screens/set/exam/result_exam.dart';

void main() => runApp(ExamScreen(listQuestion: questions,));

class ExamScreen extends StatefulWidget {
  bool isMultichoice;
  bool isWrite;
  List<QuestionModel> listQuestion;

  ExamScreen({Key? key,
    required this.listQuestion,
    this.isMultichoice = true,
    this.isWrite = true
  }) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  // Write variable
  final FocusNode _focusNode = FocusNode();
  PageController? _pageController;
  bool _haveSummited = false;
  bool _isCorrectAnswer = false;
  bool _autofocus = true;
  int countEnterToAnswer = 0;

  // Multichoice variable
  int question_pos = 0;
  int selected_index = -1;
  int score = 0;
  bool btnPressed = false;
  String btnText = "Next Question";
  bool answered = false;

  // Custom variable
  int countQuestion = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    widget.listQuestion.shuffle();

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
              btnPressed = false;
              answered = false;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
           return  widget.isWrite&&widget.isMultichoice? (index%2==0?buildWriteScreen(index):buildMultiQuestion(index)): widget.isWrite? buildWriteScreen(index):buildMultiQuestion(index);
          },
          //itemCount: widget.listQuestion.length,
        ),
      ),
    );
  }

  Widget buildWriteScreen(int index) {
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
                        "${widget.listQuestion[index].question}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                      for(int i=0;i<widget.listQuestion[index].answers!.length;i++)
                        Text(
                          widget.listQuestion[index].answers!.keys.toList()[i],
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
              if(widget.listQuestion[index].answers!.containsKey(value) && widget.listQuestion[index].answers![value] == true) {
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
                if (_pageController!.page?.toInt() ==widget.listQuestion.length - 1) {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>ResultExam()));
                } else if(_isCorrectAnswer || countEnterToAnswer == 2){
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

  Widget buildMultiQuestion(int index) {
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
            "${widget.listQuestion[index].question}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
        ),
        for (int i = 0; i < widget.listQuestion[index].answers!.length; i++)
          Container(
            width: double.infinity,
            height: 50.0,
            margin: const EdgeInsets.only(
                bottom: 20.0, left: 12.0, right: 12.0),
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.white)
              ),
              fillColor: btnPressed
                  ? (i == selected_index
                  ? (widget.listQuestion[index].answers!.values.toList()[i]
                  ? Colors.green
                  : Colors.red)
                  : (widget.listQuestion[index].answers!.values.toList()[i]
                  ? Colors.green
                  : const Color.fromRGBO(12, 12, 48, 1)))
                  : const Color.fromRGBO(12, 12, 48, 1),
              onPressed: !answered
                  ? () {
                if (widget.listQuestion[index].answers!.values.toList()[i]) {
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
                Future.delayed(const Duration(seconds: 3), () {
                  if (_pageController!.page?.toInt() ==widget.listQuestion.length - 1) {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>ResultExam()));
                  } else {
                    _pageController!.nextPage(
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
              child: Text(widget.listQuestion[index].answers!.keys.toList()[i],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
            ),
          ),
      ],
    );
  }


}
