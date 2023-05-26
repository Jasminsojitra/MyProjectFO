import 'package:festum_evento/screen/DeshboardLiveStream/screen/add_live_stream_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LiveStreamModel {
  String imgUri, mainTxt, dateText, status;

  LiveStreamModel(
      {required this.imgUri,
      required this.mainTxt,
      required this.dateText,
      required this.status});
}

class LiveStreamFragment extends StatefulWidget {
  const LiveStreamFragment({Key? key}) : super(key: key);

  @override
  State<LiveStreamFragment> createState() => _LiveStreamFragmentState();
}

class _LiveStreamFragmentState extends State<LiveStreamFragment> {
  final List<LiveStreamModel> _list = [
    LiveStreamModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainTxt: "Apple WWD Live 2021",
        dateText: "July 23, 2021 - 10:00AM",
        status: "Live"),
    LiveStreamModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainTxt: "Apple WWD Live 2021",
        dateText: "July 23, 2021 - 10:00AM",
        status: "Live"),
    LiveStreamModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainTxt: "Apple WWD Live 2021",
        dateText: "July 23, 2021 - 10:00AM",
        status: "Live"),
    LiveStreamModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainTxt: "Apple WWD Live 2021",
        dateText: "July 23, 2021 - 10:00AM",
        status: "Live"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: AppBar(
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        title: Container(
          decoration: BoxDecoration(
            color: AppColors.appColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'search'.tr,
                  helperStyle: TextStyle(
                      color: AppColors.txtgreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddLiveStreamScreen()));
        },
        backgroundColor: AppColors.redColor,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 20, top: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SvgPicture.asset(
                          _list[index].imgUri,
                          height: 125,
                          width: 125,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.redColor,
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 20,
                                  child: Center(
                                    child: SmallText(
                                        text: _list[index].status,
                                        size: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: SmallText(
                                        text: "Unbox Phone",
                                        size: 12,
                                        color: AppColors.greenColor),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 10),
                          SmallText(
                              text: _list[index].mainTxt,
                              size: 16,
                              color: Colors.black),
                          const SizedBox(height: 20),
                          SmallText(
                              text: _list[index].mainTxt,
                              size: 12,
                              color: AppColors.txtgreyColor),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: RatingBar.builder(
                                  itemSize: 15,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (double value) {
                                    print(value);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.share_sharp,
                                    color: AppColors.txtgreyColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
