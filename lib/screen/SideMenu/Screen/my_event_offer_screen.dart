import 'package:festum_evento/screen/SideMenu/Fragment/my_event_fragment.dart';
import 'package:festum_evento/screen/SideMenu/Fragment/my_offer_fragment.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyEventOfferScreen extends StatefulWidget {
  const MyEventOfferScreen({Key? key}) : super(key: key);

  @override
  State<MyEventOfferScreen> createState() => _MyEventOfferScreenState();
}

class _MyEventOfferScreenState extends State<MyEventOfferScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
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
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/svg/ic_back_arrow.svg"),
        ),
        centerTitle: true,
        title: SmallText(
            text: 'my_event_offers', size: 20, color: Colors.black),

      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          MyEventFragment(),
          MyOfferFragment()
        ],
      ),
    );
  }
}
