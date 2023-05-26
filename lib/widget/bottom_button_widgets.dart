import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';

class BottomButtonWidgets extends StatelessWidget {
  final String firstTxt;
  final String secondTxt;
  VoidCallback onBackPress;
  VoidCallback onNextPress;
  BottomButtonWidgets({Key? key,required this.onBackPress,required this.onNextPress,required this.firstTxt,required this.secondTxt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
              backgroundColor: AppColors.boxLineColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: onBackPress,
            child:
            SmallText(text: firstTxt.toUpperCase(), size: 18, color: Colors.white),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
              backgroundColor: AppColors.redColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: onNextPress,
            child:
            SmallText(text: secondTxt.toUpperCase(), size: 18, color: Colors.white),
          ),
        )
      ],
    );
  }
}
