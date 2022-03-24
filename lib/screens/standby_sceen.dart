import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';

class StandbyScreen extends StatelessWidget {
  const StandbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/quizzy.png"),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
      backgroundColor: standbyBackgroundColor,
    );
  }
}
