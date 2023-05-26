import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToolbarWidget extends StatelessWidget {
  final String text;
  Color bgColor;
  Color txtColor;
  Color iconColor;
  GestureTapCallback tapCallback;

  ToolbarWidget(
      {Key? key,
      required this.text,
      required this.tapCallback,
      this.bgColor = Colors.white,
      this.txtColor = Colors.black,
      this.iconColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 65,
        color: bgColor,
        width: double.maxFinite,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: tapCallback,
                child: SvgPicture.asset("assets/svg/ic_back_arrow.svg",
                    height: 18, width: 22,color: iconColor),
              ),
            ),
            Center(
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: iconColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ));
  }
}
