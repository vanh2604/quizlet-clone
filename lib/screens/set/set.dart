import 'package:flutter/material.dart';
import 'package:quizlet/screens/set/flash_card/flash_card_screen.dart';
import 'package:quizlet/screens/set/learn/learn_screen.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:quizlet/widgets/set/flip_term_card.dart';
import 'package:quizlet/widgets/set/learn_custom_button.dart';
import 'package:quizlet/widgets/set/term_card.dart';

import '../../data/card_data.dart';

class SetScreen extends StatefulWidget {
  const SetScreen({Key? key}) : super(key: key);

  @override
  State<SetScreen> createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  late PageController _questionController;
  int activeQuestion = 0;

  @override
  void initState() {
    super.initState();
    _questionController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    // set details
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    Map<dynamic, dynamic> _setCard = arguments['setDetail'];
    final List _question = arguments['setDetail']['cards'].entries.toList();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        ),
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 10, 30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {
                            print(activeQuestion);
                          },
                          child: PageView.builder(
                            itemCount: arguments['setDetail']['cards'].length,
                            pageSnapping: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (question) {
                              setState(() {
                                activeQuestion = question;
                              });
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOutCubic,
                                margin: const EdgeInsets.only(right: 20),
                                child: FlipTermCard(
                                  title: _question[activeQuestion].key,
                                  definition: _question[activeQuestion].value,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              indicators(_question.length, activeQuestion)),

                      QText(
                        text: _setCard['name'],
                        color: Colors.white,
                        size: 30,
                        isBold: true,
                      ),

                      Row(
                        children: [
                          const Icon(Icons.build),
                          const SizedBox(
                            width: 10,
                          ),
                          QText(
                              text: _setCard["username"], color: Colors.white),
                        ],
                      ),

                      // grid view learn button, using table
                      Table(
                        children: [
                          TableRow(children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FlashCardScreen(),
                                    ));
                              },
                              child: LearnCustomButton(
                                  text: "Flashcard",
                                  icon: Icons.card_membership_rounded),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LearnScreen(
                                        questionLearn: questions,
                                      ),
                                    ));
                              },
                              child: LearnCustomButton(
                                  text: "Learn", icon: Icons.check_box_rounded),
                            )
                          ]),
                          TableRow(children: [
                            LearnCustomButton(
                                text: "Write", icon: Icons.edit_rounded),
                            LearnCustomButton(
                                text: "Exam",
                                icon: Icons.import_contacts_rounded),
                          ])
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      const QText(
                        text: "Terms",
                        color: Colors.white,
                        isBold: true,
                        size: 20,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      for (var q in _question)
                        TermCard(title: q.key, definition: q.value)
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: const Center(
                    child: QText(
                  text: "Study this set",
                  color: Colors.white,
                )),
              )
            ],
          ),
        )));
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.white
              : const Color.fromRGBO(52, 58, 85, 1),
          shape: BoxShape.circle),
    );
  });
}
