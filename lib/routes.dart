import 'package:quizlet/screens/standby/standby.dart';
import 'package:quizlet/screens/introduction/introduction.dart';
import 'package:quizlet/screens/sign_up/sign_up.dart';
import 'package:quizlet/screens/sign_in/sign_in.dart';
import 'package:quizlet/screens/main/main.dart';
import 'package:quizlet/screens/set/sets.dart';
import 'package:quizlet/screens/set/set.dart';
// import 'package:quizlet/screens/folder/folder.dart';

var appRoutes = {
  '/': (context) => const StandbyScreen(),
  '/introduction': (context) => const IntroductionScreen(),
  '/signup': (context) => const SignUpScreen(),
  '/signin': (context) => const SignInScreen(),
  '/main': (context) => const MainScreen(),
  '/set': (context) => const SetScreen(),
  '/sets': (context) => const SetsScreen(),
  //'/folder': (context) => const FolderScreen(),
};
