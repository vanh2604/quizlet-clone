import 'package:flutter/material.dart';
import 'package:quizlet/widgets/app_text.dart';

import '../utils/colors.dart';
class SetCard extends StatelessWidget {
  final String title;
  final String username;
  int terms;
  double width;
  double height;
  // thêm một biến để lưu ảnh thay cho icon

  SetCard({Key? key,
    required this.title,
    required this.username,
    this.terms = 0,
    this.width = double.infinity,
    this.height = 150,
  }) : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 20, top:5, bottom: 10),
  //     width: width,
  //     height: height,
  //     decoration: BoxDecoration(
  //       color: darkThemeColor,
  //       border: Border.all(color: const Color.fromRGBO(52, 58, 85, 1)),
  //       borderRadius: BorderRadius.circular(20)
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         AppText(text: title, color: textColor, size: 25),
  //         //const SizedBox(height: 2,),
  //         AppText(text: terms.toString()+" terms", color: termTextColor),
  //         const SizedBox(height: 50,),
  //         Row(
  //           children: [
  //             Icon(Icons.search),
  //             const SizedBox(width: 10,),
  //             AppText(text: title, color: textColor, size: 10,)
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Column(
        children: [
          Card(
            color: const Color.fromRGBO(52, 58, 85, 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 ListTile(
                  title: AppText(text: title, color: Colors.white, size:22.5),
                   subtitle: AppText(text: terms.toString() + " terms", color: termTextColor, size:12.5),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12,0,0,10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.search) , // Thay bằng ảnh
                      const SizedBox(width: 10,),
                      AppText(text: title, color: textColor, size: 13,)
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
