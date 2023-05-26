import 'package:festum_evento/screen/Fragment/event_fragment.dart';
import 'package:festum_evento/screen/Fragment/live_stream_fragment.dart';
import 'package:festum_evento/screen/Fragment/shop_fragment.dart';
import 'package:festum_evento/screen/SideMenu/screen/languague_screen.dart';
import 'package:festum_evento/screen/SideMenu/side_menu_screen.dart';
import 'package:festum_evento/screen/TopIndicator.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DeshboardScreen extends StatefulWidget {
  const DeshboardScreen({Key? key}) : super(key: key);

  @override
  State<DeshboardScreen> createState() => _DeshboardScreenState();
}

class _DeshboardScreenState extends State<DeshboardScreen>
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
        elevation: 0,
        backgroundColor: AppColors.appColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/svg/ic_calender.svg"),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LanguagueScreen()));
            },
            icon: SvgPicture.asset("assets/svg/ic_languague.svg"),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SideMenuScreen()));
            },
            icon: SvgPicture.asset("assets/svg/ic_nav_menu.svg"),
          ),
        ],
        title: BigText(
            text: 'deshboard'.tr,
            color: Colors.white,
            weight: FontWeight.bold,
            size: 20),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          controller: controller,
          indicator: TopIndicator(),
          unselectedLabelColor: Colors.grey,
          onTap: (index) {},
          tabs: [
            Tab(
                icon: SvgPicture.asset(
              "assets/svg/ic_nav_event.svg",
              color: controller.index == 0
                  ? AppColors.redColor
                  : AppColors.tabColor,
              height: 30,
              width: 30,
            )),
            Tab(
              icon: SvgPicture.asset("assets/svg/ic_nav_shop.svg",
                  color: controller.index == 1
                      ? AppColors.redColor
                      : AppColors.tabColor),
            ),
            Tab(
              icon: SvgPicture.asset("assets/svg/ic_nav_live.svg",
                  color: controller.index == 2
                      ? AppColors.redColor
                      : AppColors.tabColor),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                EventFragment(),
                ShopFragment(),
                LiveStreamFragment()
              ],
            ),
          )
        ],
      ),
    );
  }
}
