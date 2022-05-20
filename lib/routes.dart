// ignore_for_file: implementation_imports

import 'package:flutter/src/widgets/framework.dart';
import 'package:quizlet/screens/forget_password/forget_password.dart';
import 'package:quizlet/screens/introduction/introduction.dart';
import 'package:quizlet/screens/main/create/create.dart';
import 'package:quizlet/screens/main/main.dart';
import 'package:quizlet/screens/set/set.dart';
import 'package:quizlet/screens/set/sets.dart';
import 'package:quizlet/screens/sign_in/sign_in.dart';
import 'package:quizlet/screens/sign_up/sign_up.dart';
import 'package:quizlet/screens/standby/standby.dart';

Map<String, Widget Function(dynamic context)> appRoutes = {
  '/': (context) => const StandbyScreen(),
  '/introduction': (context) => const IntroductionScreen(),
  '/signup': (context) => const SignUpScreen(),
  '/signin': (context) => const SignInScreen(),
  '/forget': (context) => const ForgetPasswordScreen(),
  '/main': (context) => const MainScreen(),
  '/create': (context) => const CreateScreen(),
  '/set': (context) => const SetScreen(),
  '/sets': (context) => const SetsScreen(),
};
