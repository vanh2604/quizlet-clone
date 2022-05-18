import 'package:flutter/material.dart';
import 'package:quizlet/data/card_data.dart';
import 'package:quizlet/widgets/review_term.dart';

import 'learn_screen.dart';



class ResultScreen extends StatefulWidget {
  int score;
  ResultScreen(this.score, {Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Result"),
          backgroundColor: const Color.fromRGBO(52, 58, 85, 1),
        ),
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 20, left: 20),
          child: Column(
            children: [
              const Text("You Score",
                style: TextStyle(color: Colors.white, fontSize: 34.0),
              ),

              const SizedBox(
                width: double.infinity,
                child: Text(
                  "13%",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Container(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Colors.blueAccent
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LearnScreen(
                            questionLearn: questions,
                          ),
                        ));
                  },
                  child: const Text('Repeat the set'),
                ),
              ),
              SizedBox(height: 20,),

              Container(
                height: MediaQuery.of(context).size.height*0.7,
                  child: PageView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    controller: PageController(viewportFraction: 0.93),
                    itemBuilder: (BuildContext context, int index) {
                      // return Center(
                      //     child: Text(
                      //         index.toString(),
                      //         style: TextStyle(color: Colors.white)
                      //     )
                      // );
                      return ReviewTerm(term: index.toString(), correctAnswer: "correctAnswer");
                    },
                  ),
            
                ),



            ],
          ),
        ),
      );
  }
}
