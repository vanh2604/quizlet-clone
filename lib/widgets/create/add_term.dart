import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';

class AddTerm extends StatelessWidget {
  final TextEditingController termController;
  final TextEditingController defController;

  const AddTerm({
    Key? key,
    required this.termController,
    required this.defController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 8, 25),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: termController,
                    decoration: const InputDecoration(
                      helperText: 'Term',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      helperStyle: TextStyle(color: textColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: defController,
                    decoration: const InputDecoration(
                      helperText: 'Defenition',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      helperStyle: TextStyle(color: textColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
