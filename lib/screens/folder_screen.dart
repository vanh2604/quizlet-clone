import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/widgets/app_text.dart';

import '../widgets/set_card.dart';

class FolderScreen extends StatelessWidget {
  final String folderTitle;
  final String username;
  int terms;
  FolderScreen(
      {Key? key,
      required this.folderTitle,
      required this.username,
      required this.terms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _setCard = List.generate(
        100,
        (index) => {
              'username': 'Person $index',
              'terms': Random().nextInt(100) + 1,
              'title': 'Title $index',
            });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        toolbarHeight: 80,
        title: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: folderTitle,
              color: Colors.white,
              isBold: true,
              size: 40,
            ),
            Row(
              children: [
                const Icon(Icons.favorite),
                const SizedBox(
                  width: 5,
                ),
                AppText(text: username, color: Colors.white),
                const SizedBox(
                  width: 5,
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigate to add new set ')));
              },
              icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: Container(
                margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
                //height: MediaQuery.of(context).size.height*0.78,
                child: ListView.builder(
                  itemCount: _setCard.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SetCard(
                      terms: _setCard[index]['terms'],
                      title: _setCard[index]['title'],
                      username: _setCard[index]['username'],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                //height: MediaQuery.of(context).size.height*0.07,
                width: MediaQuery.of(context).size.width,

                margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      //padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {},
                    child: const AutoSizeText("Study this folder"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
    );
  }
}
