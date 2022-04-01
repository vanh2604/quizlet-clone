import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkThemeColor,
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
                      Image.asset('apple.png', width: 50, height: 50),
                      Container(
                        margin: const EdgeInsets.only(left: 45, right: 45),
                        child:
                            Image.asset('facebook.png', width: 50, height: 50),
                      ),
                      Image.asset('google.png', width: 50, height: 50)
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
                  style: const TextStyle(color: textColor),
                  cursorColor: textColor,
                  maxLength: 20,
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
                        onPressed: () {},
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
