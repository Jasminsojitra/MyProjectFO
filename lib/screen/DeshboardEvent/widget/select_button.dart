import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  String name;
  int isSelected = 0;
  bool isBodered = false;
  BorderRadiusGeometry borderRadiusGeometry;

  SelectButton({Key? key,required this.name,required this.borderRadiusGeometry,required this.isSelected,required this.isBodered}) : super(key: key);

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: widget.borderRadiusGeometry,
          color: widget.isSelected == true
              ? AppColors.redColor
              : Colors.white),
      child: Center(
          child: SmallText(text: widget.name, size: 16, color: widget.isSelected == true
              ? Colors.white
              : Colors.black)),
    );
  }
}
