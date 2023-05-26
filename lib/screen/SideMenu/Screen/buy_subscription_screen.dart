import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/sub_plan_widget.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuySubscriptionScreen extends StatefulWidget {
  const BuySubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<BuySubscriptionScreen> createState() => _BuySubscriptionScreenState();
}

class _BuySubscriptionScreenState extends State<BuySubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
      body: Column(
        children: [
          ToolbarWidget(
              text: 'my_subscription'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child:ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubPlanWidget(
                        bgColor: AppColors.greenColor,
                        mainText: 'local_offer_month'.tr,
                        priceText: '\$48.00',
                        svgPicture: 'assets/svg/ic_plan_gift.svg'),
                    const SizedBox(height: 10),
                    SubPlanWidget(
                        bgColor: AppColors.redColor,
                        mainText: 'event_subscription'.tr,
                        priceText: '\$56.00',
                        svgPicture: 'assets/svg/ic_plan_event_sub.svg'),
                    const SizedBox(height: 10),
                    SubPlanWidget(
                        bgColor: AppColors.yellowColor,
                        mainText: 'live_stream_subscription'.tr,
                        priceText: '\$120.00',
                        svgPicture: 'assets/svg/ic_plan_live.svg'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
