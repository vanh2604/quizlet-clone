import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.92,
              height: 70,
              child: Container(
                color: secondaryColor.withOpacity(0.5),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white),
                    QText(text: text, color: Colors.white, isBold: true),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
