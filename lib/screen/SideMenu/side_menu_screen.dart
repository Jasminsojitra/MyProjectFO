import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/screen/SideMenu/Model/MenuModel.dart';
import 'package:festum_evento/screen/SideMenu/Screen/help_and_faq_screen.dart';
import 'package:festum_evento/screen/SideMenu/Screen/my_event_offer_screen.dart';
import 'package:festum_evento/screen/SideMenu/Screen/our_product_screen.dart';
import 'package:festum_evento/screen/SideMenu/Screen/refer_and_earn_screen.dart';
import 'package:festum_evento/screen/SideMenu/screen/history_screen.dart';
import 'package:festum_evento/screen/SideMenu/screen/redeem_coin_screen.dart';
import 'package:festum_evento/screen/SideMenu/screen/subscription_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/user_preference/user_preference_view_model.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({Key? key}) : super(key: key);

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  UserPreference userPreference = UserPreference();

  final List<MenuModel> _textList = [
    MenuModel(name: 'my_subscription'.tr, img: "assets/svg/ic_book.svg"),
    MenuModel(name: 'refer_earn'.tr, img: "assets/svg/ic_gift.svg"),
    MenuModel(name: 'notification'.tr, img: "assets/svg/ic_notification.svg"),
    MenuModel(name: 'redeem'.tr, img: "assets/svg/ic_redeem.svg"),
    MenuModel(name: 'help_faq'.tr, img: "assets/svg/ic_help.svg"),
    MenuModel(name: 'entertainment'.tr, img: "assets/svg/ic_gallery.svg"),
    MenuModel(name: 'our_product'.tr, img: "assets/svg/ic_our_product.svg"),
    MenuModel(name: 'history'.tr, img: "assets/svg/ic_history.svg"),
    MenuModel(name: 'event_offers'.tr, img: "assets/svg/ic_offers_history.svg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/svg/ic_back_arrow.svg"),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              radius: 50,
                              foregroundColor: AppColors.appColor,
                              backgroundImage:
                                  const AssetImage("assets/png/ic_user.png"),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration:
                                    BoxDecoration(color: AppColors.redColor),
                                child: const SmallText(
                                    text: "123456789",
                                    size: 14,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 3),
                              const BigText(
                                  text: "Mark Jecno",
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                  size: 24),
                              const SizedBox(height: 3),
                              SmallText(
                                  text: "markjecno@gmail.com",
                                  size: 16,
                                  color: AppColors.txtgreyColor,
                                  fontWeight: FontWeight.normal)
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 80,
                      decoration: BoxDecoration(color: AppColors.greenColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: 'you_have'.tr,
                                  size: 14,
                                  color: Colors.white),
                              const SizedBox(height: 5),
                              const BigText(
                                  text: "25 F-Coin",
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                  size: 24)
                            ],
                          ),
                          Image(image: AssetImage("assets/png/ic_coin.png"))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int pos) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              var screen;
                              switch (pos) {
                                case 0:
                                  screen = const SubscriptionScreen();
                                  break;
                                case 1:
                                  screen = const ReferAndEarnScreen();
                                  break;
                                case 3:
                                  screen = const RedeemCoinScreen();
                                  break;
                                case 4:
                                  screen = const HelpAndFaqScreen();
                                  break;
                                case 6:
                                  screen = const OurProductScreen();
                                  break;
                                case 7:
                                  screen = const HistoryScreen();
                                  break;
                                case 8:
                                  screen = const MyEventOfferScreen();
                                  break;
                              }
                              if (screen != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => screen!));
                              }
                            },
                            leading: SvgPicture.asset(_textList[pos].img),
                            title: SmallText(
                              text: _textList[pos].name,
                              size: 16,
                              color: Colors.black,
                            ),
                            trailing: SvgPicture.asset(
                                "assets/svg/ic_right_arrow.svg"),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(height: 1, color: AppColors.lineColor),
                        itemCount: _textList.length),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/svg/ic_whatsapp.svg"),
                        SvgPicture.asset("assets/svg/ic_facebook.svg"),
                        SvgPicture.asset("assets/svg/ic_telegram.svg"),
                        const Image(
                            image: AssetImage("assets/png/ic_insta.png")),
                        SvgPicture.asset("assets/svg/ic_twitter.svg"),
                        SvgPicture.asset("assets/svg/ic_linkdin.svg"),
                        SvgPicture.asset("assets/svg/ic_yt.svg"),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    userPreference.removeUser();
                    Get.offAllNamed(RouteName.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.zero,
                    fixedSize: const Size(double.maxFinite, 50),
                    backgroundColor: AppColors.redColor,
                  ),
                  child: SmallText(
                      text: 'log_out'.tr, size: 18, color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
