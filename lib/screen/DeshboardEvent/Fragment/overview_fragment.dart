import 'package:festum_evento/screen/DeshboardEvent/screen/photo_video_gallery_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GridModel {
  final String img;

  GridModel(this.img);
}

class OverviewFragment extends StatefulWidget {
  const OverviewFragment({Key? key}) : super(key: key);

  @override
  State<OverviewFragment> createState() => _OverviewFragmentState();
}

class _OverviewFragmentState extends State<OverviewFragment> {
  double? sliderValue = 10;

  List<GridModel> listImg = <GridModel>[
    GridModel(
        "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU"),
    GridModel(
        "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc"),
    GridModel(
        "https://fastly.picsum.photos/id/15/2500/1667.jpg?hmac=Lv03D1Y3AsZ9L2tMMC1KQZekBVaQSDc1waqJ54IHvo4"),
    GridModel(
        "https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA"),
    GridModel(
        "https://fastly.picsum.photos/id/27/3264/1836.jpg?hmac=p3BVIgKKQpHhfGRRCbsi2MCAzw8mWBCayBsKxxtWO8g"),
    GridModel(
        "https://fastly.picsum.photos/id/29/4000/2670.jpg?hmac=rCbRAl24FzrSzwlR5tL-Aqzyu5tX_PA95VJtnUXegGU"),
    GridModel(
        "https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA"),
    GridModel(
        "https://fastly.picsum.photos/id/27/3264/1836.jpg?hmac=p3BVIgKKQpHhfGRRCbsi2MCAzw8mWBCayBsKxxtWO8g"),
  ];
  List<GridModel> removeListImage = [];

  @override
  void initState() {
    for (var i = 0; i < listImg.length; i++) {
      if (i > 0) removeListImage.add(listImg[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      bottomNavigationBar: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.transparent,
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 0.0)),
                child: Slider(
                  thumbColor: Colors.transparent,
                  min: 0,
                  max: 100,
                  activeColor: AppColors.greenColor,
                  inactiveColor: AppColors.sliderColor,
                  value: sliderValue!,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(
                            text: 'sold'.tr,
                            size: 18,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.normal),
                        const SmallText(
                            text: "2556", size: 18, color: Colors.black),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(
                            text: 'unsold'.tr,
                            size: 18,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.normal),
                        const SmallText(
                            text: "2556", size: 18, color: Colors.black),
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      fixedSize: const Size(double.maxFinite, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                  child: SmallText(
                      text: 'check'.tr, size: 18, color: Colors.white))
            ],
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 235,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(
                          "https://fastly.picsum.photos/id/755/5000/3800.jpg?hmac=kHxjzz3TQ4ZQLtUF3fNgIiBMwHc04Kf9xg9jfYsabxM",
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 210,
                        ),
                      ],
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 25,
                                      color: AppColors.redColor,
                                      child: const Center(
                                        child: SmallText(
                                            text: "Music",
                                            size: 14,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 72,
                                      height: 25,
                                      color: AppColors.greenColor,
                                      child: const Center(
                                        child: SmallText(
                                            text: "Festival",
                                            size: 14,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_booth.svg"),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_booth.svg"),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_booth.svg"),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                        text: "Business to Business",
                        size: 14,
                        color: AppColors.redColor),
                    const SizedBox(height: 5),
                    const SmallText(
                        text:
                            "Simply dummy text of the printing and typesetting\nindustry. Lorem Ipsum has been.",
                        size: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                              "assets/svg/ic_calender_icon.svg",
                              height: 18,
                              width: 18,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 12,
                          child: SmallText(
                              text: "July 25, 2021 to July 30, 2021",
                              size: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset("assets/svg/ic_clock.svg",
                              height: 18, width: 18, color: Colors.black),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 12,
                          child: SmallText(
                              text: "2:00 PM to 4:00 PM",
                              size: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset("assets/svg/ic_location.svg",
                              height: 18, width: 18, color: Colors.black),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 12,
                          child: SmallText(
                              text:
                                  "309 Ridgeview St.Carleton Place,\nON K7C 3Y6",
                              size: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                              text: 'equipment_description'.tr,
                              size: 12,
                              color: AppColors.txtgreyColor),
                          const SizedBox(height: 5),
                          const Text(
                            "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                              text: 'food_description'.tr,
                              size: 12,
                              color: AppColors.txtgreyColor),
                          const SizedBox(height: 5),
                          const Text(
                            "Stablished fact that a reader will be distracted by the readable content of a page when looking at its layout Dummy text.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SmallText(
                        text: 'photo_video_gallery'.tr,
                        size: 12,
                        color: AppColors.greyColor),
                    const SizedBox(height: 5),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 160,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listImg.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: listImg.length == 1 ? 1 : 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            return index == 0
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.white,
                                      child: Image.network(
                                        listImg[index].img,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 75,
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    itemCount: removeListImage.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                removeListImage.length == 1
                                                    ? 1
                                                    : 2,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5),
                                    itemBuilder: (context, indexs) {
                                      return indexs < 3
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 80,
                                                color: Colors.white,
                                                width: 80,
                                                child: Image.network(
                                                  removeListImage[indexs].img,
                                                  fit: BoxFit.cover,
                                                  width: 80,
                                                  height: 75,
                                                ),
                                              ),
                                            )
                                          : indexs == 3
                                              ? _seeNoSeeMore()
                                              : Container();
                                    });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5)),
                            ),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SmallText(
                                      text: 'ticket'.tr,
                                      size: 12,
                                      color: Colors.white),
                                ),
                                Expanded(
                                  child: SmallText(
                                      text: 'price'.tr,
                                      size: 12,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Expanded(
                                  child: SmallText(
                                      text: "10",
                                      size: 14,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: SmallText(
                                      text: "\$2500.00",
                                      size: 14,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: AppColors.edtBgColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Expanded(
                                  child: SmallText(
                                      text: "10",
                                      size: 14,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: SmallText(
                                      text: "\$2500.00",
                                      size: 14,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: AppColors.edtBgColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Expanded(
                                  child: SmallText(
                                      text: "10",
                                      size: 14,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: SmallText(
                                      text: "\$2500.00",
                                      size: 14,
                                      color: Colors.black),
                                )
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
          )
        ],
      ),
    );
  }

  Widget _seeNoSeeMore() {
    return InkWell(
      onTap: () {
        setState(() {
          // _displayAll = !_displayAll;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhotoVideoGalleryScreen(listImg)));
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: AppColors.appColor,
          height: 80,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'show_all'.tr,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
