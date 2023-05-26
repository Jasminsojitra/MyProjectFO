import 'package:festum_evento/screen/SideMenu/screen/buy_subscription_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(child: AppBar(elevation: 0), preferredSize: const Size(0, 0)),
      body: Column(
        children: [
          ToolbarWidget(
              text: 'my_subscription'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 20,right: 20),
              children: [
                Center(child: SvgPicture.asset("assets/svg/ic_subscription.svg")),
                const SizedBox(height: 20),
                Center(child: BigText(
                    text: 'current_subscription'.tr,
                    color: Colors.black,
                    weight: FontWeight.bold)),
                const SizedBox(height: 15),
                Center(
                  child: SmallText(
                      text: 'subcription_des'.tr,
                      color: AppColors.greyColor,
                      size: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuySubscriptionScreen()));
                    },
                    bgColor: AppColors.redColor,
                    text: 'buy_now'.tr)
              ],
            ),
          )
        ],
      ),
    );
  }
}
