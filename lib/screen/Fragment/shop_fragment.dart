import 'package:festum_evento/screen/DeshboardShopOffer/Fragment/online_offer_fragment.dart';
import 'package:festum_evento/screen/DeshboardShopOffer/Fragment/shop_offer_fragment.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopFragment extends StatefulWidget {
  const ShopFragment({Key? key}) : super(key: key);

  @override
  State<ShopFragment> createState() => _ShopFragmentState();
}

class _ShopFragmentState extends State<ShopFragment>
    with SingleTickerProviderStateMixin {

  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
        title: Container(
          decoration: BoxDecoration(
            color: AppColors.appColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'search'.tr,
                  helperStyle: TextStyle(
                      color: AppColors.txtgreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: AppColors.redColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: <Widget>[
            Tab(
              child: SmallText(
                  text: 'shop_offer'.tr.toUpperCase(),
                  size: 16,
                  color: tabController.index == 0
                      ? AppColors.redColor
                      : Colors.white.withOpacity(0.5)),
            ),
            Tab(
              child: SmallText(
                  text: 'online_offer'.tr.toUpperCase(),
                  size: 16,
                  color: tabController.index == 1
                      ? AppColors.redColor
                      : Colors.white.withOpacity(0.5)),
            )
          ],
        ),
      ),
      backgroundColor: AppColors.edtBgColor,
      body: TabBarView(
        controller: tabController,
        children: const [ShopOfferFragment(), OnlineOfferFragment()],
      ),
    );
  }
}
