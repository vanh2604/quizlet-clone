import 'package:flutter/material.dart';

class ResultExam extends StatefulWidget {
  const ResultExam({Key? key}) : super(key: key);

  @override
  State<ResultExam> createState() => _ResultExamState();
}

class _ResultExamState extends State<ResultExam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("This is final res"),
    );
  }
}
