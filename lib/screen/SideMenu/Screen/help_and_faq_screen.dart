import 'package:festum_evento/screen/SideMenu/Fragment/faq_fragment.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HelpAndFaqScreen extends StatefulWidget {
  const HelpAndFaqScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndFaqScreen> createState() => _HelpAndFaqScreenState();
}

class _HelpAndFaqScreenState extends State<HelpAndFaqScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(handler);
    super.initState();
  }

  handler() {
    setState(() {});
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/svg/ic_back_arrow.svg"),
        ),
        title: SmallText(text: 'help_faq'.tr, size: 20, color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: AppColors.redColor,
          indicatorPadding: const EdgeInsets.only(left: 20, right: 20),
          tabs: [
            Tab(
              child: SmallText(
                  text: 'help'.tr,
                  size: 16,
                  color: tabController!.index == 0
                      ? AppColors.redColor
                      : Colors.black.withOpacity(0.5)),
            ),
            Tab(
              child: SmallText(
                  text: 'faq'.tr,
                  size: 16,
                  color: tabController!.index == 1
                      ? AppColors.redColor
                      : Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          SmallText(text: 'help'.tr, size: 16, color: AppColors.redColor),
          const FaqFragment(),
        ],
      ),
    );
  }
}
