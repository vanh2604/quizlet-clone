import 'package:flutter/material.dart';
import 'package:quizlet/services/auth.services.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const QText(
            text: "Quizzy", color: Colors.white, size: 30, isBold: true),
        centerTitle: false,
        elevation: 0,
        backgroundColor: authThemeColor,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: authThemeColor,
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
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                        onPressed: () async {
                          await AuthService().googleLogin();
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/main', (Route<dynamic> route) => false);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                'assets/google.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                            const Text(
                              'LOGIN WITH GOOGLE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ))
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
                  controller: emailTextController,
                  style: const TextStyle(color: textColor),
                  cursorColor: textColor,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    helperText: 'Email',
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
                    hintText: "example@email.com",
                    helperStyle: TextStyle(color: textColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                  ),
                ),
                TextFormField(
                  controller: passwordTextController,
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
                        onPressed: () async {
                          await AuthService().emailLogin(
                              emailTextController.text,
                              passwordTextController.text);
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/main', (Route<dynamic> route) => false);
                          }
                        },
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
