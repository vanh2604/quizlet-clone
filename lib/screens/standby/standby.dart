import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class StandbyScreen extends StatefulWidget {
  const StandbyScreen({Key? key}) : super(key: key);

  @override
  State<StandbyScreen> createState() => _StandbyScreenState();
}

class _StandbyScreenState extends State<StandbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _navigateToIntroduction(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/quizzy.png"),
                      fit: BoxFit.cover)),
            ),
          );
        },
      ),
      backgroundColor: standbyBackgroundColor,
    );
  }

  Future<void> _navigateToIntroduction() async {
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (mounted) {
          if (user == null) {
            //User is currently signed out
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/introduction', (Route<dynamic> route) => false);
          } else {
            // User is signed in
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/main', (Route<dynamic> route) => false);
          }
        }
      });
    });
  }
}
