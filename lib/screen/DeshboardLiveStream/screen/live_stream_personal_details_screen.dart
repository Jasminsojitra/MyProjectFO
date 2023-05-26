import 'package:festum_evento/screen/DeshboardLiveStream/screen/live_stream_social_media_screen.dart';
import 'package:festum_evento/screen/deshboard_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveStreamPersonalDetailsScreen extends StatefulWidget {
  const LiveStreamPersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LiveStreamPersonalDetailsScreen> createState() =>
      _LiveStreamPersonalDetailsScreenState();
}

class _LiveStreamPersonalDetailsScreenState
    extends State<LiveStreamPersonalDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController flatController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final personalKey = GlobalKey<FormState>();

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LiveStreamSocialMediaScreen()));
            },
            firstTxt: 'back'.tr,
            secondTxt: 'next'.tr),
        body: Form(
          key: personalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToolbarWidget(
                  text: 'create_live_stream'.tr,
                  tapCallback: () {
                    Navigator.pop(context);
                  }),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  children: [
                    EditTextWidget(
                        line: 1,
                        text: 'full_name_mr'.tr,
                        textEditingController: nameController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_full_name_mr'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'mobile_number'.tr,
                        textEditingController: mobileController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.phone,
                        isCompulsoryText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_mobile_number'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'alternative_mobile_number'.tr,
                        textEditingController: alteController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.phone,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_alternative_mobile_number'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'email_address'.tr,
                        textEditingController: emailController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        isCompulsoryText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_email_address'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 30),
                    SmallText(text: 'address'.tr, size: 20, color: Colors.black),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'flat_no'.tr,
                        textEditingController: flatController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_flat_no'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'street_name'.tr,
                        textEditingController: streetController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_street_name'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'area_name'.tr,
                        textEditingController: areaController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_area_name'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'city'.tr,
                        textEditingController: cityController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_city'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'state'.tr,
                        textEditingController: stateController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_state'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'pincode'.tr,
                        textEditingController: stateController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_pincode'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
