import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/widgets/home/folder_card_home.dart';
import 'package:quizlet/widgets/home/set_card_home.dart';
import 'package:quizlet/widgets/qtext.dart';

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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const QText(
                    text: 'Sets',
                    color: Colors.white,
                    size: 14,
                    isBold: true,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sets');
                    },
                    child: const QText(
                      text: 'View all',
                      color: Color.fromRGBO(103, 108, 168, 1),
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
              child: StreamBuilder<QuerySnapshot>(
                stream: getUserSetsStream(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  return snapshot.hasData
                      ? PageView.builder(
                          itemCount: snapshot.data!.docs.length,
                          controller: PageController(viewportFraction: 0.93),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot set =
                                snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/set',
                                  arguments: {'setDetail': set.data()},
                                );
                              },
                              child: SetCardBig(
                                title: set['name'].toString(),
                                username: set['username'].toString(),
                                terms: int.parse(
                                  set['cards'].length.toString(),
                                ),
                              ),
                            );
                          },
                        )
                      : const CircularProgressIndicator();
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
                    size: 14,
                  ),
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
                      itemCount: int.parse(
                        snapshot.data!['folders'].length.toString(),
                      ),
                      controller: PageController(viewportFraction: 0.93),
                      itemBuilder: (context, index) {
                        return FolderCardBig(
                          title: snapshot.data!['folders'][index].toString(),
                          username: snapshot.data!['username'].toString(),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  QText(
                    text: 'Recommended',
                    color: Colors.white,
                    size: 14,
                    isBold: true,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: 7,
                controller: PageController(viewportFraction: 0.93),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, '/set'),
                    },
                    child: const SetCardBig(
                      title: '',
                      username: '',
                      terms: 1,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
