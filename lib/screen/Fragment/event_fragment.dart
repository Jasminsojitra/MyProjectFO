import 'package:festum_evento/model/list_all_event/ListAllEventModel.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/controller/list_all_event/list_all_event_controller.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../LoadingComponent.dart';

class EventFragment extends StatefulWidget {
  const EventFragment({Key? key}) : super(key: key);

  @override
  State<EventFragment> createState() => _EventFragmentState();
}

class _EventFragmentState extends State<EventFragment> {
  final listAllEventController = Get.put(ListAllEventController());

  double? sliderValue = 0;

  @override
  void initState() {
    listAllEventController.pagingController.addPageRequestListener((pageKey) {
      listAllEventController.listAllEventApi(pageKey);
    });
    super.initState();
  }

  void search(String query) {
    // listAllEventController.listAllEventApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.redColor,
          elevation: 10,
          child: const Icon(Icons.add, size: 30, color: Colors.white),
          onPressed: () {
            Get.toNamed(RouteName.eventCategoryScreen);
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
              child: Center(
                child: TextFormField(
                  controller: listAllEventController.searchController,
                  onChanged: search,
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
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: LoadingComponent(
                child: RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => listAllEventController.pagingController.refresh()),
            child: PagedListView<int, Doc>(
                pagingController: listAllEventController.pagingController,

                builderDelegate: PagedChildBuilderDelegate<Doc>(
                  noItemsFoundIndicatorBuilder: (_) => Center(
                    child: Expanded(
                      child: SmallText(
                          text: "Please Add Events",
                          size: 14,
                          color:AppColors.txtgreyColor),
                    ),
                  ),
                  itemBuilder: (BuildContext context, item, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: InkWell(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.white,
                                  height: 180,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            height: 170,
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  "https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA",
                                                  fit: BoxFit.fill,
                                                  width: double.maxFinite,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Column(
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/svg/ic_round_share_btn.svg",
                                                              fit: BoxFit.cover),
                                                          const SizedBox(
                                                              height: 5),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                      RouteName
                                                                          .eventCategoryScreen,
                                                                      arguments:
                                                                          item)!
                                                                  .then((value) {
                                                                listAllEventController
                                                                    .pagingController
                                                                    .refresh();
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 24,
                                                              width: 24,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24)),
                                                              child: const Center(
                                                                  child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 15)),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 25,
                                                    width: double.infinity,
                                                    color: Colors.black,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const SizedBox(
                                                                  width: 10),
                                                              SvgPicture.asset(
                                                                "assets/svg/ic_calender_icon.svg",
                                                                fit: BoxFit.cover,
                                                                height: 12,
                                                                width: 12,
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Expanded(
                                                                child: SmallText(
                                                                    text:
                                                                        "July 23, 2021 - July 30, 2021",
                                                                    size: 10,
                                                                    color: Colors
                                                                        .white),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              const SizedBox(
                                                                  width: 10),
                                                              SvgPicture.asset(
                                                                "assets/svg/ic_clock.svg",
                                                                fit: BoxFit.cover,
                                                                color:
                                                                    Colors.white,
                                                                height: 12,
                                                                width: 12,
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Expanded(
                                                                child: SmallText(
                                                                  text:
                                                                      "04:00PM - 05:00AM",
                                                                  size: 10,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: -12,
                                          left: -25,
                                          child: Transform.rotate(
                                              angle: 2000 / 360,
                                              child: Container(
                                                height: 40,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: AppColors.redColor,
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    children: const [
                                                      SizedBox(height: 20),
                                                      SmallText(
                                                          text: "PP",
                                                          size: 14,
                                                          color: Colors.white)
                                                    ],
                                                  ),
                                                ),
                                              )))
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 5, bottom: 12),
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
                                              maxRating: 5,
                                              itemCount: 5,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (double value) {
                                                print(value);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: SmallText(
                                                      text: "Vesu, Surat Vesu",
                                                      size: 12,
                                                      color:
                                                          AppColors.txtgreyColor),
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
                                        children: [
                                          Expanded(
                                            child: SmallText(
                                                text: item.name,
                                                size: 18,
                                                color: Colors.black),
                                          ),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                    text: "Surat",
                                                    size: 12,
                                                    color:
                                                        AppColors.txtgreyColor),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: 18,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.redColor),
                                                  child: const SmallText(
                                                      text: "Music",
                                                      size: 12,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 20),
                                  width: double.infinity,
                                  height: 1,
                                  color: AppColors.lineColor,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 20),
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
                                              thumbColor: Colors.transparent,
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                      enabledThumbRadius: 0.0)),
                                          child: Slider(
                                            thumbColor: Colors.transparent,
                                            min: 0,
                                            max: 100,
                                            activeColor:
                                                AppColors.darkYellowColor,
                                            inactiveColor: AppColors.lineColor,
                                            value: sliderValue!,
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  sliderValue = value;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SmallText(
                                          text: "150 Sold",
                                          size: 12,
                                          color: AppColors.txtgreyColor)
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 25,
                                        color: AppColors.darkYellowColor,
                                        child: Center(
                                          child: SmallText(
                                              text: 'unverified'.tr,
                                              size: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 25,
                                        color: AppColors.greenColor,
                                        child: Center(
                                          child: SmallText(
                                              text: 'booking_accepting'.tr,
                                              size: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ),
          ),
              )),
        ],
      ),
    );
  }
}
