import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';

class NavListWidget extends StatelessWidget {
  final Image firstIcon;
  final Image lastIcon;
  final String text;
  const NavListWidget({Key? key, required this.firstIcon, required this.lastIcon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.greyColor,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ListTile(
                leading: firstIcon,
                trailing: lastIcon,
                title: SmallText(text: text, size: 16, color: Colors.black),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
