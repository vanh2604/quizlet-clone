import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class SetCardBig extends StatelessWidget {
  final String title;
  final String username;
  final int terms;
  final double width;
  final double height;
  // thêm một biến để lưu ảnh thay cho icon

  const SetCardBig({
    Key? key,
    required this.title,
    required this.username,
    this.terms = 0,
    this.width = double.infinity,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
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
                    size: 18,
                    isBold: true,
                  ),
                  subtitle: QText(
                    text: "$terms terms",
                    color: termTextColor,
                    size: 12.5,
                  ),
                ),
                const SizedBox(
                  height: 30,
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
