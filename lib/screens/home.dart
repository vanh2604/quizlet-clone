import 'package:flutter/material.dart';
import 'package:quizlet/screens/homepage.dart';
import 'package:quizlet/screens/search.dart';
import 'package:quizlet/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  Widget getBody() {
    switch (currentIndex) {
      case 0:
        return const Home();
      case 1:
        return const SearchScreen();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
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
