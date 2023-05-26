import 'dart:collection';

import 'package:dotted_border/dotted_border.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OffersOverviewFragment extends StatefulWidget {
  const OffersOverviewFragment({Key? key}) : super(key: key);

  @override
  State<OffersOverviewFragment> createState() => _OffersOverviewFragmentState();
}

class _OffersOverviewFragmentState extends State<OffersOverviewFragment> {
  double sliderValue = 10;

  final List listDay = ["SU", "MO", "TU", "WE", "TH", "FR", "SR"];

  HashSet selectItem = new HashSet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.redColor,
        child: Image.asset("assets/png/ic_scanner.png"),
      ),
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
                      text: "check".tr, size: 18, color: Colors.white))
            ],
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.network(
            "https://fastly.picsum.photos/id/755/5000/3800.jpg?hmac=kHxjzz3TQ4ZQLtUF3fNgIiBMwHc04Kf9xg9jfYsabxM",
            width: double.infinity,
            fit: BoxFit.fill,
            height: 210,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset("assets/svg/ic_calender_icon.svg",
                          color: Colors.black, height: 18, width: 18),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      flex: 12,
                      child: SmallText(
                          text: "July 25, 2021 to July 30, 2021",
                          size: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset("assets/svg/ic_clock.svg",
                          color: Colors.black, height: 18, width: 18),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      flex: 12,
                      child: SmallText(
                          text: "2:00 PM to 4:00 PM",
                          size: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 9,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 7,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: listDay.map((path) {
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (selectItem.contains(path)) {
                                    selectItem.remove(path);
                                  } else {
                                    selectItem.add(path);
                                  }
                                });
                              },
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selectItem.contains(path)
                                              ? AppColors.greenColor
                                              : Colors.transparent),
                                    ),
                                    const SizedBox(height: 5),
                                    SmallText(
                                        text: path,
                                        size: 12,
                                        color: selectItem.contains(path)
                                            ? Colors.black
                                            : AppColors.greyColor),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.location_on,
                          color: Colors.black, size: 24),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 12,
                      child: SmallText(
                          text: "309 Ridgeview St.Carleton Place,ON K7C 3Y6",
                          size: 14,
                          color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                              "https://picsum.photos/id/237/200/300",
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(
                                text: "Specific",
                                size: 12,
                                color: AppColors.redColor),
                            const SizedBox(height: 10),
                            const SmallText(
                                text: "Red Shirt for men",
                                size: 14,
                                color: Colors.black),
                            const SizedBox(height: 10),
                            DottedBorder(
                                padding: const EdgeInsets.all(5),
                                strokeWidth: 1,
                                color: AppColors.greenColor,
                                child: Expanded(
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex : 1,
                                          child: SvgPicture.asset(
                                            "assets/svg/ic_nav_shop.svg",
                                            height: 14,
                                            width: 14,
                                            color: AppColors.greenColor,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          flex: 10,
                                          child: SmallText(
                                              text: "First 100 Gets 20% Discount",
                                              size: 12,
                                              color: AppColors.greenColor),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SmallText(text: 'video'.tr, size: 14, color: AppColors.greyColor),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    "https://fastly.picsum.photos/id/755/5000/3800.jpg?hmac=kHxjzz3TQ4ZQLtUF3fNgIiBMwHc04Kf9xg9jfYsabxM",
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: 150,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
