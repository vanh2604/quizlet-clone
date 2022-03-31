import 'package:flutter/material.dart';
import 'package:quizlet/widgets/app_text.dart';

class LearnCustomButton extends StatelessWidget {
  final String text;
  IconData icon;
  LearnCustomButton({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right:20),
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(52, 58, 85, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50,),
          SizedBox(height: 10,),
          AppText(text: text, color: Colors.white)
        ],
      ),
    );
  }
}
