import 'package:flutter/material.dart';
import 'package:quizlet/screens/main/home/home.dart';
import 'package:quizlet/screens/main/search/search.dart';
import 'package:quizlet/screens/main/user/user.dart';
import 'package:quizlet/services/seed.services.dart';
import 'package:quizlet/widgets/qtext.dart';

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
      case 2:
        return const HomeScreen();
      case 3:
        return const UserScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => seedDatabase(),
          child: const QText(
            text: "Quizzy",
            color: Colors.white,
            size: 30,
            isBold: true,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
        selectedItemColor: const Color.fromRGBO(130, 138, 207, 1),
        unselectedItemColor: Colors.white.withOpacity(.60),
        unselectedFontSize: 14,
        currentIndex: currentIndex,
        onTap: (int index) {
          if (mounted) {
            setState(() {
              currentIndex = index;
            });
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Create',
            icon: Icon(Icons.add_circle_rounded),
          ),
          BottomNavigationBarItem(
            label: 'User',
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: getBody(),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
    );
  }
}
