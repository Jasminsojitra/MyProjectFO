import 'package:festum_evento/screen/DeshboardShopOffer/screen/onlne_offer_add_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineOfferModel {
  String imgUri, mainTxt, discount, click,category,date;

  OnlineOfferModel(
      {required this.imgUri,
      required this.mainTxt,
      required this.discount,
      required this.click,
      required this.category,
      required this.date});
}

class OnlineOfferFragment extends StatefulWidget {
  const OnlineOfferFragment({Key? key}) : super(key: key);

  @override
  State<OnlineOfferFragment> createState() => _OnlineOfferFragmentState();
}

class _OnlineOfferFragmentState extends State<OnlineOfferFragment> {
  final List<OnlineOfferModel> _listOffer = <OnlineOfferModel>[
    OnlineOfferModel(
        imgUri:
            "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
        discount: "20% Discount",
        mainTxt: "M4M Fashion",
        click: "320k Clicks",
        category: "250 running offers",
        date : "July 23, 2021 - July 30, 2021"),
    OnlineOfferModel(
        imgUri:
        "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
        discount: "20% Discount",
        mainTxt: "M4M Fashion",
        click: "320k Clicks",
        category: "250 running offers",
        date : "July 23, 2021 - July 30, 2021"),
    OnlineOfferModel(
        imgUri:
        "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
        discount: "20% Discount",
        mainTxt: "M4M Fashion",
        click: "320k Clicks",
        category: "250 running offers",
        date : "July 23, 2021 - July 30, 2021"),
    OnlineOfferModel(
        imgUri:
        "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
        discount: "20% Discount",
        mainTxt: "M4M Fashion",
        click: "320k Clicks",
        category: "250 running offers",
        date : "July 23, 2021 - July 30, 2021"),
    OnlineOfferModel(
        imgUri:
        "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
        discount: "20% Discount",
        mainTxt: "M4M Fashion",
        click: "320k Clicks",
        category: "250 running offers",
        date : "July 23, 2021 - July 30, 2021"),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OnlineOfferAddScreen()));
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
                  SmallText(text: 'create_offer'.tr, size: 16, color: Colors.white)
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
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: Stack(
                        children: [
                          ListView(
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
                                                    icon: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.black),
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return [
                                                        PopupMenuItem(
                                                            value: 1,
                                                            child: SmallText(
                                                                text: 'edit'.tr,
                                                                size: 14,
                                                                color:
                                                                Colors.black)),
                                                        PopupMenuItem(
                                                            value: 2,
                                                            child: SmallText(
                                                                text: 'show'.tr,
                                                                size: 14,
                                                                color:
                                                                Colors.black)),
                                                        PopupMenuItem(
                                                            value: 3,
                                                            child: SmallText(
                                                                text: 'delete'.tr,
                                                                size: 14,
                                                                color:
                                                                Colors.black)),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SmallText(text: _listOffer[index].mainTxt, size: 18, color: Colors.black),
                                        const SizedBox(height: 10),
                                        SmallText(text: _listOffer[index].category, size: 12, color: AppColors.greyColor),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: AppColors.redColor
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SmallText(text: _listOffer[index].discount, size: 12, color: Colors.white)
                                        ],
                                      ),
                                    )
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
                                    Image.asset("assets/png/ic_link_twitter.png",height: 20,width: 20),
                                    SmallText(
                                        text: _listOffer[index].click,
                                        size: 14,
                                        color: Colors.black)
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 3, bottom: 3),
                            decoration: BoxDecoration(color: AppColors.redColor),
                            child: const SmallText(
                                text: "July 23, 2021 - July 30, 2021", size: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
