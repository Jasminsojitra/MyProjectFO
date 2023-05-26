import 'package:festum_evento/screen/DeshboardEvent/Fragment/overview_fragment.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoVideoGalleryScreen extends StatefulWidget {
  List<GridModel> listImg;

  PhotoVideoGalleryScreen(this.listImg, {Key? key}) : super(key: key);

  @override
  State<PhotoVideoGalleryScreen> createState() =>
      _PhotoVideoGalleryScreenState();
}

class _PhotoVideoGalleryScreenState extends State<PhotoVideoGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ToolbarWidget(
              text: 'photo_video_gallery'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              physics: const ScrollPhysics(),
              itemCount: widget.listImg.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: Image.network(
                      widget.listImg[index].img,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 75,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
