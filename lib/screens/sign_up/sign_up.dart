import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                  'QUICKLY SIGN UP WITH',
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
                    'OR CREATE AN ACCOUNT',
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
                  margin: const EdgeInsets.only(top: 250),
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
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailTextController.text,
                              password: passwordTextController.text,
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/main', (Route<dynamic> route) => false);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text(
                          'SIGN UP',
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
