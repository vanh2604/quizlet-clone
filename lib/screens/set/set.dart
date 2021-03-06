import 'package:flutter/material.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/exam/setting_exam.dart';
import 'package:quizlet/screens/set/flash_card/flash_card_screen.dart';
import 'package:quizlet/screens/set/learn/learn_screen.dart';
import 'package:quizlet/screens/set/write/write_screen.dart';
import 'package:quizlet/services/firestore.services.dart';
import 'package:quizlet/services/user.services.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/utils/random.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:quizlet/widgets/set/flip_term_card.dart';
import 'package:quizlet/widgets/set/learn_custom_button.dart';
import 'package:quizlet/widgets/set/term_card.dart';

class SetScreen extends StatefulWidget {
  const SetScreen({Key? key}) : super(key: key);

  @override
  State<SetScreen> createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  // late PageController _questionController;
  int activeQuestion = 0;

  bool initialized = false;
  bool userVerified = false;
  Map<dynamic, dynamic> _setCard = {};
  String _setId = '';
  List _question = [];
  List<CardModel2> questionList = [];
  Map<String, dynamic> arguments = {};

  final FirestoreService firestoreService = FirestoreService();
  final UserService userService = UserService();

  List<CardModel2> getQuestion(List question) {
    final List<CardModel2> questionList = [];
    for (int i = 0; i < question.length; i++) {
      final randomNumber =
          getRandomDifferentThreeNumberInRange(0, question.length, i);
      final List<String> answers = [
        question[i].key.toString(),
        question[randomNumber[0]].key.toString(),
        question[randomNumber[1]].key.toString(),
        question[randomNumber[2]].key.toString(),
      ];
      answers.shuffle();
      questionList.add(
        CardModel2(
          question[i].value.toString(),
          question[i].key.toString(),
          answers,
        ),
      );
    }
    return questionList;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        arguments =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      });
      initialized = true;
      _setCard = arguments['setDetail'] as Map<dynamic, dynamic>;
      _setId = arguments['setId'] as String;
      _question =
          arguments['setDetail']['cards'].entries.toList() as List<dynamic>;
      questionList = getQuestion(_question);
      userService
          .userVerify(_setCard['uid'].toString())
          .then((value) => userVerified = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (!initialized) {
    //   setState(() {
    //     initialized = true;
    //     final Map<String, dynamic> arguments =
    //         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    //     _setCard = arguments['setDetail'] as Map<dynamic, dynamic>;
    //     _setId = arguments['setId'] as String;
    //     _question =
    //         arguments['setDetail']['cards'].entries.toList() as List<dynamic>;
    //     questionList = getQuestion(_question);
    //     userService
    //         .userVerify(_setCard['uid'].toString())
    //         .then((value) => userVerified = value);
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 10, 30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: GestureDetector(
                                onTap: () {
                                  // print(activeQuestion);
                                },
                                child: PageView.builder(
                                  itemCount: int.parse(
                                    _question.length.toString(),
                                  ),
                                  onPageChanged: (question) {
                                    setState(() {
                                      activeQuestion = question;
                                    });
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOutCubic,
                                      margin: const EdgeInsets.only(right: 20),
                                      child: FlipTermCard(
                                        title: _question[activeQuestion]
                                            .key
                                            .toString(),
                                        definition: _question[activeQuestion]
                                            .value
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (_question.length < 30) ...[
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: indicators(
                                    _question.length,
                                    activeQuestion,
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            QText(
                              text: _setCard['name'].toString(),
                              color: Colors.white,
                              size: 30,
                              isBold: true,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (userVerified)
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/update',
                                    arguments: {
                                      'setDetail': _setCard,
                                      'setId': _setId
                                    },
                                  ).then((value) {
                                    setState(() {
                                      firestoreService.getSet(_setId).then(
                                        (value) {
                                          _setCard = value;
                                          _question = _setCard['cards']
                                              .entries
                                              .toList() as List<dynamic>;
                                          questionList = getQuestion(_question);
                                        },
                                      );
                                    });
                                  });
                                },
                                child: const Icon(Icons.edit),
                              )
                            else
                              Container()
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.person_rounded),
                            const SizedBox(
                              width: 10,
                            ),
                            QText(
                              text: _setCard["username"].toString(),
                              color: Colors.white,
                            ),
                          ],
                        ),

                        // grid view learn button, using table
                        Table(
                          children: [
                            TableRow(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FlashCardScreen(
                                          listQuestions: questionList,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const LearnCustomButton(
                                    text: "Flashcard",
                                    icon: Icons.card_membership_rounded,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LearnScreen(
                                          questionLearn: questionList,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const LearnCustomButton(
                                    text: "Learn",
                                    icon: Icons.check_box_rounded,
                                  ),
                                )
                              ],
                            ),
                            TableRow(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return WriteScreen(
                                            question2s: questionList,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: const LearnCustomButton(
                                    text: "Write",
                                    icon: Icons.edit_rounded,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingExam(
                                          listQuestion: questionList,
                                        ),
                                      ),
                                    ),
                                  },
                                  child: const LearnCustomButton(
                                    text: "Exam",
                                    icon: Icons.import_contacts_rounded,
                                  ),
                                )
                              ],
                            )
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
                          TermCard(
                            title: q.key.toString(),
                            definition: q.value.toString(),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: QText(
                    text: "Study this set",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> indicators(int length, int currentIndex) {
  return List<Widget>.generate(length, (index) {
    return Container(
      margin: const EdgeInsets.all(2),
      width: 8,
      height: 10,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? Colors.white
            : const Color.fromRGBO(52, 58, 85, 1),
        shape: BoxShape.circle,
      ),
    );
  });
}
