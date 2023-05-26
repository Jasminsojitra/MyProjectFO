import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/screen/DeshboardLiveStream/screen/live_stream_personal_details_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:festum_evento/widget/upload_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveStreamCompunyDetailsScreen extends StatefulWidget {
  const LiveStreamCompunyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LiveStreamCompunyDetailsScreen> createState() =>
      _LiveStreamCompunyDetailsScreenState();
}

class _LiveStreamCompunyDetailsScreenState
    extends State<LiveStreamCompunyDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController flatController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final _compunKey = GlobalKey<FormState>();

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
            preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
        bottomNavigationBar: BottomButtonWidgets(
            onBackPress: () {
              Navigator.pop(context);
            },
            onNextPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LiveStreamPersonalDetailsScreen()));
            },
            firstTxt: 'back'.tr,
            secondTxt: 'next'.tr),
        body: Form(
          key: _compunKey,
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
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: SmallText(
                                      text: fileName!,
                                      size: 14,
                                      color: AppColors.redColor),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    EditTextWidget(
                        line: 1,
                        text: 'company_contact_no'.tr,
                        textEditingController: contactController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.phone,
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
                    const SizedBox(height: 30),
                    SmallText(
                        text: 'address'.tr, size: 20, color: Colors.black),
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
                        textEditingController: pincodeController,
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
