import 'package:festum_evento/screen/DeshboardEvent/screen/event_live_this_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/social_media_widget.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventSocialMediaScreen extends StatefulWidget {
  const EventSocialMediaScreen({Key? key}) : super(key: key);

  @override
  State<EventSocialMediaScreen> createState() => _EventSocialMediaScreenState();
}

class _EventSocialMediaScreenState extends State<EventSocialMediaScreen> {
  TextEditingController termsController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController pintrestController = TextEditingController();
  TextEditingController linkdinController = TextEditingController();

  bool isSelect = false;

  final socialKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.edtBgColor,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                        text: 'terms_and_condition'.tr,
                                        size: 18,
                                        color: Colors.black),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/svg/ic_close.svg",
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF2E363F),
                                      fontSize: 10,
                                      wordSpacing: 1),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      backgroundColor: AppColors.redColor,
                                      fixedSize: Size(double.infinity, 50)),
                                  child: SmallText(
                                      text: 'cancel'.tr,
                                      size: 18,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // if(socialKey.currentState!.validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EventLiveThisScreen()));
                                    // }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      fixedSize:
                                          const Size(double.infinity, 50),
                                      backgroundColor: AppColors.greenColor),
                                  child: SmallText(
                                      text: 'apply'.tr,
                                      size: 18,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
                });
          },
          firstTxt: 'back'.tr,
          secondTxt: 'save'.tr),
      body: Form(
        key: socialKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWidget(
                text: 'let_create_it'.tr,
                tapCallback: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  EditTextWidget(
                      line: 3,
                      text: 'terms_and_condition'.tr,
                      textEditingController: termsController,
                      textInputAction: TextInputAction.done,
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
                  BigText(
                      text: 'social_media'.tr,
                      color: Colors.black,
                      weight: FontWeight.bold,
                      size: 20),
                  const SizedBox(height: 15),
                  SocialMediaWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_facebook_link'.tr;
                        }
                        return null;
                      },
                      txtController: facebookController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      perifixicon: "assets/png/ic_link_facebook.png",
                      line: 1),
                  const SizedBox(height: 20),
                  SocialMediaWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_twitter_link'.tr;
                        }
                        return null;
                      },
                      txtController: twitterController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      perifixicon: "assets/png/ic_link_twitter.png",
                      line: 1),
                  const SizedBox(height: 20),
                  SocialMediaWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_instagram_link'.tr;
                        }
                        return null;
                      },
                      txtController: twitterController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      perifixicon: "assets/png/ic_link_insta.png",
                      line: 1),
                  const SizedBox(height: 20),
                  SocialMediaWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_youtube_link'.tr;
                        }
                        return null;
                      },
                      txtController: twitterController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      perifixicon: "assets/png/ic_link_yt.png",
                      line: 1),
                  const SizedBox(height: 20),
                  SocialMediaWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_pintrest_link'.tr;
                        }
                        return null;
                      },
                      txtController: twitterController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      perifixicon: "assets/png/ic_link_pintrest.png",
                      line: 1),
                  const SizedBox(height: 20),
                  SocialMediaWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_linkdin_link'.tr;
                        }
                        return null;
                      },
                      txtController: twitterController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      perifixicon: "assets/png/ic_link_linkdein.png",
                      line: 1),
                  const SizedBox(height: 20),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
