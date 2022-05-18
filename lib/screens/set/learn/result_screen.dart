import 'package:flutter/material.dart';
import 'package:quizlet/data/card_data.dart';

import 'learn_screen.dart';

void main() => runApp(ResultScreen(10));

class ResultScreen extends StatefulWidget {
  int score;
  ResultScreen(this.score, {Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title:Text("Result"),
            backgroundColor: const Color.fromRGBO(52, 58, 85, 1),
        ),
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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

              Text(
                "You Score",
                style: TextStyle(color: Colors.white, fontSize: 34.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "${widget.score}",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 85.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearnScreen(
                          questionLearn: questions,
                        ),
                      ));
                },
                shape: StadiumBorder(),
                color: Colors.red,
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Reapeat the quizz",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
