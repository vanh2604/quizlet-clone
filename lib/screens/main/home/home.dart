import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:quizlet/widgets/home/folder_card_home.dart';
import 'package:quizlet/widgets/home/set_card_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
            child: StreamBuilder<QuerySnapshot>(
                stream: getUserSetsStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.hasData
                      ? PageView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.horizontal,
                          controller: PageController(viewportFraction: 0.93),
                          itemBuilder: (context, index) {
                            DocumentSnapshot sets = snapshot.data!.docs[index];
                            return SetCardBig(
                              title: sets['name'],
                              username: sets['username'],
                              terms: sets['cards'].length,
                            );
                          },
                        )
                      : const CircularProgressIndicator();
                }),
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
            child: FutureBuilder<DocumentSnapshot>(
                future: getUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PageView.builder(
                      itemCount: snapshot.data!['folders'].length,
                      scrollDirection: Axis.horizontal,
                      controller: PageController(viewportFraction: 0.93),
                      itemBuilder: (context, index) {
                        return FolderCardBig(
                          title: snapshot.data!['folders'][index],
                          username: snapshot.data!['username'],
                          terms: 0,
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
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
                    title: '',
                    username: '',
                    terms: 1,
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
