import 'dart:collection';

import 'package:festum_evento/screen/DeshboardShopOffer/screen/offer_add_screen.dart';
import 'package:festum_evento/screen/DeshboardShopOffer/screen/offer_details_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ShopDetialsScreen extends StatefulWidget {
  const ShopDetialsScreen({Key? key}) : super(key: key);

  @override
  State<ShopDetialsScreen> createState() => _ShopDetialsScreenState();
}

class _ShopDetialsScreenState extends State<ShopDetialsScreen> {
  double? sliderValue = 20;

  late int itemCount = 1;

  var _displayAll = false;

  final List listDay = ["SU", "MO", "TU", "WE", "TH", "FR", "SR"];

  HashSet selectItem = new HashSet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/svg/ic_back_arrow.svg",
              color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:
            const SmallText(text: "M4M Fashion", size: 20, color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OfferAddScreen()));
        },
        backgroundColor: AppColors.redColor,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
            shrinkWrap: true,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox(
                              width: double.infinity,
                              height: 170,
                              child: Stack(
                                children: [
                                  Image.network(
                                    "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.edtBgColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: PopupMenuButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(Icons.more_vert,
                                              color: Colors.black),
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem(
                                                value: 1,
                                                child: SmallText(
                                                    text: 'edit'.tr,
                                                    size: 14,
                                                    color: Colors.black),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child: SmallText(
                                                    text: 'show'.tr,
                                                    size: 14,
                                                    color: Colors.black),
                                              ),
                                              PopupMenuItem(
                                                value: 3,
                                                child: SmallText(
                                                    text: 'delete'.tr,
                                                    size: 14,
                                                    color: Colors.black),
                                              ),
                                            ];
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: RatingBar.builder(
                                      itemSize: 18,
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
                                  const SizedBox(width: 3),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: SmallText(
                                              text:
                                                  "905 Annadale Drive Loveland..",
                                              size: 12,
                                              color: AppColors.txtgreyColor),
                                        ),
                                        const SizedBox(width: 3),
                                        SvgPicture.asset(
                                            "assets/svg/ic_address.svg"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 1,
                          color: AppColors.edtBgColor,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/svg/ic_offer_label.svg",
                                      height: 13,
                                      width: 13),
                                  const SizedBox(width: 5),
                                  SmallText(
                                      text: "Running Offers",
                                      size: 12,
                                      color: AppColors.txtgreyColor)
                                ],
                              ),
                              const SmallText(
                                  text: "250 running offers",
                                  size: 14,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 3, bottom: 3),
                      decoration: BoxDecoration(color: AppColors.redColor),
                      child: const SmallText(
                          text: "Cloth shop", size: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                        text: 'about_shop'.tr, size: 16, color: Colors.black),
                    const SizedBox(height: 10),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.txtgreyColor,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 5, right: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OffersDetilsScreen()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      color: Colors.white,
                                      height: 180,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          "https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA",
                                          fit: BoxFit.fill,
                                          width: double.maxFinite,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate:
                                                      (double value) {
                                                    print(value);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 3,
                                                    bottom: 3),
                                                decoration: BoxDecoration(
                                                    color: AppColors.redColor),
                                                child: const SmallText(
                                                    text: "Specific",
                                                    size: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Expanded(
                                                  flex: 5,
                                                  child: SmallText(
                                                      text: "Rainy season sale",
                                                      size: 18,
                                                      color: Colors.black)),
                                              Expanded(
                                                  flex: 2,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: SmallText(
                                                        text: "Paid",
                                                        size: 14,
                                                        color: AppColors
                                                            .greenColor),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      width: double.infinity,
                                      height: 1,
                                      color: AppColors.lineColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          SmallText(
                                              text: "150 Sold",
                                              size: 12,
                                              color: AppColors.txtgreyColor),
                                          Expanded(
                                            child: SliderTheme(
                                              data: SliderTheme.of(context).copyWith(
                                                  trackHeight: 6,
                                                  thumbColor:
                                                      Colors.transparent,
                                                  thumbShape:
                                                      const RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              0.0)),
                                              child: Slider(
                                                thumbColor: Colors.transparent,
                                                min: 0,
                                                max: 100,
                                                activeColor:
                                                    AppColors.darkYellowColor,
                                                inactiveColor:
                                                    AppColors.lineColor,
                                                value: sliderValue!,
                                                onChanged: (value) {
                                                  setState(() {
                                                    sliderValue = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          SmallText(
                                              text: "150 Sold",
                                              size: 12,
                                              color: AppColors.txtgreyColor),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  decoration:
                                      BoxDecoration(color: AppColors.redColor),
                                  child: const SmallText(
                                      text: "July 23, 2021 - July 30, 2021",
                                      size: 12,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    if (itemCount == 1) {
                      itemCount = 4;
                      _displayAll = true;
                    } else {
                      itemCount = 1;
                      _displayAll = false;
                    }
                  });
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmallText(
                          text: _displayAll ? "Show Less" : "Show More",
                          size: 16,
                          color: AppColors.redColor),
                      const SizedBox(width: 10),
                      Icon(
                        _displayAll ? Icons.arrow_upward : Icons.arrow_downward,
                        color: AppColors.redColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                        text: 'company_name'.tr, size: 16, color: Colors.black),
                    const SizedBox(height: 10),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.txtgreyColor,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                        text: 'social_media'.tr, size: 16, color: Colors.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon:
                                SvgPicture.asset("assets/svg/ic_facebook.svg")),
                        IconButton(
                            onPressed: () {},
                            icon:
                                SvgPicture.asset("assets/svg/ic_twitter.svg")),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/png/ic_insta.png")),
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset("assets/svg/ic_yt.svg")),
                        IconButton(
                            onPressed: () {},
                            icon:
                                SvgPicture.asset("assets/svg/ic_telegram.svg")),
                        IconButton(
                            onPressed: () {},
                            icon:
                                SvgPicture.asset("assets/svg/ic_linkdin.svg")),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: 175,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/svg/ic_location.svg",
                            height: 15, width: 12),
                        const SizedBox(width: 10),
                        const Expanded(
                            child: Text(
                          "309 Ridgeview St. Carleton Place, ON K7C 3Y6",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Helvetica',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                              "assets/svg/ic_calender_icon.svg",
                              color: Colors.black,
                              height: 18,
                              width: 18),
                        ),
                        const SizedBox(width: 10),
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
                        const SizedBox(width: 10),
                        const Expanded(
                          flex: 12,
                          child: SmallText(
                              text: "2:00 PM to 4:00 PM",
                              size: 14,
                              color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 12,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
