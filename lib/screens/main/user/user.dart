import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ElevatedButton(
        onPressed: () async {
          await _signOut();
          if (mounted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          }
        },
        child: const QText(
            text: "Click", color: Colors.white, size: 30, isBold: true),
      ),
    );
  }
}
