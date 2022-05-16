import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:quizlet/widgets/home/folder_card_home.dart';
import 'package:quizlet/widgets/home/set_card_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _setCard = List.generate(
        100,
        (index) => {
              'username': 'Person #$index',
              'terms': Random().nextInt(100) + 1,
              'title': 'English $index',
            });
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 1),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                QText(
                  text: 'Sets',
                  color: Colors.white,
                  size: 14,
                  isBold: true,
                ),
                QText(
                    text: 'View all',
                    color: Color.fromRGBO(103, 108, 168, 1),
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
                    Navigator.pushNamed(context, '/set'),
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
              children: const [
                QText(
                  text: 'Folders',
                  color: Colors.white,
                  size: 14,
                  isBold: true,
                ),
                QText(
                    text: 'View all',
                    color: Color.fromRGBO(103, 108, 168, 1),
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
                    Navigator.pushNamed(context, '/set'),
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
              children: const [
                QText(
                  text: 'Recommended',
                  color: Colors.white,
                  size: 14,
                  isBold: true,
                ),
                QText(
                    text: 'View all',
                    color: Color.fromRGBO(103, 108, 168, 1),
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
                    Navigator.pushNamed(context, '/set'),
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
