import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';

class StandbyScreen extends StatefulWidget {
  const StandbyScreen({Key? key}) : super(key: key);

  @override
  State<StandbyScreen> createState() => _StandbyScreenState();
}

class _StandbyScreenState extends State<StandbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
      backgroundColor: standbyBackgroundColor,
    );
  }

  Widget buildBody(BuildContext context) {
    return FutureBuilder(
      future: _navigateToIntroduction(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/quizzy.png"), fit: BoxFit.cover)),
          ),
        );
      },
    );
  }

  Future<String> _navigateToIntroduction() async {
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'introduction', (route) => false);
    });
    return "Done";
  }
}
