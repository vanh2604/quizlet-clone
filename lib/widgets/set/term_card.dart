import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TermCard extends StatelessWidget {
  final String title;
  final String definition;
  const TermCard({Key? key, required this.title, required this.definition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 15),
      //height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(52, 58, 85, 1),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * (0.6),
                  child: AutoSizeText(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const Icon(Icons.favorite_border),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AutoSizeText(
                definition,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
