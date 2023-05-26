import 'dart:io';
import 'package:festum_evento/screen/DeshboardLiveStream/screen/live_stream_compuny_details_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/time_picker_widgets.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:festum_evento/widget/upload_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddLiveStreamScreen extends StatefulWidget {
  const AddLiveStreamScreen({Key? key}) : super(key: key);

  @override
  State<AddLiveStreamScreen> createState() => _AddLiveStreamScreenState();
}

class _AddLiveStreamScreenState extends State<AddLiveStreamScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController payController = TextEditingController();

  String? valueChoose;
  final listDropItem = [
    "Seminar",
    "Company Meeting",
    "Trade Show/Expo",
    "VIP Event"
  ];

  String radioItem = '';
  String validImage = "";
  File? _video;
  String? thumbnail;
  final List<XFile> _imageFileList = [];
  List<File> vdList = [];
  List<String> thumnailList = [];
  final ImagePicker picker = ImagePicker();

  void selectImages() async {
    final List<XFile> selectedImages =
        await picker.pickMultiImage(imageQuality: 15);
    if (selectedImages!.isNotEmpty) {
      if (_imageFileList!.length < 15) {
        _imageFileList!.addAll(selectedImages);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackbarWidget('maximum_fifteen_images_upload'.tr));
      }
    }
    setState(() {});
  }

  void _pickerVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      if (video != null) {
        _video = File(video!.path);
        if (vdList.length < 2) {
          vdList.add(_video!);
        }
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
      if (thumnailList.isEmpty && thumnailList.length < 2) {
        thumnailList.add(thumbnail!);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackbarWidget('maximum_two_video_upload'.tr));
      }
    });
    print("Select Video=>>${thumnailList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          fixedSize: const Size(double.infinity, 50),
          backgroundColor: AppColors.redColor,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LiveStreamCompunyDetailsScreen()));
        },
        child: SmallText(
            text: 'next'.tr.toUpperCase(), color: Colors.white, size: 18),
      ),
      body: Column(
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
                    text: 'event_name'.tr,
                    textEditingController: nameController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isCompulsoryText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_event_name'.tr;
                      }
                      return null;
                    },
                    bgColor: Colors.white),
                const SizedBox(height: 20),
                SmallText(
                    text: 'event_category'.tr,
                    size: 14,
                    color: AppColors.greyColor),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: SmallText(
                        text: 'select_category'.tr,
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
                const SizedBox(height: 20),
                EditTextWidget(
                    line: 3,
                    text: 'event_des'.tr,
                    textEditingController: desController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isCompulsoryText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_event_description'.tr;
                      }
                      return null;
                    },
                    bgColor: Colors.white),
                const SizedBox(height: 20),
                SmallText(
                    text: 'event_date'.tr,
                    size: 14,
                    color: AppColors.greyColor),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter_select_date'.tr;
                    }
                    return null;
                  },
                  controller: dateController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "DD /  MM /  YYYY",
                    hintStyle: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        "assets/svg/ic_calender_icon.svg",
                        height: 18,
                        width: 18,
                        color: AppColors.greyColor,
                      ),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
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
                        },
                      ),
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
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SmallText(
                    text: 'event_type'.tr,
                    size: 14,
                    color: AppColors.greyColor),
                Row(
                  children: [
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(-10, -5),
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: radioItem,
                          activeColor: AppColors.redColor,
                          title: Transform.translate(
                            offset: const Offset(-18, 0),
                            child: Text('free_for_user'.tr),
                          ),
                          onChanged: (val) {
                            setState(() {
                              radioItem = val!;
                              payController.text = 0.toString();
                            });
                          },
                          value: 'Free',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(-10, -5),
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: radioItem,
                          title: Transform.translate(
                              offset: const Offset(-18, 0),
                              child: Text('paid_for_user'.tr)),
                          value: 'Paid',
                          activeColor: AppColors.redColor,
                          onChanged: (val) {
                            setState(() {
                              radioItem = val!;
                              payController.text = "";
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SmallText(
                    text: 'join_live_streaming_price'.tr,
                    size: 14,
                    color: AppColors.greyColor),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: payController,
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
                              hintStyle: const TextStyle(
                                  fontSize: 10, fontFamily: 'Helvetica'),
                              isDense: true),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.redColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: SmallText(
                                          text: 'per_user'.tr,
                                          size: 16,
                                          color: Colors.white)),
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
                          txt: 'add_poster_15'.tr,
                          onTap: () {
                            selectImages();
                          }),
                      _imageFileList!.length != 0
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: GridView.builder(
                                  physics: ScrollPhysics(),
                                  padding: EdgeInsets.all(10),
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
                                                        text: 'remove'.tr,
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
                      thumnailList!.length != 0
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: GridView.builder(
                                  physics: ScrollPhysics(),
                                  padding: const EdgeInsets.all(10),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          crossAxisCount: 3),
                                  itemCount: thumnailList?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        height: 200,
                                        child: Stack(
                                          children: <Widget>[
                                            Image.file(
                                              File(thumnailList![index]),
                                              fit: BoxFit.cover,
                                              height: 200,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                onTap: () {
                                                  thumnailList!.remove(
                                                      thumnailList![index]);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 20,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  color: AppColors.redColor,
                                                  child: Center(
                                                    child: SmallText(
                                                        text: 'remove'.tr,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
