import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizlet/screens/introduction_screen.dart';
import 'package:quizlet/screens/standby_sceen.dart';

class FutureNavigation extends StatefulWidget {
  @override
  _FutureNavigationState createState() => _FutureNavigationState();
}

class _FutureNavigationState extends State<FutureNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Future Navigator"),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return FutureBuilder(
      future: _login(),
      builder: (context, snapshot) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<String> _login() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return IntroductionScreen();
          },
        ),
      );
    });

    return "Logined";
  }
}
