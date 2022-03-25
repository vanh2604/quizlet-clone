import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/screens/standby_sceen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return MaterialApp(
      title: 'Quizzy',
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const Scaffold(
        body: StandbyScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
