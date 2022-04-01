import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizlet/screens/set_screens/detail_set_screen.dart';
import 'package:quizlet/widgets/app_text.dart';
import 'package:quizlet/widgets/folder_card_home.dart';
import 'package:quizlet/widgets/set_card_home.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _setCard = List.generate(
        100,
        (index) => {
              'username': 'Person #$index',
              'terms': Random().nextInt(100) + 1,
              'title': 'Title $index',
            });
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 1),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Sets',
                  color: Colors.white,
                  size: 14,
                  isBold: true,
                ),
                AppText(
                    text: 'View all',
                    color: const Color.fromRGBO(103, 108, 168, 1),
                    size: 14),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: PageView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              controller: PageController(viewportFraction: 0.93),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailSetScreen(),
                      ),
                    )
                  },
                  child: SetCardBig(
                    title: _setCard[index]['title'],
                    username: _setCard[index]['username'],
                    terms: _setCard[index]['terms'],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Folders',
                  color: Colors.white,
                  size: 14,
                  isBold: true,
                ),
                AppText(
                    text: 'View all',
                    color: const Color.fromRGBO(103, 108, 168, 1),
                    size: 14),
              ],
            ),
          ),
          SizedBox(
            height: 170,
            child: PageView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              controller: PageController(viewportFraction: 0.93),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailSetScreen(),
                      ),
                    )
                  },
                  child: FolderCardBig(
                    title: _setCard[index]['title'],
                    username: _setCard[index]['username'],
                    terms: _setCard[index]['terms'],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Recommended',
                  color: Colors.white,
                  size: 14,
                  isBold: true,
                ),
                AppText(
                    text: 'View all',
                    color: const Color.fromRGBO(103, 108, 168, 1),
                    size: 14),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: PageView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              controller: PageController(viewportFraction: 0.93),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailSetScreen(),
                      ),
                    )
                  },
                  child: SetCardBig(
                    title: _setCard[index]['title'],
                    username: _setCard[index]['username'],
                    terms: _setCard[index]['terms'],
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
