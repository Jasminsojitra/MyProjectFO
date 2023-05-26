import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/time_picker_widgets.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:festum_evento/widget/upload_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AllOfferModel {
  String person, percentage, des;

  AllOfferModel(this.person, this.percentage, this.des);
}

class SpecificOfferModel {
  String img, name, percentage;

  SpecificOfferModel(this.img, this.percentage, this.name);
}

class OfferAddScreen extends StatefulWidget {
  const OfferAddScreen({Key? key}) : super(key: key);

  @override
  State<OfferAddScreen> createState() => _OfferAddScreenState();
}

class _OfferAddScreenState extends State<OfferAddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  XFile? image;
  String validImage = "";
  final ImagePicker picker = ImagePicker();
  String? thumbnail;
  File? _video;
  bool isAll = true;
  bool isSpecific = false;
  bool isSwitched = false;
  bool isPersontage = false;
  bool isRupee = false;

  //ImagePicker Dialog Gallery or Camera
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/svg/ic_close.svg",
                          color: Colors.black)),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          getImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(50),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.edtBgColor),
                          child:
                              SvgPicture.asset("assets/svg/ic_app_gallery.svg"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SmallText(
                        text: 'select_gallery'.tr,
                        size: 20,
                        color: Colors.black)
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          getImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(50),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.edtBgColor),
                          child: SvgPicture.asset(
                              "assets/svg/ic_phone_gallery.svg"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SmallText(
                        text: 'select_camera'.tr, size: 20, color: Colors.black)
                  ],
                ),
              ],
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

  void _pickerVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      if (video != null) {
        _video = File(video!.path);
      }
    });

    var thumb = await VideoThumbnail.thumbnailFile(
      video: video!.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 108,
      maxWidth: 108,
      quality: 100,
    );

    setState(() {
      thumbnail = thumb.toString();
    });
  }

  var person = <int, TextEditingController>{};
  var percentage = <int, TextEditingController>{};
  var description = <int, TextEditingController>{};
  List<AllOfferModel> entries = [];

  var item = <int, Widget>{};

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  newMethod(
    BuildContext context,
    int index,
  ) {
    var personController = TextEditingController();
    var percentageController = TextEditingController();
    var descriptionController = TextEditingController();
    person.addAll({index: personController});
    percentage.addAll({index: percentageController});
    description.addAll({index: descriptionController});
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.length != 0
              ? InkWell(
                  onTap: () {
                    setState(() {
                      item.removeWhere((key, value) => key == index);
                      person.removeWhere((key, value) => key == index);
                      percentage.removeWhere((key, value) => key == index);
                      description.removeWhere((key, value) => key == index);
                    });
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: SmallText(
                          text: 'remove'.tr,
                          size: 14,
                          color: AppColors.redColor)),
                )
              : Container(
                  height: 0,
                ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: personController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      constraints: const BoxConstraints(maxWidth: 80),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'person'.tr,
                      hintStyle: const TextStyle(
                          fontSize: 12, fontFamily: 'Helvetica'),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: AppColors.edtBgColor,
                      filled: true),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 10,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.edtBgColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      TextFormField(
                        controller: percentageController,
                        decoration: InputDecoration(
                            constraints: const BoxConstraints(maxWidth: 120),
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: AppColors.edtBgColor,
                            filled: true,
                            hintText: 'percentage'.tr,
                            hintStyle: const TextStyle(
                                fontSize: 12, fontFamily: 'Helvetica'),
                            isDense: true),
                      ),
                      Expanded(
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
                                        : Colors.white,
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
                                          : Colors.white,
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
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'description'.tr,
              hintStyle: const TextStyle(fontSize: 10, fontFamily: 'Helvetica'),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              fillColor: AppColors.edtBgColor,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  var img = <int, TextEditingController>{};
  var name = <int, TextEditingController>{};
  var pertage = <int, TextEditingController>{};
  List<AllOfferModel> specific = [];

  var specificItem = <int, Widget>{};

  newSpeific(BuildContext context, int i) {
    var imgController = TextEditingController();
    var nameController = TextEditingController();
    var pertageController = TextEditingController();
    img.addAll({i: imgController});
    name.addAll({i: nameController});
    pertage.addAll({i: pertageController});
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        specificItem.length != 0
            ? InkWell(
                onTap: () {
                  setState(() {
                    img.removeWhere((key, value) => key == i);
                    name.removeWhere((key, value) => key == i);
                    pertage.removeWhere((key, value) => key == i);
                    specificItem.removeWhere((key, value) => key == i);
                  });
                },
                child: Align(
                    alignment: Alignment.topRight,
                    child: SmallText(
                        text: 'remove'.tr,
                        size: 14,
                        color: AppColors.redColor)),
              )
            : Container(height: 0),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 48,
              decoration: BoxDecoration(
                  color: AppColors.edtBgColor,
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () {
                  myAlert();
                },
                child: DottedBorder(
                  color: AppColors.greyColor,
                  radius: const Radius.circular(5),
                  borderType: BorderType.RRect,
                  strokeWidth: 2,
                  child: Center(
                    child: Text(
                      'image_add'.tr,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.greyColor,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'add_products_name'.tr,
                    hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Helvetica'),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: AppColors.edtBgColor,
                    filled: true),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.edtBgColor,
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
                      fillColor: AppColors.edtBgColor,
                      filled: true,
                      hintText: 'percentage'.tr,
                      helperStyle: const TextStyle(
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
                                : Colors.white,
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
                              color:
                                  isRupee ? AppColors.redColor : Colors.white,
                              borderRadius: BorderRadius.circular(3)),
                          child: Icon(Icons.currency_rupee,
                              size: 14,
                              color:
                                  isRupee ? Colors.white : AppColors.greyColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    item.addAll({0: newMethod(context, 0)});
    specificItem.addAll({0: newSpeific(context, 0)});
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
            onNextPress: () {},
            firstTxt: 'cancel'.tr,
            secondTxt: 'submit'.tr),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToolbarWidget(
                  text: 'let_make_it'.tr,
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
                        text: 'what_my_name'.tr,
                        textEditingController: nameController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isCompulsoryText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_offer_name'.tr;
                          }
                          return null;
                        },
                        bgColor: Colors.white),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TimePickerWidget(
                            text: 'start_time'.tr,
                            txtController: startDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter_start_time'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TimePickerWidget(
                            text: 'end_time'.tr,
                            txtController: endDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter_end_time'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
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
                                      height: 110),
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
                              imgUri: "assets/svg/ic_video_icon.svg",
                              txt: 'add_video'.tr,
                              onTap: () {
                                _pickerVideo();
                              }),
                          thumbnail != null
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.file(File(thumbnail!),
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
                    SmallText(
                        text: 'offer_product'.tr,
                        size: 14,
                        color: AppColors.greyColor),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(
                                      () {
                                        isAll = true;
                                        isSpecific = false;
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                          ),
                                        ),
                                        child: Center(
                                          child: SmallText(
                                              text: 'all'.tr,
                                              size: 16,
                                              color: isAll
                                                  ? AppColors.redColor
                                                  : Colors.black),
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        color: isAll
                                            ? AppColors.redColor
                                            : AppColors.edtBgColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  width: 2,
                                  height: 40,
                                  color: AppColors.edtBgColor),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isSpecific = true;
                                    isAll = false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                        ),
                                      ),
                                      child: Center(
                                        child: SmallText(
                                            text: 'specific'.tr,
                                            size: 16,
                                            color: isSpecific
                                                ? AppColors.redColor
                                                : Colors.black),
                                      ),
                                    ),
                                    Container(
                                      height: 2,
                                      color: isSpecific
                                          ? AppColors.redColor
                                          : AppColors.edtBgColor,
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          isAll
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: UploadWidgets(
                                            bgColor: AppColors.edtBgColor,
                                            imgUri: "assets/svg/ic_plus.svg",
                                            txt: 'image'.tr,
                                            onTap: () {},
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: UploadWidgets(
                                            bgColor: AppColors.edtBgColor,
                                            imgUri: "assets/svg/ic_plus.svg",
                                            txt: 'image'.tr,
                                            onTap: () {},
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: UploadWidgets(
                                            bgColor: AppColors.edtBgColor,
                                            imgUri: "assets/svg/ic_plus.svg",
                                            txt: 'image'.tr,
                                            onTap: () {},
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 20),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            item.addAll({
                                              item.keys.last + 1: newMethod(
                                                  context, item.keys.last + 1)
                                            });
                                          });
                                        },
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: SmallText(
                                                text: 'add'.tr,
                                                size: 14,
                                                color: AppColors.greenColor)),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: item.length,
                                      itemBuilder: (_, index) {
                                        return item.values.elementAt(index);
                                      },
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SmallText(
                                              text: 'unlimited'.tr,
                                              size: 14,
                                              color: isSwitched
                                                  ? Colors.black
                                                  : AppColors.greenColor),
                                          const SizedBox(width: 10),
                                          Switch(
                                            value: isSwitched,
                                            onChanged: (value) {
                                              if (isSwitched == false) {
                                                setState(() {
                                                  isSwitched = true;
                                                });
                                                print('Switch Button is ON');
                                              } else {
                                                setState(() {
                                                  isSwitched = false;
                                                });
                                                print('Switch Button is OFF');
                                              }
                                            },
                                            activeColor: AppColors.greenColor,
                                            activeTrackColor: AppColors
                                                .greenColor
                                                .withOpacity(0.5),
                                          ),
                                          const SizedBox(width: 10),
                                          SmallText(
                                              text: 'specific'.tr,
                                              size: 14,
                                              color: isSwitched
                                                  ? AppColors.greenColor
                                                  : Colors.black),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              specificItem.addAll({
                                                specificItem.keys.last + 1:
                                                    newSpeific(
                                                        context,
                                                        specificItem.keys.last +
                                                            1)
                                              });
                                            });
                                          },
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: SmallText(
                                                  text: 'add'.tr,
                                                  size: 14,
                                                  color: AppColors.greenColor)),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: specificItem.length,
                                        itemBuilder: (_, index) {
                                          return specificItem.values
                                              .elementAt(index);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
