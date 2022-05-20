import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/widgets/folders/folder_card.dart';
import 'package:quizlet/widgets/qtext.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({Key? key}) : super(key: key);

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  final FirestoreService firestoreService = FirestoreService();

  List<int> setsPerFolder = [];

  @override
  void initState() {
    firestoreService
        .getSetsNumberPerFolder()
        .then((value) => setState(() => setsPerFolder = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const QText(
          color: Colors.white,
          text: 'Folders',
          size: 30,
          isBold: true,
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: firestoreService.getUserInfo(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: setsPerFolder.isNotEmpty &&
                    snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done
                ? ListView.builder(
                    itemCount: int.parse(
                      snapshot.data!['folders'].length.toString(),
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/folder',
                            arguments: {
                              'name':
                                  snapshot.data!['folders'][index].toString()
                            },
                          );
                        },
                        child: FolderCard(
                          title: snapshot.data!['folders'][index].toString(),
                          username: snapshot.data!['username'].toString(),
                          sets: setsPerFolder[index],
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
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
    );
  }
}
