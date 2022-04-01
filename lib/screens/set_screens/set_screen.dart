import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizlet/widgets/app_text.dart';
import 'package:quizlet/widgets/set_card.dart';
import 'package:quizlet/screens/set_screens/detail_set_screen.dart';

class SetScreen extends StatelessWidget {
  const SetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _setCard = List.generate(
        100,
        (index) => {
              'username': 'Person #$index',
              'terms': Random().nextInt(100) + 1,
              'title': 'Title $index',
            });

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          color: Colors.white,
          text: 'Sets',
          size: 35,
          isBold: true,
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      ),
      body: ListView.builder(
        itemCount: _setCard.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailSetScreen(),
                ),
              );
            },
            child: SetCard(
              title: _setCard[index]['title'],
              username: _setCard[index]['username'],
              terms: _setCard[index]['terms'],
            ),
          );
        },
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
    );
  }
}
