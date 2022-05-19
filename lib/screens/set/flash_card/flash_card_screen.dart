import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet/screens/set/flash_card/card_provider.dart';
import 'package:quizlet/screens/set/flash_card/swipe_card.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class FlashCardScreen extends StatelessWidget {
  const FlashCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardProvider>(context);
    final isEmpty = provider.isEmptyListData();
    final understandCount = provider.understandCount;
    final dontunderstandCount = provider.dontUnderstandCount;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 48, 1),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: Column(
            children: [
              // progress bar
              Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: buildProgressBar(),
              ),
              const SizedBox(
                height: 40,
              ),
              // swipe card
              Flexible(
                child: !isEmpty
                    ? buildCards()
                    : buildEndCard(
                        understandCount: understandCount,
                        dontUnderstandCount: dontunderstandCount,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              // count when pan left or pan right
              buildTermCount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;
    return Stack(
      children: urlImages
          .map(
            (urlImage) => SwipeCard(
              urlImage: urlImage,
              isFront: urlImages.last == urlImage,
            ),
          )
          .toList(),
    );
  }

  Widget buildEndCard({
    required int understandCount,
    required int dontUnderstandCount,
  }) {
    final String line1 =
        understandCount == (understandCount + dontUnderstandCount)
            ? "Chuc mung ban"
            : "Ban co the lam dc";
    final String line2 =
        understandCount == (understandCount + dontUnderstandCount)
            ? "Ban hoc het ca noi dung roi"
            : "Ban vua hoc $understandCount "
                " thuat ngu, chi con $dontUnderstandCount "
                " thuat ngu thoi";
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(52, 58, 85, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QText(text: line1, color: Colors.white),
              const SizedBox(
                height: 20,
              ),
              QText(text: line2, color: Colors.white),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(140, 137, 204, 1),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>const FlashCardScreen()));
                    final provider =
                        Provider.of<CardProvider>(context, listen: false);
                    provider.resetList();
                  },
                  child: const QText(
                    text: 'Hoc lai',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          //child: FlipTermCard(definition:"",title:""),
        ),
      ),
    );
  }

  Widget buildProgressBar() {
    final provider = Provider.of<CardProvider>(context);
    final totalCard = provider.totalCard;
    final currentIndexCard = provider.getOrderCurrentIndexCard();
    return Center(
      child: Column(
        children: [
          QText(
            text: "$currentIndexCard/${totalCard - 1}",
            color: Colors.white,
          ),
          const SizedBox(
            height: 50,
          ),
          LinearProgressIndicator(
            backgroundColor: const Color.fromRGBO(71, 71, 94, 1),
            valueColor:
                const AlwaysStoppedAnimation(Color.fromRGBO(140, 137, 204, 1)),
            value: currentIndexCard / (totalCard - 1),
          )
        ],
      ),
    );
  }

  Widget buildTermCount() {
    final provider = Provider.of<CardProvider>(context);
    final understandCount = provider.understandCount;
    final dontunderstandCount = provider.dontUnderstandCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
            color: Colors.orange,
          ),
          child: Center(
            child: QText(
              color: Colors.black,
              text: dontunderstandCount.toString(),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
            color: Colors.green,
          ),
          child: Center(
            child: QText(
              color: Colors.white,
              text: understandCount.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
