import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectFood extends StatefulWidget {
  String img;
  String txtName;
  bool isSelect = false;

  SelectFood(
      {Key? key,
      required this.img,
      required this.txtName,
      required this.isSelect})
      : super(key: key);

  @override
  State<SelectFood> createState() => _SelectFoodState();
}

class _SelectFoodState extends State<SelectFood> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: widget.isSelect
              ? Border.all(width: 2, color: AppColors.greenColor)
              : Border.all(width: 0, color: Colors.transparent)),
      child: Column(
        children: [
          SvgPicture.asset(widget.img, height: 25, width: 25),
          const SizedBox(height: 10),
          SmallText(text: widget.txtName, size: 12, color: Colors.black)
        ],
      ),
    );
  }
}
