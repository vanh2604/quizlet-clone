import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class SetCard extends StatelessWidget {
  final String title;
  final String username;
  final int terms;
  final double width;
  final double height;

  const SetCard({
    Key? key,
    required this.title,
    required this.username,
    final this.terms = 0,
    final this.width = double.infinity,
    final this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Column(
        children: [
          Card(
            color: const Color.fromRGBO(52, 58, 85, 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: QText(
                    text: title,
                    color: Colors.white,
                    size: 22.5,
                    isBold: true,
                  ),
                  subtitle: QText(
                    text: "$terms terms",
                    color: termTextColor,
                    size: 12.5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
                  child: Row(
                    children: [
                      const Icon(Icons.person_rounded),
                      const SizedBox(
                        width: 10,
                      ),
                      QText(
                        text: username,
                        color: textColor,
                        size: 13,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
