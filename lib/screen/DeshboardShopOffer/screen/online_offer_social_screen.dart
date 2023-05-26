import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/social_media_widget.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineOfferSocialScreen extends StatefulWidget {
  const OnlineOfferSocialScreen({Key? key}) : super(key: key);

  @override
  State<OnlineOfferSocialScreen> createState() =>
      _OnlineOfferSocialScreenState();
}

class _OnlineOfferSocialScreenState extends State<OnlineOfferSocialScreen> {
  TextEditingController temsController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController pintrestController = TextEditingController();
  TextEditingController linkdinController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(elevation: 0),
      ),
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () {
           if(formKey.currentState!.validate()){
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => OnlineOfferSocialScreen()));
           }
          },
          firstTxt: 'cancel'.tr,
          secondTxt: 'continue'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWidget(
              text: 'let_create_it'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Form(
                  key: formKey,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditTextWidget(
                        line: 3,
                        text: 'terms_and_condition'.tr,
                        textEditingController: temsController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_terms_and_condition'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 30),
                    SmallText(
                        text: 'social_media'.tr, size: 20, color: Colors.black),
                    const SizedBox(height: 10),
                    SocialMediaWidget(
                        perifixicon: "assets/png/ic_link_facebook.png",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_facebook_link'.tr;
                          }
                          return null;
                        },
                        txtController: facebookController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        line: 1),
                    const SizedBox(height: 10),
                    SocialMediaWidget(
                        perifixicon: "assets/png/ic_link_twitter.png",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_twitter_link'.tr;
                          }
                          return null;
                        },
                        txtController: twitterController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        line: 1),
                    const SizedBox(height: 10),
                    SocialMediaWidget(
                        perifixicon: "assets/png/ic_link_insta.png",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_instagram_link'.tr;
                          }
                          return null;
                        },
                        txtController: instaController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        line: 1),
                    const SizedBox(height: 10),
                    SocialMediaWidget(
                        perifixicon: "assets/png/ic_link_yt.png",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_youtube_link'.tr;
                          }
                          return null;
                        },
                        txtController: youtubeController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        line: 1),
                    const SizedBox(height: 10),
                    SocialMediaWidget(
                        perifixicon: "assets/png/ic_link_pintrest.png",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_pintrest_link'.tr;
                          }
                          return null;
                        },
                        txtController: pintrestController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        line: 1),
                    const SizedBox(height: 10),
                    SocialMediaWidget(
                        perifixicon: "assets/png/ic_link_linkdein.png",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_linkdin_link'.tr;
                          }
                          return null;
                        },
                        txtController: linkdinController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        line: 1),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            activeColor: AppColors.greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            side: BorderSide(
                                color: AppColors.chkBodarColor, width: 1),
                            value: isSelect,
                            onChanged: (value) {
                              setState(() {
                                isSelect = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        BigText(
                          text: 'accept_terms_and_condition'.tr,
                          color: AppColors.greyColor,
                          weight: FontWeight.bold,
                          size: 12,
                        )
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
