import 'package:festum_evento/screen/DeshboardShopOffer/screen/shop_add_screen.dart';
import 'package:festum_evento/screen/DeshboardShopOffer/screen/shop_details_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShopOfferModel {
  String imgUri, addressTxt, mainTxt, shopName, runningOffer;

  ShopOfferModel(
      {required this.imgUri,
      required this.addressTxt,
      required this.mainTxt,
      required this.shopName,
      required this.runningOffer});
}

class ShopOfferFragment extends StatefulWidget {
  const ShopOfferFragment({Key? key}) : super(key: key);

  @override
  State<ShopOfferFragment> createState() => _ShopOfferFragmentState();
}

class _ShopOfferFragmentState extends State<ShopOfferFragment> {
  final List<ShopOfferModel> _listOffer = <ShopOfferModel>[
    ShopOfferModel(
        imgUri:
            "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
        addressTxt: "905 Annadale Drive Loveland Drive Loveland Drive Loveland",
        mainTxt: "M4M Fashion",
        shopName: "Cloth shop",
        runningOffer: "250 running offers"),
    ShopOfferModel(
        imgUri:
            "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc",
        addressTxt: "905 Annadale Drive Loveland..",
        mainTxt: "M4M Fashion",
        shopName: "Cloth shop",
        runningOffer: "250 running offers"),
    ShopOfferModel(
        imgUri:
            "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
        addressTxt: "905 Annadale Drive Loveland..",
        mainTxt: "M4M Fashion",
        shopName: "Cloth shop",
        runningOffer: "250 running offers"),
    ShopOfferModel(
        imgUri:
            "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc",
        addressTxt: "905 Annadale Drive Loveland..",
        mainTxt: "M4M Fashion",
        shopName: "Cloth shop",
        runningOffer: "250 running offers"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShopAddScreen()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: AppColors.redColor,
                fixedSize: const Size(double.infinity, 50),
              ),
              child: Row(
                children: [
                  const Icon(Icons.add, size: 17, color: Colors.white),
                  const SizedBox(width: 20),
                  SmallText(
                      text: 'add_your_shop'.tr, size: 16, color: Colors.white)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20),
              shrinkWrap: true,
              itemCount: _listOffer.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopDetialsScreen()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                                      _listOffer[index].imgUri,
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
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: PopupMenuButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(Icons.more_vert,
                                                  color: Colors.black),
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  const PopupMenuItem(
                                                      value: 1,
                                                      child: SmallText(
                                                          text: "Edit",
                                                          size: 14,
                                                          color: Colors.black)),
                                                  const PopupMenuItem(
                                                      value: 2,
                                                      child: SmallText(
                                                          text: "Show",
                                                          size: 14,
                                                          color: Colors.black)),
                                                  const PopupMenuItem(
                                                      value: 3,
                                                      child: SmallText(
                                                          text: "Delete",
                                                          size: 14,
                                                          color: Colors.black)),
                                                ];
                                              },
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: SmallText(
                                              text:
                                                  _listOffer[index].addressTxt,
                                              size: 12,
                                              color: AppColors.txtgreyColor),
                                        ),
                                        const SizedBox(width: 3),
                                        SvgPicture.asset(
                                            "assets/svg/ic_address.svg")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SmallText(
                                      text: _listOffer[index].mainTxt,
                                      size: 18,
                                      color: Colors.black),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    color: AppColors.redColor,
                                    child: Center(
                                      child: SmallText(
                                          text: _listOffer[index].shopName,
                                          size: 12,
                                          color: Colors.white),
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
                                      "assets/svg/ic_offer_label.svg"),
                                  const SizedBox(width: 5),
                                  SmallText(
                                      text: "running offers",
                                      size: 12,
                                      color: AppColors.txtgreyColor)
                                ],
                              ),
                              SmallText(
                                  text: _listOffer[index].runningOffer,
                                  size: 14,
                                  color: Colors.black)
                            ],
                          ),
                        )
                      ],
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
