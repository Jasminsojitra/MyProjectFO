import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double size;
  final Color color;

  const SmallText(
      {Key? key,
      required this.text,
      this.fontWeight = FontWeight.bold,
      required this.size,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: 'Helvetica',
          overflow: TextOverflow.ellipsis),
    );
  }
}
