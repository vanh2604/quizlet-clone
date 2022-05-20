import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:quizlet/widgets/sets/set_card.dart';

class SetsScreen extends StatefulWidget {
  const SetsScreen({Key? key}) : super(key: key);

  @override
  State<SetsScreen> createState() => _SetsScreenState();
}

class _SetsScreenState extends State<SetsScreen> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const QText(
          color: Colors.white,
          text: 'Sets',
          size: 30,
          isBold: true,
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getUserSetsStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot set = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/set',
                          arguments: {'setDetail': set.data(), 'setId': set.id},
                        );
                      },
                      child: SetCard(
                        title: set['name'].toString(),
                        username: set['username'].toString(),
                        terms: int.parse(set['cards'].length.toString()),
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
                );
        },
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
    );
  }
}
