import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback callback;
  final Color bgColor;
  final String text;

  const ButtonWidget(
      {Key? key,
      required this.callback,
      required this.bgColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.maxFinite, 50),
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )),
        onPressed: callback,
        child: Text(text.toUpperCase(),
            style:const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,fontFamily:'Helvetica')
        )
    );
  }
}
