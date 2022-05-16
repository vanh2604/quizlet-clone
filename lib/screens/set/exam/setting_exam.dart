import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet/data/card_data.dart';
import 'package:quizlet/screens/set/write/write_screen.dart';

import 'exam_screen.dart';

void main() => runApp(const SettingExam());

class SettingExam extends StatelessWidget {
  const SettingExam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(12, 12, 48, 1),
        ),
        body: Center(
          child: Setting(),
        ),
        backgroundColor: Color.fromRGBO(12, 12, 48, 1),
      ),
    );
  }
}

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  bool _isShowAnswer = false;
  bool _multichoice = true;
  bool _write = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExamScreen(
                                  listQuestion: questions,
                                  isMultichoice: _multichoice,
                                  isWrite: _write,
                                )));
                  },
                  child: const Text('Bat dau lam bai kiem tra'),
                ),
              ),
            ),
          ),
          Text(
            "General",
            style: TextStyle(color: Colors.grey),
          ),
          SwitchListTile(
            title: const Text(
              "Hien thi dap an ngay",
              style: TextStyle(color: Colors.white),
            ),
            value: _isShowAnswer,
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
            onChanged: (bool value) {
              setState(() {
                _isShowAnswer = value;
              });
            },
          ),
          Text(
            "Question type",
            style: TextStyle(color: Colors.grey),
          ),
          SwitchListTile(
            title: const Text(
              "Multichoice question",
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
                    builder: (_) => AlertDialog(
                          title: Text("Khong the thay doi cai dat"),
                          content: Text(
                              "Ban phai kich hoat it nhat mot loai cau hoi"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              } else {
                setState(() {
                  _multichoice = value;
                });
              }
            },
          ),
          SwitchListTile(
            title: const Text(
              "Tu luan",
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
                    builder: (_) => AlertDialog(
                          title: Text("Khong the thay doi cai dat"),
                          content: Text(
                              "Ban phai kich hoat it nhat mot loai cau hoi"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
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
