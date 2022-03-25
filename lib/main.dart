import 'package:flutter/material.dart';
import 'package:quizlet/screens/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizlet',
      theme: ThemeData(
        fontFamily: "GoogleSans",
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(
                66, 86, 255, 1), // background (button) color
            onPrimary: Colors.black, // foreground (text) color
          ),
        ),
      ),
      home: const Scaffold(
        body: SignIn(),
      ),
    );
  }
}
