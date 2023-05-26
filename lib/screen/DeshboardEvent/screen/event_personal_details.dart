import 'package:festum_evento/screen/DeshboardEvent/screen/event_social_media_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventPersonalDetailsScreen extends StatefulWidget {
  const EventPersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EventPersonalDetailsScreen> createState() =>
      _EventPersonalDetailsScreenState();
}

class _EventPersonalDetailsScreenState
    extends State<EventPersonalDetailsScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController alternativeNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController flatNoController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController areaNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final personalDetails = GlobalKey<FormState>();

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
            // if(personalDetails.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventSocialMediaScreen()));
            // }
          },
          firstTxt: 'back'.tr,
          secondTxt: 'next'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWidget(
              text: 'let_create_the_event'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Form(
                  key: personalDetails,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditTextWidget(
                          line: 1,
                          isCompulsoryText: true,
                          text: 'full_name_mr'.tr,
                          textEditingController: fullNameController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: true,
                          text: 'mobile_number'.tr,
                          textEditingController: mobileNumberController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
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
                        isCompulsoryText: false,
                        text: 'alternative_mobile_number'.tr,
                        textEditingController: alternativeNoController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        bgColor: Colors.white,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_alternative_mobile_number'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          isCompulsoryText: true,
                          text: 'email_address'.tr,
                          textEditingController: emailController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_email_address'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 30),
                      SmallText(
                          text: 'address'.tr, size: 20, color: Colors.black),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          isCompulsoryText: false,
                          text: 'flat_no'.tr,
                          textEditingController: flatNoController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: false,
                          text: 'street_name'.tr,
                          textEditingController: streetNameController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: false,
                          text: 'area_name'.tr,
                          textEditingController: areaNameController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: false,
                          text: 'city'.tr,
                          textEditingController: cityController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: false,
                          text: 'state'.tr,
                          textEditingController: stateController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: false,
                          text: 'pincode'.tr,
                          textEditingController: pincodeController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_pincode'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
