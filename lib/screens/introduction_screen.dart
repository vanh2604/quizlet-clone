import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/screens/sign_in.dart';
import 'package:quizlet/screens/sign_up.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/quizzy-64099.appspot.com/o/quizlet-intro1.png?alt=media&token=aa5d9baf-699f-46a5-87d8-ac832694036a',
  'https://firebasestorage.googleapis.com/v0/b/quizzy-64099.appspot.com/o/quizzy_intro2.png?alt=media&token=85ad2213-3322-4e2d-aaa2-8f094163deec',
  'https://firebasestorage.googleapis.com/v0/b/quizzy-64099.appspot.com/o/quizzy_intro3.png?alt=media&token=cc638a96-6afe-41b2-a48f-670bae17afb1'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff2A2D3F),
        child: Container(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 30),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Quizzy",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 50, 10, 20),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Search millions of \n flashcard sets",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const SignUp()));
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ))
                  ],
                ),
              ),
            ])));
  }
}
