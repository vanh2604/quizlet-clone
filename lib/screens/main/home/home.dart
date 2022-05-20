import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/utils/colors.dart';
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
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: QText(
                        text: "Create set using the create button below.",
                        color: textColor,
                      ),
                    );
                  }
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: snapshot.hasData
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
                        : const Center(
                            child: SizedBox(
                              height: 50,
                              child: LoadingIndicator(
                                indicatorType: Indicator.lineScaleParty,
                                colors: [Colors.white],
                                strokeWidth: 2,
                              ),
                            ),
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
                    size: 14,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 170,
              child: FutureBuilder<DocumentSnapshot>(
                future: getUserInfo(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done
                        ? PageView.builder(
                            controller: PageController(viewportFraction: 0.93),
                            itemCount: int.parse(
                              snapshot.data!['folders'].length.toString(),
                            ),
                            itemBuilder: (_, index) {
                              return FolderCardBig(
                                title:
                                    snapshot.data!['folders'][index].toString(),
                                username: snapshot.data!['username'].toString(),
                              );
                            },
                          )
                        : const Center(
                            child: SizedBox(
                              height: 50,
                              child: LoadingIndicator(
                                indicatorType: Indicator.lineScaleParty,
                                colors: [Colors.white],
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                  );
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
              child: StreamBuilder<QuerySnapshot>(
                stream: getRecommendedSetsStream(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: snapshot.hasData
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
                        : const Center(
                            child: SizedBox(
                              height: 50,
                              child: LoadingIndicator(
                                indicatorType: Indicator.lineScaleParty,
                                colors: [Colors.white],
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
