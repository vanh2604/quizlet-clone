import 'package:flutter/material.dart';
import 'package:quizlet/data/card_data.dart';
import 'package:quizlet/data/fake_data.dart';
import 'package:quizlet/screens/set/flash_card/flash_card_screen.dart';
import 'package:quizlet/screens/set/learn/learn_screen.dart';
import 'package:quizlet/utils/colors.dart';
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

  @override
  void initState() {
    super.initState();
    // _questionController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final Map<dynamic, dynamic> _setCard =
        arguments['setDetail'] as Map<dynamic, dynamic>;
    final List _question =
        arguments['setDetail']['cards'].entries.toList() as List<dynamic>;

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
                                    arguments['setDetail']['cards']
                                        .length
                                        .toString(),
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
                        QText(
                          text: _setCard['name'].toString(),
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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const FlashCardScreen(),
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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LearnScreen(
                                          questionLearn: question2s,
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
                            const TableRow(
                              children: [
                                LearnCustomButton(
                                  text: "Write",
                                  icon: Icons.edit_rounded,
                                ),
                                LearnCustomButton(
                                  text: "Exam",
                                  icon: Icons.import_contacts_rounded,
                                ),
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
