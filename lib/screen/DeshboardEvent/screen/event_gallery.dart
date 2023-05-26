import 'dart:convert';
import 'dart:io';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_permission_letter.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/viewImage_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:festum_evento/widget/upload_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../model/arrangement_item_model/MediaModel.dart';
import '../../../utils/app_url.dart';
import '../../../utils/utils.dart';
import '../../../view_models/controller/arragement_item/GallaryController.dart';
import '../../../widget/thumbnail_Image_Fullpage.dart';
import '../../LoadingComponent.dart';

class EventGalleryScreen extends StatefulWidget {
  const EventGalleryScreen({Key? key}) : super(key: key);

  @override
  State<EventGalleryScreen> createState() => _EventGalleryScreenState();
}

class _EventGalleryScreenState extends State<EventGalleryScreen> {

  File? _video;

  final ImagePicker picker = ImagePicker();

  final gallaryController = Get.put(GallaryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      gallaryController.getDataApi();
    });
  }
  //ImagePicker Dialog Gallery or Camera
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const SmallText(
                text: "Choose media to select", size: 18, color: Colors.black),
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
                      children: const [
                        Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        SmallText(
                            text: "From Gallery",
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
                      children: const [
                        Icon(Icons.camera, color: Colors.white),
                        SizedBox(width: 10),
                        SmallText(
                            text: "From Camera", size: 14, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void selectImages() async {
    final List<XFile> selectedImages =
        await picker.pickMultiImage(imageQuality: 15);
    if (selectedImages!.isNotEmpty) {

      if (gallaryController.imageFileList!.length < 15) {
        Utils().showLoading();
        for(var images in selectedImages){
          final bytes = (await images!.readAsBytes()).lengthInBytes;
          final kb = bytes / 1024;
          final mb = kb / 1024;
          if(mb>=5){
            Utils().errorMessage("Maximum Image Size is 5MB.");
          }
          else{
            var data=await gallaryController.addImageApi(File(images.path));
            print(data.data["url"]);
            //posterImage=data.data["url"];
            gallaryController.imageFileList!.add(Photo(url: data.data["url"],description: ""));
            setState(() {});
          }
          Utils().hideLoading();
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackbarWidget('maximum_fifteen_images_upload'.tr));
      }
    }
    setState(() {});
  }

  Future getImage(ImageSource media) async {
    try{
      var img = await picker.pickImage(source: media);
      final bytes = (await img!.readAsBytes()).lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      if(mb>10){
        Utils().errorMessage("Maximum Poster Size is 10MB.");
      }
      else {
        Utils().showLoading();
        var data=await gallaryController.addPosterImageApi(File(img.path));
        print(data.data["url"]);
        gallaryController.posterImage=data.data["url"];
        setState(() {});
        Utils().hideLoading();
      }
    }
    catch(ex){
      Utils().hideLoading();
      Utils().errorMessage("Select Another Image");
    }
  }

  void _pickerVideo() async {
    if(gallaryController.videolList!.length>=2){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackbarWidget('Maximum 2 Video Upload'.tr));
    }else{
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    final bytes = (await video!.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if(mb>512){
      Utils().errorMessage("Maximum Video Size is 512MB.");
    }
    else {
      if (video != null) {
        _video = File(video!.path);
        var data = await gallaryController.addVideoApi(_video);
        print(data.data["url"]);
        gallaryController.videolList!.add(Video(url: data.data["url"],description: "",thumbnail: ""));
        setState(() {});
      }
    }}
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
        child:Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () async {

            MediaModel data=MediaModel(
                eventid:Get.arguments,
                banner: gallaryController.posterImage,
                photos:  gallaryController.imageFileList,
                videos : gallaryController.videolList
            );
            print(data);

            await gallaryController.addDataApi(data);

          },
          firstTxt: 'back'.tr,
          secondTxt: 'next'.tr),
      body:  GetBuilder<GallaryController>(
    builder: (ctrl) {
    return Column(
        children: [
          ToolbarWidget(
              text: 'let_create_it'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          gallaryController.posterImage != null
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      child: Container(
                                        child:Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(builder: (context) => CustomGalleryImage(
                                                  [gallaryController.posterImage!], 0,false)));
                                        },
                                        child: Utils().imageNetwork(url: AppUrl.imageUrl+ gallaryController.posterImage!,
                                            fit: BoxFit.cover,
                                            width: double.maxFinite,
                                            height: 200),
                                      ),
                                      Positioned(
                                        bottom: 0,right: 0,
                                        left: 0,
                                        child: InkWell(
                                          onTap: () {
                                            gallaryController.posterImage=null;
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment
                                                .bottomCenter,
                                            height: 30,
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
                                  ))),
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
                              txt: 'Add Photos (15 Images - up to 3MB/Image)'.tr,
                              onTap: () {
                                selectImages();
                              }),
                          gallaryController.imageFileList!.length != 0
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
                                      itemCount: gallaryController.imageFileList?.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            child: Stack(
                                              children: <Widget>[
                                                GestureDetector(
                                                onTap: (){
                                          Navigator.push(
                                          context,
                                          CupertinoPageRoute(builder: (context) => CustomGalleryImage(
                                          gallaryController.imageFileList, index,true)));
                                          },
                                            child:Utils().imageNetwork(url: AppUrl.imageUrl+ gallaryController.imageFileList![index].url!,
                                                  fit: BoxFit.cover,
                                                  height: 108,
                                                  width: 108,
                                                )),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: InkWell(
                                                    onTap: () {
                                                      gallaryController.removeImage(index);
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
                              txt: 'Add Video (2 videos - up to 512MB/Video)'.tr,
                              onTap: () {
                                _pickerVideo();
                              }),
                          gallaryController.videolList!.length != 0
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
                                      itemCount: gallaryController.videolList?.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            child: Stack(
                                              children: <Widget>[
                                                ThumbNailImageFullpage(
                                                    gallaryController.videolList![
                                                    index].url!,index,gallaryController.videolList!

                                                ),
                                                // Image.file(
                                                //   File(videoThumnailList![
                                                //       index]),
                                                //   fit: BoxFit.cover,
                                                //   height: 108,
                                                //   width: 108,
                                                // ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: InkWell(
                                                    onTap: () {
                                                      gallaryController.removeVideo(index);
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
                                      }),
                                )
                              : const Visibility(
                                  visible: false, child: Icon(Icons.error))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   children: [
                    //     Icon(Icons.info, size: 15, color: AppColors.greyColor),
                    //     const SizedBox(width: 10),
                    //     SmallText(
                    //         text: 'max_60min_video'.tr,
                    //         size: 12,
                    //         color: AppColors.greyColor)
                    //   ],
                    // )
                  ],
                )
              ],
            ),
          )
        ],
      );}),
    ));
  }
}
