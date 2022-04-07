import 'package:flutter/material.dart';
import 'package:quizlet/widgets/qtext.dart';
import 'package:quizlet/screens/main/home.dart';
import 'package:quizlet/screens/main/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget getBody() {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SearchScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const QText(
            text: "Quizzy", color: Colors.white, size: 30, isBold: true),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        selectedItemColor: const Color.fromRGBO(130, 138, 207, 1),
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        showSelectedLabels: false, // <-- HERE
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Music',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Places',
            icon: Icon(Icons.add_circle_rounded),
          ),
          BottomNavigationBarItem(
            label: 'News',
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: getBody(),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
    );
  }
}
