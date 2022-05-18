import 'package:flutter/material.dart';

class QText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final bool isBold;

  const QText({
    Key? key,
    required this.text,
    required this.color,
    this.size = 16,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'GoogleSans',
        color: color,
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
