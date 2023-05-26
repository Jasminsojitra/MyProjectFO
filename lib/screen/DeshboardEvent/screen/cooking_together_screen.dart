import 'package:festum_evento/screen/DeshboardEvent/Fragment/ReviewFragment.dart';
import 'package:festum_evento/screen/DeshboardEvent/Fragment/attendee_fragment.dart';
import 'package:festum_evento/screen/DeshboardEvent/Fragment/overview_fragment.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CookingTogetherScreen extends StatefulWidget {
  const CookingTogetherScreen({Key? key}) : super(key: key);

  @override
  State<CookingTogetherScreen> createState() => _CookingTogetherScreenState();
}

class _CookingTogetherScreenState extends State<CookingTogetherScreen>
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
      appBar: AppBar(
        leading: InkWell(
          highlightColor: Colors.transparent,
          child: Image.asset("assets/png/ic_back.png", width: 24, height: 24),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: SmallText(
            text: 'cooking_together'.tr, size: 20, color: Colors.white),
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
                    text: 'overview'.tr.toUpperCase(),
                    size: 16,
                    color: controller.index == 0
                        ? AppColors.redColor
                        : Colors.white.withOpacity(0.5)),
              ),
              Tab(
                child: SmallText(
                    text: 'attendee'.tr.toUpperCase(),
                    size: 16,
                    color: controller.index == 1
                        ? AppColors.redColor
                        : Colors.white.withOpacity(0.5)),
              ),
              Tab(
                child: SmallText(
                    text: 'review'.tr.toUpperCase(),
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
          OverviewFragment(),
          AttendeeFragment(),
          ReviewFragment()
        ],
      ),
    );
  }
}
