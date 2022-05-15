import 'package:flutter/material.dart';
import 'package:quizlet/widgets/qtext.dart';

class LearnCustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const LearnCustomButton({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 20),
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(52, 58, 85, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          QText(text: text, color: Colors.white)
        ],
      ),
    );
  }
}
