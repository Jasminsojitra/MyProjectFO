import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/social_media_widget.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:festum_evento/widget/upload_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopSocialMediaScreen extends StatefulWidget {
  const ShopSocialMediaScreen({Key? key}) : super(key: key);

  @override
  State<ShopSocialMediaScreen> createState() => _ShopSocialMediaScreenState();
}

class _ShopSocialMediaScreenState extends State<ShopSocialMediaScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController ytController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final shopKey = GlobalKey<FormState>();

  String? fileName = "";
  File? file;

  void _selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path.toString());
      setState(() {
        fileName = file!.path.split('/').last;
      });
      print("File selected==>>" + fileName!);
    } else {
      print("No file selected");
    }
  }

  @override
  void initState() {
    fileName = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(elevation: 0),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 50),
          backgroundColor: AppColors.redColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () {
          if(shopKey.currentState!.validate()){

          }
        },
        child: SmallText(text: 'save'.tr, size: 18, color: Colors.white),
      ),
      body: Form(
        key: shopKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWidget(
              text: 'let_add_shop'.tr,
              tapCallback: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  EditTextWidget(
                      line: 1,
                      text: 'company_name'.tr,
                      textEditingController: nameController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_compuny_name'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  SmallText(
                      text: 'company_gst'.tr,
                      size: 14,
                      color: AppColors.greyColor),
                  const SizedBox(height: 10),
                  fileName == null || fileName!.isEmpty
                      ? UploadWidgets(
                      bgColor: Colors.white,
                      imgUri: "assets/svg/ic_pdf_icon.svg",
                      txt: 'upload_pdf'.tr,
                      onTap: () {
                        _selectPdf();
                      })
                      : InkWell(
                    onTap: () {
                      _selectPdf();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        height: 50,
                        child: DottedBorder(
                            strokeWidth: 2,
                            borderType: BorderType.RRect,
                            color: AppColors.greyColor,
                            radius: const Radius.circular(5),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: SmallText(
                                  text: fileName!,
                                  size: 14,
                                  color: AppColors.redColor),
                            ))),
                  ),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 1,
                      text: 'company_contact_no'.tr,
                      textEditingController: phoneController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_company_contact_no'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 1,
                      text: 'company_email'.tr,
                      textEditingController: emailController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_company_email'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 1,
                      text: 'about_our_company'.tr,
                      textEditingController: aboutController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_about_our_company'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  SmallText(
                      text: 'social_media_link'.tr,
                      size: 14,
                      color: AppColors.greyColor),
                  const SizedBox(height: 10),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
