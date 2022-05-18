import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/services/auth.services.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final nameTextController = TextEditingController();
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const QText(
          text: "Quizzy",
          color: Colors.white,
          size: 30,
          isBold: true,
        ),
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
                  fontWeight: FontWeight.bold,
                ),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await AuthService().googleSignUp();
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/main',
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              'SIGN UP WITH GOOGLE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFormField(
                controller: nameTextController,
                style: const TextStyle(color: textColor),
                cursorColor: textColor,
                maxLength: 50,
                decoration: const InputDecoration(
                  helperText: 'Name',
                  hintStyle:
                      TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
                  hintText: "Abraham Lincoln",
                  helperStyle: TextStyle(color: textColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                  ),
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
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (emailTextController.text != '' &&
                              passwordTextController.text != '' &&
                              nameTextController.text != '') {
                            final emailResult = await AuthService().emailSignup(
                              nameTextController.text,
                              emailTextController.text,
                              passwordTextController.text,
                            );
                            if (emailResult == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: QText(
                                    text: 'The password provided is too weak',
                                    color: Colors.white,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: snackBarColor,
                                ),
                              );
                            }
                            if (emailResult == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: QText(
                                    text:
                                        'The account already exists for that email',
                                    color: Colors.white,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: snackBarColor,
                                ),
                              );
                            }
                            if (FirebaseAuth.instance.currentUser != null &&
                                mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/main',
                                (Route<dynamic> route) => false,
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: QText(
                                  text: 'Please fill in all fields',
                                  color: Colors.white,
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: snackBarColor,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
