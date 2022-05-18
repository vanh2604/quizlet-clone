import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:quizlet/widgets/sets/set_card.dart';

class SetsScreen extends StatefulWidget {
  const SetsScreen({Key? key}) : super(key: key);

  @override
  State<SetsScreen> createState() => _SetsScreenState();
}

class _SetsScreenState extends State<SetsScreen> {
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
        stream: getUserSetsStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot set = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/set',
                            arguments: {'setDetail': set.data()});
                      },
                      child: SetCard(
                        title: set['name'],
                        username: set['username'],
                        terms: set['cards'].length,
                      ),
                    );
                  },
                )
              : const CircularProgressIndicator();
        },
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
    );
  }
}
