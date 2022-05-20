import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/services/auth.services.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const QText(
          text: "Forget Password",
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
                          if (emailTextController.text != '') {
                            final emailResult =
                                await AuthService().forgetPassword(
                              emailTextController.text,
                            );
                            if (emailResult == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: QText(
                                    text: "User with that email doesn't exist.",
                                    color: Colors.white,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: snackBarColor,
                                ),
                              );
                            }
                            if (emailResult == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: QText(
                                    text: 'Password reset link has been sent.',
                                    color: Colors.white,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: snackBarColor,
                                ),
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
                          'RESET PASSWORD',
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
