import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizlet/firebase_options.dart';
import 'package:quizlet/routes.dart';
import 'package:quizlet/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(400, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(900, name: TABLET),
          // const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        background: Container(color: const Color(0xFFF5F5F5)),
      ),
      title: 'Quizzy',
      initialRoute: '/',
      routes: appRoutes,
      theme: appTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
