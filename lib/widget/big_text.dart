import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  const BigText({Key? key,required this.text,required this.color,this.size = 30,required this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color,fontSize: size,fontWeight: weight,fontFamily:'Helvetica'),
    );
  }
}
