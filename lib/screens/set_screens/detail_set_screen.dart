import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quizlet/widgets/app_text.dart';
import 'package:quizlet/widgets/flip_term_card.dart';
import 'package:quizlet/widgets/learn_custom_button.dart';

import '../../widgets/term_card.dart';

class DetailSetScreen extends StatefulWidget {
  const DetailSetScreen({Key? key}) : super(key: key);

  @override
  State<DetailSetScreen> createState() => _DetailSetScreenState();
}

class _DetailSetScreenState extends State<DetailSetScreen> {
  late PageController _questionController;
  int activeQuestion = 0;

  @override
  void initState() {
    super.initState();
    _questionController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    // Fake data
    final List<Map<String, dynamic>> _question = List.generate(10, (index) => {
      'username': 'Person #$index',
      'terms': Random().nextInt(100) + 1,
      'title': 'Title $index',
      'definition': 'Definition $index'
    });

    Map<String, dynamic> _setCard = {
      'username' : 'abc',
      'nameSet': 'Vocabulary',
      'avatar': ''
    };

    return Scaffold(
      backgroundColor: Color.fromRGBO(12, 12, 48, 1),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.9,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(30,100,10,30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // carousel card
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: (){
                          print(activeQuestion);
                        },
                        child: PageView.builder(
                          itemCount: _question.length,
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (question) {
                            setState(() {
                              activeQuestion = question;
                            });
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubic,
                              margin: EdgeInsets.only(right: 20),
                              child: FlipTermCard(title: _question[activeQuestion]['title'], definition: _question[activeQuestion]['definition'],),
                              // decoration: BoxDecoration(
                              //   color: const Color.fromRGBO(52, 58, 85, 1),
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              // child: Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     AppText(color: Colors.white, text: _question[activeQuestion]['title'],),
                              //   ],
                              // )

                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    // indicator
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: indicators(_question.length,activeQuestion)),

                    //title of set
                    AppText(text: _setCard['nameSet'], color: Colors.white, size: 30, isBold: true,),

                    // username and number of terms
                    Row(
                      children: [
                        Icon(Icons.build),
                        SizedBox(width: 10,),
                        AppText(text: _setCard["username"], color: Colors.white),
                      ],
                    ),

                    // grid view learn button, using table
                    Table(
                      children: [
                        TableRow(
                            children: [
                              LearnCustomButton(text: "Flashcard", icon: Icons.favorite),
                              LearnCustomButton(text: "Learn", icon: Icons.favorite)
                            ]
                        ),
                        TableRow(
                            children: [
                              LearnCustomButton(text: "Write", icon: Icons.favorite),
                              LearnCustomButton(text: "Test", icon: Icons.favorite)
                            ]
                        )
                      ],
                    ),
                    SizedBox(height: 20,),

                    // Term line
                    AppText(text: "Terms", color: Colors.white, isBold: true, size: 20,),
                    SizedBox(height: 10,),

                    //Terms card
                    for (var q in _question) TermCard(title: q['title'], definition: q['definition'])


                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            height: MediaQuery.of(context).size.height*0.05,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue
            ),
            child: Center(child: AppText(text: "Study this set", color: Colors.white,)),
          )
        ],
      )
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.white : const Color.fromRGBO(52, 58, 85, 1),
          shape: BoxShape.circle),
    );
  });
}
