import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/widgets/sets/set_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Stream<QuerySnapshot> _stream = const Stream<QuerySnapshot>.empty();
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    _stream = firestoreService.findSetsStream("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Search a term ...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _stream = firestoreService.findSetsStream(value);
                          return;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot set =
                              snapshot.data!.docs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/set',
                                arguments: {
                                  'setDetail': set.data(),
                                  'setId': set.id
                                },
                              );
                            },
                            child: SetCard(
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
              ),
            ),
          ],
        );
      },
    );
  }
}
