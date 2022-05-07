import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

final List<String> imgList = [
  'assets/quizzy_intro1.png',
  'assets/quizzy_intro2.png',
  'assets/quizzy_intro3.png'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
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
    return Scaffold(
        appBar: AppBar(
          title: const QText(
              text: "Quizzy", color: Colors.white, size: 30, isBold: true),
          centerTitle: false,
          elevation: 0,
          backgroundColor: introBackgroundColor,
        ),
        body: Container(
            color: introBackgroundColor,
            child: Container(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(children: <Widget>[
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
                    padding: const EdgeInsets.fromLTRB(0, 55, 10, 20),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signup'),
                              child: const Text(
                                'Sign up for free',
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/signin'),
                              child: const Text(
                                'Or log in',
                                style: TextStyle(
                                  color: Color(0xFF656B86),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ]),
                  ),
                ]))));
  }
}
