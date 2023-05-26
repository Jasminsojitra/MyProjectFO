import 'package:carousel_slider/carousel_slider.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OurProductScreen extends StatefulWidget {
  const OurProductScreen({Key? key}) : super(key: key);

  @override
  State<OurProductScreen> createState() => _OurProductScreenState();
}

class _OurProductScreenState extends State<OurProductScreen> {
  List<String> list = [
    "assets/png/ic_link_facebook.png",
    "assets/png/ic_link_insta.png",
    "assets/png/ic_link_linkdein.png",
    "assets/png/ic_link_pintrest.png",
    "assets/png/ic_link_twitter.png",
    "assets/png/ic_link_yt.png",
  ];

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/svg/ic_back_arrow.svg"),
        ),
        title: SmallText(text: 'our_product'.tr, size: 16, color: Colors.black),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 20),
          CarouselSlider.builder(
            carouselController: buttonCarouselController,
            itemCount: list.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Transform.scale(
                scale: itemIndex == list[itemIndex] ? 1.0 : 0.90,
                child: InkWell(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          offset: const Offset(1.0, 1.0),
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: Center(
                        child: Image.asset(
                          list[itemIndex],
                          height: 80,
                          width: 80,
                        )),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 75,
              viewportFraction: 0.2,
              enlargeFactor: 0.2,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallText(text: 'evento_package'.tr, size: 18, color: Colors.black),
                const SizedBox(height: 10),
                Text(
                  'evento_des'.tr,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider.builder(
            carouselController: buttonCarouselController,
            itemCount: list.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Transform.scale(
                scale: itemIndex == list[itemIndex] ? 1.0 : 0.90,
                child: InkWell(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          offset: const Offset(1.0, 1.0),
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: Center(
                        child: Image.asset(
                          list[itemIndex],
                          height: 80,
                          width: 80,
                        )),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 75,
              viewportFraction: 0.2,
              enlargeFactor: 0.2,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallText(text: 'friends_fields'.tr, size: 18, color: Colors.black),
                const SizedBox(height: 10),
                Text(
                  'evento_des'.tr,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider.builder(
            carouselController: buttonCarouselController,
            itemCount: list.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Transform.scale(
                scale: itemIndex == list[itemIndex] ? 1.0 : 0.90,
                child: InkWell(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          offset: const Offset(1.0, 1.0),
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: Center(
                        child: Image.asset(
                          list[itemIndex],
                          height: 80,
                          width: 80,
                        )),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 75,
              viewportFraction: 0.2,
              enlargeFactor: 0.2,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallText(text: 'fcoin'.tr, size: 18, color: Colors.black),
                const SizedBox(height: 10),
                Text(
                  'evento_des'.tr,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider.builder(
            carouselController: buttonCarouselController,
            itemCount: list.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Transform.scale(
                scale: itemIndex == list[itemIndex] ? 1.0 : 0.90,
                child: InkWell(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          offset: const Offset(1.0, 1.0),
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: Center(
                        child: Image.asset(
                          list[itemIndex],
                          height: 80,
                          width: 80,
                        )),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 75,
              viewportFraction: 0.2,
              enlargeFactor: 0.2,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallText(text: 'festum_ads_mdia'.tr, size: 18, color: Colors.black),
                const SizedBox(height: 10),
                Text(
                  'evento_des'.tr,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
