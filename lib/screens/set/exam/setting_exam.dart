import 'package:flutter/material.dart';
import 'package:quizlet/model/card_model.dart';
import 'package:quizlet/screens/set/exam/exam_screen.dart';
import 'package:quizlet/utils/colors.dart';

// void main() => runApp(const SettingExam());

class SettingExam extends StatelessWidget {
  final List<CardModel2> listQuestion;
  const SettingExam({Key? key, required this.listQuestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/set'));
          },
        ),
      ),
      body: Center(
        child: Setting(listQuestion: listQuestion),
      ),
      backgroundColor: primaryColor,
    );
  }
}

class Setting extends StatefulWidget {
  final List<CardModel2> listQuestion;
  const Setting({Key? key, required this.listQuestion}) : super(key: key);

  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  bool _multichoice = true;
  bool _write = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExamScreen(
                            listQuestion: widget.listQuestion,
                            isMultichoice: _multichoice,
                            isWrite: _write,
                          ),
                        ),
                      );
                    },
                    child: const Text('Begin the exam'),
                  ),
                ),
              ),
            ),
          ),
          // const Text(
          //   "General",
          //   style: TextStyle(color: Colors.grey),
          // ),
          // SwitchListTile(
          //   title: const Text(
          //     "Show answer",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   value: _isShowAnswer,
          //   activeColor: Colors.white,
          //   activeTrackColor: Colors.blue,
          //   inactiveTrackColor: Colors.grey,
          //   onChanged: (bool value) {
          //     setState(() {
          //       _isShowAnswer = value;
          //     });
          //   },
          // ),
          // const Text(
          //   "Mode",
          //   style: TextStyle(color: Colors.grey),
          // ),
          SwitchListTile(
            title: const Text(
              "Multiple choices",
              style: TextStyle(color: Colors.white),
            ),
            value: _multichoice,
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
            onChanged: (bool value) {
              if (!_write && !value) {
                showDialog(
                  context: context,
                  builder: (_) => ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AlertDialog(
                      backgroundColor: primaryColor,
                      title: const Text("Not Allowed"),
                      content: const Text(
                        "At least one type of question must be activated",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                setState(() {
                  _multichoice = value;
                });
              }
            },
          ),
          SwitchListTile(
            title: const Text(
              "Writing",
              style: TextStyle(color: Colors.white),
            ),
            value: _write,
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
            onChanged: (bool value) {
              if (!_multichoice && !value) {
                showDialog(
                  context: context,
                  builder: (_) => ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AlertDialog(
                      backgroundColor: primaryColor,
                      title: const Text("Not Allowed"),
                      content: const Text(
                        "At least one type of question must be activated",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                setState(() {
                  _write = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
