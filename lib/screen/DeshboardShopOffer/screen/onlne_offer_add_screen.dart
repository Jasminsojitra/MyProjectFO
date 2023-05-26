import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/screen/DeshboardShopOffer/screen/online_offer_social_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/time_picker_widgets.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:festum_evento/widget/upload_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OnlineOfferAddScreen extends StatefulWidget {
  const OnlineOfferAddScreen({Key? key}) : super(key: key);

  @override
  State<OnlineOfferAddScreen> createState() => _OnlineOfferAddScreenState();
}

class _OnlineOfferAddScreenState extends State<OnlineOfferAddScreen> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController offerController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController proNameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController compunyNameController = TextEditingController();
  TextEditingController compunyNoController = TextEditingController();
  TextEditingController compunyEmailController = TextEditingController();
  TextEditingController compunyAboutController = TextEditingController();

  bool isPersontage = false;
  bool isRupee = false;
  String validImage = "";
  XFile? image;
  final List<XFile>? _imageFileList = [];
  final ImagePicker picker = ImagePicker();

  final listDropItem = [
    "F-COIN",
    "Ads Portal",
    "Friends Fields",
    "Festum Evento"
  ];

  String? valueChoose;

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: SmallText(
                text: 'choose_media_select'.tr, size: 18, color: Colors.black),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: AppColors.appColor),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        SmallText(
                            text: 'from_gallery'.tr,
                            size: 14,
                            color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: AppColors.appColor),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.camera, color: Colors.white),
                        const SizedBox(width: 10),
                        SmallText(
                            text: 'from_camera'.tr,
                            size: 14,
                            color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      validImage = img.toString();
    });
  }

  void selectImages() async {
    final List<XFile> selectedImages =
        await picker.pickMultiImage(imageQuality: 15);
    if (selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }

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
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnlineOfferSocialScreen()));
          },
          firstTxt: 'cancel'.tr,
          secondTxt: 'continue'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWidget(
              text: 'let_add_shop'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                EditTextWidget(
                    line: 1,
                    text: 'online_shop_name'.tr,
                    textEditingController: shopNameController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isCompulsoryText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_online_shop_name'.tr;
                      }
                      return null;
                    },
                    bgColor: Colors.white),
                const SizedBox(height: 20),
                SmallText(
                    text: 'offer'.tr, size: 14, color: AppColors.greyColor),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'percentage'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 10, fontFamily: 'Helvetica'),
                              isDense: true),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isPersontage = true;
                                  isRupee = false;
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: isPersontage
                                        ? AppColors.redColor
                                        : AppColors.edtBgColor,
                                    borderRadius: BorderRadius.circular(3)),
                                child: Icon(Icons.percent,
                                    size: 14,
                                    color: isPersontage
                                        ? Colors.white
                                        : AppColors.greyColor),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isPersontage = false;
                                    isRupee = true;
                                  });
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: isRupee
                                          ? AppColors.redColor
                                          : AppColors.edtBgColor,
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Icon(Icons.currency_rupee,
                                      size: 14,
                                      color: isRupee
                                          ? Colors.white
                                          : AppColors.greyColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TimePickerWidget(
                          text: 'start_time'.tr,
                          txtController: startTimeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_start_time'.tr;
                            }
                            return null;
                          }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TimePickerWidget(
                          text: 'end_time'.tr,
                          txtController: endTimeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_end_time'.tr;
                            }
                            return null;
                          }),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                EditTextWidget(
                    line: 1,
                    text: 'product_name'.tr,
                    textEditingController: proNameController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isCompulsoryText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_product_name'.tr;
                      }
                      return null;
                    },
                    bgColor: Colors.white),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UploadWidgets(
                          bgColor: Colors.white,
                          imgUri: "assets/svg/ic_add_image.svg",
                          txt: 'add_poster'.tr,
                          onTap: () {
                            myAlert();
                          }),
                      image != null
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.file(File(image!.path),
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  height: 200),
                            )
                          : const Visibility(
                              visible: false, child: Icon(Icons.error)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UploadWidgets(
                          bgColor: Colors.white,
                          imgUri: "assets/svg/ic_add_image.svg",
                          txt: 'add_offer_product_image'.tr,
                          onTap: () {
                            selectImages();
                          }),
                      _imageFileList!.length != 0
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: GridView.builder(
                                  physics: const ScrollPhysics(),
                                  padding: const EdgeInsets.all(10),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          crossAxisCount: 3),
                                  itemCount: _imageFileList?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        child: Stack(
                                          children: <Widget>[
                                            Image.file(
                                              File(_imageFileList![index].path),
                                              fit: BoxFit.cover,
                                              height: 108,
                                              width: 108,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                onTap: () {
                                                  _imageFileList!.remove(
                                                      _imageFileList![index]);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  width: 108,
                                                  height: 20,
                                                  color: AppColors.redColor,
                                                  child: Center(
                                                    child: SmallText(
                                                        text: 'remove'
                                                            .tr
                                                            .toUpperCase(),
                                                        size: 12,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : const Visibility(
                              visible: false, child: Icon(Icons.error))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                EditTextWidget(
                    line: 3,
                    text: 'product_description'.tr,
                    textEditingController: desController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isCompulsoryText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_product_description'.tr;
                      }
                      return null;
                    },
                    bgColor: Colors.white),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                        text: 'select_platform_product_link'.tr,
                        size: 14,
                        color: AppColors.greyColor),
                    SmallText(
                        text: 'add'.tr, size: 14, color: AppColors.greenColor),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.edtBgColor),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: SmallText(
                              text: 'all_platform'.tr,
                              size: 14,
                              color: Colors.black),
                          icon: Transform.rotate(
                              angle: -180 * 3.14 / 360,
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              )),
                          value: valueChoose,
                          underline: const SizedBox(),
                          onChanged: (value) {
                            setState(() {
                              valueChoose = value;
                            });
                          },
                          items: listDropItem.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: SmallText(
                                  text: value, size: 16, color: Colors.black),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          fillColor: AppColors.edtBgColor,
                          filled: true,
                          errorStyle: TextStyle(color: AppColors.redColor),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                EditTextWidget(
                    line: 1,
                    text: 'company_name'.tr,
                    textEditingController: compunyNameController,
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
                    textEditingController: compunyNoController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
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
                    textEditingController: compunyEmailController,
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
                    textEditingController: compunyAboutController,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
