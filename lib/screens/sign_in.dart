import 'package:flutter/material.dart';
import 'package:quizlet/utils/colors.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

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
                      Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/quizzy-64099.appspot.com/o/Apple.png?alt=media&token=c1c23fde-6340-4832-994d-540aaf795192',
                          width: 50,
                          height: 50),
                      Container(
                        margin: const EdgeInsets.only(left: 45, right: 45),
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/quizzy-64099.appspot.com/o/Facebook.png?alt=media&token=da623fe6-d4e5-4a13-a4ed-fbaf4daeb411',
                            width: 50,
                            height: 50),
                      ),
                      Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/quizzy-64099.appspot.com/o/Google.png?alt=media&token=7727d5a3-8a82-4382-872d-44eb70cc15fdr',
                          width: 50,
                          height: 50)
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
