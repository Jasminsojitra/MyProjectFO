import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_discount.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../view_models/controller/arragement_item/permission_letter_controller.dart';

class EventPermissionLetterScreen extends StatefulWidget {
  const EventPermissionLetterScreen({Key? key}) : super(key: key);

  @override
  State<EventPermissionLetterScreen> createState() =>
      _EventPermissionLetterScreenState();
}

class _EventPermissionLetterScreenState
    extends State<EventPermissionLetterScreen> {
  File? file;
  final permissionLetterController = Get.put(PermissionLetterController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      permissionLetterController.getDataApi();
    });
  }

  void _selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path.toString());
      setState(() async {
        var data=await permissionLetterController.addPermissionLatterApi(file);
        permissionLetterController.permissionLatter=data.data["url"];
        permissionLetterController.fileName = permissionLetterController.permissionLatter!.split('/').last;
        setState(() {
        });
      });
      print("File selected==>>" + permissionLetterController.fileName!);
    } else {
      print("No file selected");
    }
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
            permissionLetterController.addDataApi();

          },
          firstTxt: 'back'.tr,
          secondTxt: 'next'.tr),
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
              GetBuilder<PermissionLetterController>(
              builder: (permissionLetterController) {
              return
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: DottedBorder(
                                padding: const EdgeInsets.all(30),
                                color: AppColors.greyColor,
                                strokeWidth: 2,
                                radius: const Radius.circular(5),
                                borderType: BorderType.RRect,
                                child: permissionLetterController.fileName == null || permissionLetterController.fileName!.isEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: SvgPicture.asset(
                                                "assets/svg/ic_pdf_icon.svg",
                                                height: 34,
                                                width: 32),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SmallText(
                                                    text:
                                                        'permission_verfication'.tr,
                                                    size: 14,
                                                    color: AppColors.greyColor),
                                                const SizedBox(height: 5),
                                                SmallText(
                                                    text: 'attached_pdf_only'.tr,
                                                    size: 12,
                                                    color: AppColors.greyColor,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : Center(
                                        child: Text(
                                          permissionLetterController.fileName!,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: AppColors.redColor,
                                            fontSize: 14,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                            onTap: () {
                              _selectPdf();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              value: permissionLetterController.isSelect,
                              onChanged: (value) {
                                setState(() {
                                  permissionLetterController.isSelect = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: 'accept_booking'.tr,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                  size: 18,
                                ),
                                const SizedBox(height: 5),
                                Center(
                                  child: Text(
                                      'accept_booking_des'.tr,
                                      style: TextStyle(
                                        fontSize: 12,color: AppColors.redColor,fontWeight: FontWeight.bold
                                      ),),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info, size: 15, color: AppColors.greyColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SmallText(
                              text:
                                  'des_1'.tr,
                              size: 12,
                              color: AppColors.greyColor),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info, size: 15, color: AppColors.greyColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SmallText(
                              text:
                                  'des_2'.tr,
                              size: 12,
                              color: AppColors.greyColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SmallText(
                        text: 'Note'.tr,
                        size: 18,
                        color: AppColors.redColor),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Permission Letter'.tr+" : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: AppColors.appColor)),
                        TextSpan(
                            text: 'Adding a permission letter is a must. If you do not require a permission letter for your event, kindly upload a pdf file containing proper description of your event, mentioning you have the authority to conduct it.'.tr,
                            style: TextStyle(
                                fontStyle: FontStyle.normal, color: AppColors.appColor)),

                      ]),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Accept Booking'.tr+" : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: AppColors.appColor,letterSpacing: 0.3)),
                        TextSpan(
                            text: 'Select to allow ticket booking. Deselect if you don’t want to sell tickets.'.tr,
                            style: TextStyle(
                                fontStyle: FontStyle.normal, color: AppColors.appColor,letterSpacing: 0.3)),

                      ]),
                    ),
                  ],
                );})
              ],
            ),
          )
        ],
      ),
    );
  }
}
