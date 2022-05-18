import 'package:flutter/material.dart';
import 'package:quizlet/data/card_data.dart';
import 'package:quizlet/screens/set/learn/learn_screen.dart';

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
          title: const Text("Result"),
          backgroundColor: const Color.fromRGBO(52, 58, 85, 1),
        ),
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
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
              const Text(
                "You Score",
                style: TextStyle(color: Colors.white, fontSize: 34.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "${widget.score}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 85.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
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
                    ),
                  );
                },
                shape: const StadiumBorder(),
                color: Colors.red,
                padding: const EdgeInsets.all(18.0),
                child: const Text(
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
