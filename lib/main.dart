import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/screens/folder_screen.dart';
import 'package:quizlet/screens/set_screens/detail_set_screen.dart';
import 'package:quizlet/screens/set_screens/set_screen.dart';
import 'package:quizlet/screens/standby_screen.dart';

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
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
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
        body: StandbyScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
