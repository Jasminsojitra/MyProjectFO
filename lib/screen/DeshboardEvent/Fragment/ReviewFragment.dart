import 'package:flutter/material.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReviewModel {
  String usreImg, mainTxt, dateTxt, descTxt, rating;

  ReviewModel(
      {required this.usreImg,
      required this.mainTxt,
      required this.dateTxt,
      required this.descTxt,
      required this.rating});
}

class ReviewFragment extends StatefulWidget {
  const ReviewFragment({Key? key}) : super(key: key);

  @override
  State<ReviewFragment> createState() => _ReviewFragmentState();
}

class _ReviewFragmentState extends State<ReviewFragment> {
  double? sliderValue = 10;

  final List<ReviewModel> listReview = <ReviewModel>[
    ReviewModel(
        mainTxt: "Reynaldo Franklin Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        descTxt: "\$560.00",
        rating: "15 Ticket",
        usreImg: 'assets/svg/ic_both.svg'),
    ReviewModel(
        mainTxt: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        descTxt: "\$560.00",
        rating: "15 Ticket",
        usreImg: 'assets/svg/ic_both.svg'),
    ReviewModel(
        mainTxt: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        descTxt: "\$560.00",
        rating: "15 Ticket",
        usreImg: 'assets/svg/ic_both.svg'),
    ReviewModel(
        mainTxt: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        descTxt: "\$560.00",
        rating: "15 Ticket",
        usreImg: 'assets/svg/ic_both.svg'),
  ];

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
                        child: SizedBox(
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
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  itemCount: listReview.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: Container(
                                padding: const EdgeInsets.all(5),
                                height: 36,
                                width: 36,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: SvgPicture.asset(
                                  listReview[index].usreImg,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(
                                      text: listReview[index].mainTxt,
                                      size: 16,
                                      color: Colors.black),
                                  const SizedBox(height: 5),
                                  SmallText(
                                      text: listReview[index].dateTxt,
                                      size: 12,
                                      color: AppColors.greyColor),
                                ],
                              ),
                              trailing: RatingBar.builder(
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
                            const SizedBox(height: 10),
                            Text(
                              "Its origins date back to 45 BC. In fact, his words were randomly extracted from the De finibus bonorum et malorum , a classic of Latin literature written by Cicero over 2000 years ago.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.txtgreyColor),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
