import 'package:festum_evento/screen/SideMenu/Model/RedeemModel.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RedeemCoinScreen extends StatefulWidget {
  const RedeemCoinScreen({Key? key}) : super(key: key);

  @override
  State<RedeemCoinScreen> createState() => _RedeemCoinScreenState();
}

class _RedeemCoinScreenState extends State<RedeemCoinScreen> {
  final List<RedeemModel> _reedeemList = [
    RedeemModel(
        mainText: 'coin_redeem'.tr,
        subText: 'processing'.tr,
        date: "Jan 18, 2021",
        price: "-325",
        img: "assets/svg/icon_coin_redeem.svg"),
    RedeemModel(
        mainText: 'login_refer'.tr,
        subText: "Refer by Mark jecno",
        date: "Jan 18, 2021",
        price: "+250",
        img: "assets/svg/ic_add_user.svg"),
    RedeemModel(
        mainText: 'coin_send'.tr,
        subText: "Send to mark jecno",
        date: "Jan 16, 2021",
        price: "-325",
        img: "assets/svg/ic_send_bg.svg"),
    RedeemModel(
        mainText: 'coin_redeem'.tr,
        subText: 'processing'.tr,
        date: "Jan 18, 2021",
        price: "-325",
        img: "assets/svg/icon_coin_redeem.svg"),
    RedeemModel(
        mainText: 'login_refer'.tr,
        subText: "Refer by Mark jecno",
        date: "Jan 18, 2021",
        price: "+250",
        img: "assets/svg/ic_add_user.svg"),
    RedeemModel(
        mainText: 'coin_send'.tr,
        subText: "Send to mark jecno",
        date: "Jan 16, 2021",
        price: "-325",
        img: "assets/svg/ic_send_bg.svg"),
    RedeemModel(
        mainText: 'coin_redeem'.tr,
        subText: 'processing'.tr,
        date: "Jan 18, 2021",
        price: "-325",
        img: "assets/svg/icon_coin_redeem.svg"),
    RedeemModel(
        mainText: 'login_refer'.tr,
        subText: "Refer by Mark jecno",
        date: "Jan 18, 2021",
        price: "+250",
        img: "assets/svg/ic_add_user.svg"),
    RedeemModel(
        mainText: 'coin_send'.tr,
        subText: "Send to mark jecno",
        date: "Jan 16, 2021",
        price: "-325",
        img: "assets/svg/ic_send_bg.svg"),
    RedeemModel(
        mainText: 'coin_redeem'.tr,
        subText: 'processing'.tr,
        date: "Jan 18, 2021",
        price: "-325",
        img: "assets/svg/icon_coin_redeem.svg"),
    RedeemModel(
        mainText: 'login_refer'.tr,
        subText: "Refer by Mark jecno",
        date: "Jan 18, 2021",
        price: "+250",
        img: "assets/svg/ic_add_user.svg"),
  ];
  double sliderValue = 10;
  TextEditingController upiController = TextEditingController();
  final upiKey = GlobalKey<FormState>();

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
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: SvgPicture.asset("assets/svg/ic_back_arrow.svg",
                height: 18, width: 10, color: Colors.white)),
        title: Center(
          child: BigText(
              text: 'redeem_coin'.tr,
              color: Colors.white,
              weight: FontWeight.bold,
              size: 20),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Dialog(
                  backgroundColor: AppColors.darkAppColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 16,
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                  text: 'redeem_your_coin'.tr,
                                  size: 18,
                                  color: Colors.white),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child:
                                    SvgPicture.asset("assets/svg/ic_close.svg"),
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noThumb,
                                thumbShape: null),
                            child: Slider(
                                min: 10,
                                max: 100,
                                thumbColor: const Color(0xFFFE4D5F),
                                activeColor: AppColors.redColor,
                                inactiveColor: Colors.white.withOpacity(0.30),
                                value: sliderValue,
                                onChanged: (double nvalue) {
                                  setState(() {
                                    sliderValue = nvalue;
                                  });
                                }),
                          ),
                          const SizedBox(height: 50),
                          SmallText(text: 'redeem_des'.tr,
                              size: 10,
                              color: Colors.white),
                          const SizedBox(height: 10),
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              height: 50,
                              color: Colors.white,
                              padding: const EdgeInsets.only(left: 10),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    const Image(
                                        image: AssetImage(
                                            "assets/png/ic_coin.png"),
                                        height: 35,
                                        width: 45),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const SmallText(
                                              text: "325 Coin",
                                              size: 16,
                                              color: Colors.black),
                                          SmallText(
                                              text: "\$12.00",
                                              size: 16,
                                              color: AppColors.redColor),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                              key: upiKey,
                              child: Center(
                                child: TextFormField(
                                  controller: upiController,
                                  cursorColor: AppColors.appColor,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter_upi_id'.tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            width: 0, style: BorderStyle.none),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'upi_id'.tr,
                                      hintStyle: TextStyle(
                                          color: AppColors.txtgreyColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                          const SizedBox(height: 20),
                          ButtonWidget(
                              callback: () {
                                if (upiKey.currentState!.validate()) {}
                              },
                              bgColor: AppColors.redColor,
                              text: 'redeem'.tr)
                        ],
                      )),
                );
              });
            },
          );
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.maxFinite, 50),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: AppColors.redColor),
        child: SmallText(text: 'redeem'.tr, size: 18, color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Center(
              child: Container(
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
                            text: 'you_have'.tr, size: 14, color: Colors.white),
                        const SizedBox(height: 5),
                        const BigText(
                            text: "25 F-Coin",
                            color: Colors.white,
                            weight: FontWeight.bold,
                            size: 24)
                      ],
                    ),
                    const Image(image: AssetImage("assets/png/ic_coin.png"))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _reedeemList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(_reedeemList[index].img),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SmallText(
                                            text: _reedeemList[index].mainText,
                                            size: 16,
                                            color: Colors.black),
                                        SmallText(
                                            text: _reedeemList[index].price,
                                            size: 16,
                                            color: Colors.black),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SmallText(
                                            text: _reedeemList[index].subText,
                                            size: 12,
                                            color: AppColors.txtgreyColor),
                                        SmallText(
                                            text: _reedeemList[index].date,
                                            size: 12,
                                            color: AppColors.txtgreyColor),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
