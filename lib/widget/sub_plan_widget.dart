import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SubPlanWidget extends StatelessWidget {
  final Color bgColor;
  final String mainText;
  final String priceText;
  final String svgPicture;

  const SubPlanWidget({Key? key, required this.bgColor, required this.mainText, required this.priceText, required this.svgPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              bgColor.withOpacity(0.58),
              bgColor
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                        text: mainText,
                        size: 18,
                        color: Colors.white),
                    const SizedBox(height: 30),
                    BigText(
                        text: priceText,
                        color: Colors.black,
                        weight: FontWeight.bold)
                  ],
                ),
                SvgPicture.asset(svgPicture)
              ],
            ),
          ),
          SmallText(text: 'sub_des'.tr, size: 12, color: Colors.white,fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}
