import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadWidgets extends StatelessWidget {
  final String imgUri;
  final String txt;
  Color bgColor;
  GestureTapCallback onTap;
  UploadWidgets({Key? key,required this.imgUri,required this.txt,required this.onTap,required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: onTap,
        child: DottedBorder(
          padding: const EdgeInsets.all(15),
          color: AppColors.greyColor,
          radius: const Radius.circular(5),
          borderType: BorderType.RRect,
          strokeWidth: 2,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                SvgPicture.asset(imgUri,
                    height: 15, width: 15,color: AppColors.greyColor,),
                const SizedBox(width: 8),
                Expanded(
                  child: SmallText(
                      text: txt,
                      size: 14,
                      color: AppColors.greyColor),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
