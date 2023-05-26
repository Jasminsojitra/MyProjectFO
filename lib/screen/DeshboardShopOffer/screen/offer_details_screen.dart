import 'package:festum_evento/screen/DeshboardShopOffer/Fragment/offers_attendee_fragment.dart';
import 'package:festum_evento/screen/DeshboardShopOffer/Fragment/offers_overview_fragment.dart';
import 'package:festum_evento/screen/DeshboardShopOffer/Fragment/offers_review_fragment.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersDetilsScreen extends StatefulWidget {
  const OffersDetilsScreen({Key? key}) : super(key: key);

  @override
  State<OffersDetilsScreen> createState() => _OffersDetilsScreenState();
}

class _OffersDetilsScreenState extends State<OffersDetilsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    controller.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: AppBar(
        leading: InkWell(
          highlightColor: Colors.transparent,
          child: Image.asset("assets/png/ic_back.png", width: 24, height: 24),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const SmallText(
            text: "M4M Fashion", size: 20, color: Colors.white),
        backgroundColor: AppColors.appColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        bottom: TabBar(
            controller: controller,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColors.redColor,
            tabs: <Widget>[
              Tab(
                child: SmallText(
                    text: 'overview'.tr,
                    size: 16,
                    color: controller.index == 0
                        ? AppColors.redColor
                        : Colors.white.withOpacity(0.5)),
              ),
              Tab(
                child: SmallText(
                    text: 'attendee'.tr,
                    size: 16,
                    color: controller.index == 1
                        ? AppColors.redColor
                        : Colors.white.withOpacity(0.5)),
              ),
              Tab(
                child: SmallText(
                    text: 'review'.tr,
                    size: 16,
                    color: controller.index == 2
                        ? AppColors.redColor
                        : Colors.white.withOpacity(0.5)),
              ),
            ]),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          OffersOverviewFragment(),
          OffersAttendeeFragment(),
          OffersReviewFragment()
        ],
      ),
    );
  }
}
