
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import '../../../model/arrangement_item_model/MediaModel.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/app_url.dart';
import '../../../widget/small_text.dart';

class FullScreenVideo extends StatefulWidget {
  int index;
  List<dynamic>? videoList;
  FullScreenVideo(this.videoList,this.index);
  _FullScreenVideoState createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  // final FullVideoController _fullvideoController = Get.put(FullVideoController());
  late TapDownDetails _doubleTapDetails;
  final _transformationController = TransformationController();
  PageController? pageController;
  int? currentPageIndex;

  @override
  void initState() {
    this.pageController = new PageController(initialPage: widget.index);
    this.currentPageIndex = widget.index;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      this.currentPageIndex = index;
    });
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }

  PhotoViewGalleryPageOptions buildForVideo(video) {
    return PhotoViewGalleryPageOptions.customChild(
      child: GalleryVideoPlayer(video),
      initialScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.contained,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded)
        ),
        backgroundColor: AppColors.appColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text("Video".tr,),
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.black,
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   centerTitle: true,
      // ),

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child:
            PhotoViewGallery.builder(
              backgroundDecoration: BoxDecoration(color: AppColors.appColor),
              itemCount: widget.videoList!.length,
              pageController: pageController,
              onPageChanged: onPageChanged,
              builder: (BuildContext context, int index) {
                return this.buildForVideo(widget.videoList![index].url);
              },
            ),

          ),
          widget.videoList![currentPageIndex!].description!.toString().isEmpty?
          Container(height: 1,):
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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
                        child: SafeArea(
                          bottom: false,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top+20,left: 30,right: 30,bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color:AppColors.edtBgColor.withOpacity(0.95)),
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
                                  child: SmallText(
                                    text: widget.videoList![currentPageIndex!].description??"",
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.66),),
                                ),
                              ],
                            ),
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
        ],
      ),
    );

  }
}


class GalleryVideoPlayer extends StatefulWidget {
  dynamic video;

  GalleryVideoPlayer(this.video);

  @override
  _GalleryVideoPlayerState createState() => _GalleryVideoPlayerState();
}

class _GalleryVideoPlayerState extends State<GalleryVideoPlayer> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  bool _visible = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      AppUrl.imageUrl+widget.video,
    );
    _controller!.setLooping(true);
    _initializeVideoPlayerFuture = _controller!.initialize();
    _initializeVideoPlayerFuture!.then((val) {
      setState(() {
        _controller!.play();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.appColor, // transparent status bar
        statusBarBrightness: Brightness.dark // dark text for status bar
    ));
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                if (_controller!.value.isPlaying) {
                  _controller!.pause();
                } else {
                  _controller!.play();
                }
                this._visible = true;
              });
              Timer(const Duration(milliseconds: 1000), () {
                setState(() {
                  this._visible = false;
                });
              });
            },
            child: Center(
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Container(
                color: Colors.transparent,
                child: Icon(
                  !_controller!.value.isPlaying ?
                  Icons.pause : Icons.play_arrow,
                  color: AppColors.edtBgColor,
                  size: 60,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: VideoProgressIndicator(
                _controller!,
                padding: EdgeInsets.all(0),
                colors: VideoProgressColors(
                    playedColor: AppColors.appColor,
                    bufferedColor: AppColors.appColor.withAlpha(100),
                    backgroundColor: AppColors.appColor.withAlpha(100)),
                allowScrubbing: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}