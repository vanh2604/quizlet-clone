import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const QText(
            text: "Quizzy", color: Colors.white, size: 30, isBold: true),
        centerTitle: false,
        elevation: 0,
        backgroundColor: darkThemeColor,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: darkThemeColor,
      body: Container(
          margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'QUICKLY LOGIN WITH',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: Image.asset('assets/facebook.png',
                            width: 50, height: 50),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          child: Image.asset('assets/google.png',
                              width: 50, height: 50))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Text(
                    'OR LOGIN IN',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  style: const TextStyle(color: textColor),
                  cursorColor: textColor,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    helperText: 'Email',
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
                    hintText: "example@emai.com",
                    helperStyle: TextStyle(color: textColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: textColor,
                  maxLength: 20,
                  obscureText: true,
                  style: const TextStyle(color: textColor),
                  decoration: const InputDecoration(
                    helperText: 'Password',
                    hintText: "create password",
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
                    helperStyle: TextStyle(color: textColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 240),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                        onPressed: () {},
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
