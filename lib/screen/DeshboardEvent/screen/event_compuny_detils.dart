import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_personal_details.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:festum_evento/widget/upload_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class EventCompanyDetailsScreen extends StatefulWidget {
  const EventCompanyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EventCompanyDetailsScreen> createState() =>
      _EventCompanyDetailsScreenState();
}

class _EventCompanyDetailsScreenState extends State<EventCompanyDetailsScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();
  TextEditingController flatNoController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController areaNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final compunyKey = GlobalKey<FormState>();

  XFile? image;
  String validImage = "";
  final List<XFile>? _imageFileList = [];
  final ImagePicker picker = ImagePicker();
  File? _video;
  String? thumbnail;
  List<String> videoThumnailList = [];
  List<File> videolList = [];

  void selectImages() async {
    final List<XFile> selectedImages =
        await picker.pickMultiImage(imageQuality: 5);
    if (selectedImages!.isNotEmpty) {
      if (_imageFileList!.length < 5) {
        _imageFileList!.addAll(selectedImages);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackbarWidget("Maximum Five Images Upload"));
      }
    }
    setState(() {});
  }

  void _pickerVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      if (video != null) {
        _video = File(video!.path);
        if (videolList!.length < 1) {
          videolList.add(_video!);
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
      if (videoThumnailList!.isEmpty && videoThumnailList!.length < 1) {
        videoThumnailList.add(thumbnail!);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackbarWidget('maximum_one_video_upload'.tr));
      }
    });

    print("Select Video=>>${videoThumnailList.length}");
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
          preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () {
            // if(compunyKey.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventPersonalDetailsScreen()));
            // }
          },
          firstTxt: 'back'.tr,
          secondTxt: 'next'.tr),
      body: Column(
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
                  key: compunyKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditTextWidget(
                          line: 1,
                          isCompulsoryText: false,
                          text: 'company_name'.tr,
                          textEditingController: companyNameController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: false,
                          text: 'company_contact_no'.tr,
                          textEditingController: contactNoController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
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
                          isCompulsoryText: false,
                          text: 'company_email'.tr,
                          textEditingController: companyEmailController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_company_email'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 3,
                          isCompulsoryText: false,
                          text: 'about_our_company'.tr,
                          textEditingController: aboutCompanyController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_about_our_company'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 30),
                      SmallText(
                          text: 'address'.tr, size: 20, color: Colors.black),
                      const SizedBox(height: 15),
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
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_pincode'.tr;
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
                                txt: 'add_photo_max_05'.tr,
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Image.file(
                                                  File(_imageFileList![index]
                                                      .path),
                                                  fit: BoxFit.cover,
                                                  height: 108,
                                                  width: 108,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: InkWell(
                                                    onTap: () {
                                                      _imageFileList!.remove(
                                                          _imageFileList![
                                                              index]);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      width: 108,
                                                      height: 20,
                                                      color: AppColors.redColor,
                                                      child: Center(
                                                        child: SmallText(
                                                            text: 'remove'.tr,
                                                            size: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const Visibility(
                                    visible: false,
                                    child: Icon(Icons.error),
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
                                imgUri: "assets/svg/ic_video_icon.svg",
                                txt: 'add_video_max_01'.tr,
                                onTap: () {
                                  _pickerVideo();
                                }),
                            videoThumnailList!.length != 0
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
                                      itemCount: videoThumnailList?.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Image.file(
                                                  File(videoThumnailList![
                                                      index]),
                                                  fit: BoxFit.cover,
                                                  height: 108,
                                                  width: 108,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: InkWell(
                                                    onTap: () {
                                                      videoThumnailList!.remove(
                                                          videoThumnailList![
                                                              index]);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      width: 108,
                                                      height: 20,
                                                      color: AppColors.redColor,
                                                      child: Center(
                                                        child: SmallText(
                                                            text: 'remove'.tr,
                                                            size: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const Visibility(
                                    visible: false, child: Icon(Icons.error))
                          ],
                        ),
                      ),
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
