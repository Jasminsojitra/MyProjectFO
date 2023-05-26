
import 'dart:async';

import 'package:festum_evento/utils/app_url.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../screen/DeshboardEvent/screen/fullVideo_screen.dart';

class ThumbNailImageFullpage extends StatefulWidget {
  String url;
  int index;
  List<dynamic>? videoList;
  ThumbNailImageFullpage(this.url, this.index,this.videoList);

  @override
  _ThumbNailImageFullpageState createState() => _ThumbNailImageFullpageState();
}

class _ThumbNailImageFullpageState extends State<ThumbNailImageFullpage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var thumbnailRequest = ThumbnailRequest(
        video: AppUrl.imageUrl + widget.url,
        thumbnailPath: null,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 120,
        maxWidth: 120,
        quality: 100);
    return Container(
      child: FutureBuilder<ThumbnailResult>(
        future: genThumbnail(thumbnailRequest),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final _image = snapshot.data.image;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => FullScreenVideo(widget.videoList!,widget.index
                    ),
                  ),
                );
                // Get.toNamed(RouteNames().fullvideoScreen, arguments: [
                //   widget.data,
                //   widget.index
                // ]);
                //    Get.to( VideoApp(widget.url));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: _image,
              ),
            );
          } else {
            return Container(child: Center(child: CircularProgressIndicator()),);
          }
        },
      ),
    );
  }
}

class ThumbnailResult {
  final Image? image;
  final int? dataSize;
  final int? height;
  final int? width;
  const ThumbnailResult({this.image, this.dataSize, this.height, this.width});
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  //WidgetsFlutterBinding.ensureInitialized();
  Uint8List? bytes;
  final Completer<ThumbnailResult> completer = Completer();

  if (r.thumbnailPath != null) {


  } else {
    bytes = await VideoThumbnail.thumbnailData(
        video: r.video!,
        imageFormat: r.imageFormat!,
        maxHeight: r.maxHeight!,
        maxWidth: r.maxWidth!,
        quality: r.quality!);
  }

  // final fileName = await VideoThumbnail.thumbnailFile(
  //   video: r.video!,
  //   thumbnailPath: (await getTemporaryDirectory()).path,
  //   imageFormat: ImageFormat.PNG,
  //   maxHeight: r.maxWidth!,
  //   quality: 100,
  // );

  int _imageDataSize = bytes!.length;
  print("image size: $_imageDataSize");

  final _image = Image.memory(
    bytes,
    fit: BoxFit.cover,
    height: 110,
    width: 120,
  );
  _image.image
      .resolve(ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(ThumbnailResult(
      image: _image,
      dataSize: _imageDataSize,
      height: info.image.height,
      width: info.image.width,
    ));
  }));
  return completer.future;
}

class ThumbnailRequest {
  final String? video;
  final String? thumbnailPath;
  final ImageFormat? imageFormat;
  final int? maxHeight;
  final int? maxWidth;
  final int? timeMs;
  final int? quality;

  const ThumbnailRequest(
      {this.video,
        this.thumbnailPath,
        this.imageFormat,
        this.maxHeight,
        this.maxWidth,
        this.timeMs,
        this.quality});
}