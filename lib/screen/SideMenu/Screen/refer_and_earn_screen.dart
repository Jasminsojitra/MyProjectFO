import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({Key? key}) : super(key: key);

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/svg/ic_back_arrow.svg",
              color: Colors.white),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.redColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: 'total_rewards_earned'.tr,
                                  size: 12,
                                  color: Colors.white),
                              const SizedBox(height: 5),
                              const SmallText(
                                  text: "250 F-Coins",
                                  size: 20,
                                  color: Colors.white),
                            ],
                          ),
                          Image.asset("assets/png/ic_doller_coin.png")
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        'refer_friends_earn'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        "assets/png/ic_redeem_gift.png",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'refer_get_coin'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.greenColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Text(
                        'refer_earn_desc'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lightGreenColor),
                      child: DottedBorder(
                        strokeWidth: 3,
                        borderType: BorderType.RRect,
                        color: AppColors.greenColor,
                        radius: const Radius.circular(10),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(
                                      text: 'referral_code'.tr,
                                      size: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                  const SizedBox(height: 5),
                                  BigText(
                                      text: 'Z128HN'.tr,
                                      size: 40,
                                      color: AppColors.greenColor,
                                      weight: FontWeight.bold),
                                ],
                              ),
                            ),
                            DottedLine(
                              direction: Axis.vertical,
                              lineLength: 60,
                              dashColor: AppColors.greenColor,
                            ),
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SmallText(
                                      text: 'copy_code'.tr.toUpperCase(),
                                      size: 14,
                                      color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SmallText(
                    text: 'share_refer_code'.tr, size: 18, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: SvgPicture.asset("assets/svg/ic_whatsapp.svg",
                          height: 60, width: 60),
                    ),
                    InkWell(
                      child: SvgPicture.asset("assets/svg/ic_facebook.svg",
                          height: 60, width: 60),
                    ),
                    InkWell(
                      child: SvgPicture.asset("assets/svg/ic_telegram.svg",
                          height: 60, width: 60),
                    ),
                    InkWell(
                      child: SvgPicture.asset("assets/svg/ic_twitter.svg",
                          height: 60, width: 60),
                    ),
                    InkWell(
                      child: SvgPicture.asset("assets/svg/ic_message.svg",
                          height: 60, width: 60),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/ic_share.svg"),
                    const SizedBox(width: 20),
                    SmallText(
                        text: 'other'.tr.toUpperCase(),
                        size: 18,
                        color: Colors.black)
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          )
        ],
      ),
    );
  }
}
