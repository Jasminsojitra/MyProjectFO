import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/AppColors.dart';
import '../../../utils/app_url.dart';
import '../../../widget/small_text.dart';

class CustomGalleryImage extends StatefulWidget {
  List media = [];
  int currentIndex;
  bool isDiscription=true;
  CustomGalleryImage(this.media, this.currentIndex,this.isDiscription);

  @override
  _CustomGalleryImageState createState() => _CustomGalleryImageState();
}

class _CustomGalleryImageState extends State<CustomGalleryImage> {
  PageController? pageController;
  int currentPageIndex=0;

  @override
  void initState() {
    this.pageController = new PageController(initialPage: widget.currentIndex);
    this.currentPageIndex = widget.currentIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      this.currentPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: SmallText(
            text: "Photo Gallery".tr,
            size: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.edtBgColor),

        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.edtBgColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: <Widget>[

          Container(
            color: AppColors.appColor,
            child:  PhotoViewGallery.builder(
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              itemCount: widget.media.length,
              pageController: pageController,
              onPageChanged: onPageChanged,
              builder: (BuildContext context, int index) {
                return this.buildForImage(widget.isDiscription?widget.media[index].url:
                widget.media[index]);
              },
            ),

          ),
          widget.isDiscription?(
          widget.media[currentPageIndex].description!.toString().isEmpty?
          Container(height: 1,):
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragEnd: (dragUpdateDetails) {
                  //Navigator.of(context).pop();
                  if (dragUpdateDetails.primaryVelocity! <= 0) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (
                          BuildContext context,
                          ) {
                        return SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top+20,left: 30,right: 30,bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: AppColors.edtBgColor.withOpacity(0.95)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  SmallText(
                                    text: "Description".tr,
                                    size: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appColor),
                                  GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Icon(Icons.clear)),
                                ]),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child:
                                  SmallText(
                                      text: widget.media[currentPageIndex].description??"",
                                      size: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.66),),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Transform.rotate(
                                angle: 180 * pi / 180,
                                child: Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5,),
                              SmallText(
                                  text: "View Description",
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )):Container(height: 1,),

        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions buildForImage(image) {
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(AppUrl.imageUrl + image,),
      initialScale: PhotoViewComputedScale.contained * 1,
      minScale: PhotoViewComputedScale.contained,
    );
  }

}




