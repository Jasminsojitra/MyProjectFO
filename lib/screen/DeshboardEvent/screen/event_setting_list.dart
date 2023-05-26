import 'package:festum_evento/screen/DeshboardEvent/screen/event_sitting_arrangement.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/utils/app_url.dart';
import 'package:festum_evento/view_models/controller/arragement_item/arrangement_item_controller.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../LoadingComponent.dart';

class EventSettingListScreen extends StatefulWidget {
  const EventSettingListScreen({Key? key}) : super(key: key);

  @override
  State<EventSettingListScreen> createState() => _EventSettingListScreenState();
}

class _EventSettingListScreenState extends State<EventSettingListScreen> {
  final arragmentItemController = Get.put(ArrangementItemController());

  var ids = Get.arguments;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      arragmentItemController.getArrangement();
      arragmentItemController.getArrangementList();
    });

    super.initState();
  }

  var selected = false;

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
        backgroundColor: AppColors.edtBgColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.redColor,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Dialog(
                        backgroundColor: AppColors.edtBgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SmallText(
                                    text: 'select_any'.tr,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_close.svg",
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              arragmentItemController.arrangeModel!.data != null
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: arragmentItemController
                                          .arrangeModel!.data!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Container(
                                            height: 65,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: ListTile(
                                                leading: Image.network(
                                                    AppUrl.imageUrl +
                                                        arragmentItemController
                                                            .arrangeModel!
                                                            .data![index]
                                                            .itemimage!),
                                                title: SmallText(
                                                    text: arragmentItemController
                                                        .arrangeModel!
                                                        .data![index]
                                                        .itemname!,
                                                    size: 20,
                                                    color: Colors.black),
                                                trailing: Transform.scale(
                                                    scale: 1.5,
                                                    child: Checkbox(
                                                      shape: CircleBorder(),
                                                      value:
                                                          arragmentItemController
                                                              .arrangeModel!
                                                              .data![index]
                                                              .isSelected,
                                                      activeColor:
                                                          AppColors.greenColor,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          for (var element
                                                              in arragmentItemController
                                                                  .arrangeModel!
                                                                  .data!) {
                                                            element.isSelected =
                                                                false;
                                                          }
                                                          arragmentItemController
                                                                  .arrangeModel!
                                                                  .data![index]
                                                                  .isSelected =
                                                              value ?? false;
                                                          Navigator.pop(context);
                                                          arragmentItemController.title = arragmentItemController
                                                              .arrangeModel!
                                                              .data![
                                                          index]
                                                              .itemname!;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => EventSittingArrangement(
                                                                      title: arragmentItemController.title,
                                                                      seatingKey: arragmentItemController
                                                                          .arrangeModel!
                                                                          .data![
                                                                              index]
                                                                          .sId!,))).then(
                                                              (value) {
                                                            refresh();
                                                          });
                                                        });
                                                      },
                                                    )),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : Container()
                            ],
                          ),
                        ));
                  });
                });
          },
        ),
        bottomNavigationBar: BottomButtonWidgets(
            onBackPress: () {
              Navigator.pop(context);
            },
            onNextPress: () {
              arragmentItemController.arrangements!.data!.sId = ids;
              arragmentItemController.addArrangementEventApi();
            },
            firstTxt: 'back'.tr,
            secondTxt: 'next'.tr),
        body: GetBuilder<ArrangementItemController>(
    builder: (arrangementss) {
        return

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWidget(
                text: 'let_create_it'.tr,
                tapCallback: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: arragmentItemController
                          .arrangements!.data==null &&arragmentItemController.arrangeModel!.data==null
                  ? Container()
                  : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: arragmentItemController
                            .arrangements!.data!.seatingArrangements!.length,
                        itemBuilder: (context, index) {
                          var dataArr = arragmentItemController.arrangements!
                              .data!.seatingArrangements![index].arrangements;
                          var itemdata = arragmentItemController.arrangeModel!.data!
                              .where((element) =>
                                  element.sId ==
                                  arragmentItemController.arrangements!
                                      .data!.seatingArrangements![index].seatingItem!.sId).single;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ExpansionTile(
                                onExpansionChanged: ((bool ex) {
                                  setState(() {
                                    arragmentItemController.arrangements!
                                        .data!.seatingArrangements![index].isExpand = ex;
                                  });
                                }),
                                title: BigText(
                                    text: itemdata.itemname!,
                                    color: Colors.black,
                                    weight: FontWeight.bold,
                                    size: 16),
                                leading: Image.network(
                                    AppUrl.imageUrl + itemdata.itemimage!,
                                    height: 30,
                                    width: 30),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          arragmentItemController.arrangements!.data!.seatingArrangements!.removeAt(index);
                                        });
                                      },
                                      child: SvgPicture.asset("assets/svg/ic_delete.svg",
                                          height: 20,
                                          width: 20,
                                          color: AppColors.greyColor),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: (){
                                        print("Name==="+itemdata.itemname!);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventSittingArrangement(arrangementss : arragmentItemController.arrangements!.data!.seatingArrangements![index].arrangements,
                                        seatingKey: arragmentItemController.arrangements!.data!.seatingArrangements![index].seatingItem!.sId!,
                                        seatingArrangements:arragmentItemController.arrangements!.data!.seatingArrangements![index]!,
                                        indexs: index,
                                        title: itemdata.itemname!,isEdit : true))).then((value) {
                                          for (var arr in arragmentItemController.arrangements!.data!.seatingArrangements!) {
                                            arr.isExpand=false;
                                          }
                                          setState(() {
                                          });
                                        });
                                      },
                                      child: SvgPicture.asset("assets/svg/ic_edit.svg",
                                          height: 18,
                                          width: 18,
                                          color: AppColors.greyColor),
                                    ),
                                    const SizedBox(width: 10),
                                    arragmentItemController.arrangements!
                                            .data!.seatingArrangements![index].isExpand
                                        ? SvgPicture.asset(
                                            "assets/svg/ic_top_arrow.svg",
                                            height: 10,
                                            width: 10,
                                            color: AppColors.greyColor)
                                        : SvgPicture.asset(
                                            "assets/svg/ic_down_arrow.svg",
                                            height: 10,
                                            width: 10,
                                            color: AppColors.greyColor),
                                  ],
                                ),
                                children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemCount: dataArr!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Container(
                                                height: 1,
                                                color: AppColors.chkBodarColor,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SmallText(
                                                                text: 'no_of'.tr,
                                                                size: 12,
                                                                color: AppColors
                                                                    .greyColor),
                                                            const SizedBox(
                                                                height: 3),
                                                            SmallText(
                                                                text: dataArr![
                                                                        index]
                                                                    .numberOfSeatingItem
                                                                    .toString(),
                                                                size: 14,
                                                                color:
                                                                    Colors.black),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SmallText(
                                                                text: 'location'.tr,
                                                                size: 12,
                                                                color: AppColors
                                                                    .greyColor),
                                                            const SizedBox(
                                                                height: 3),
                                                            SmallText(
                                                                text:
                                                                    "${dataArr![index].verticalLocation} - ${dataArr![index].horizontalLocation}",
                                                                size: 14,
                                                                color:
                                                                    Colors.black),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SmallText(
                                                                text:
                                                                    'total_person_capacity'
                                                                        .tr,
                                                                size: 12,
                                                                color: AppColors
                                                                    .greyColor),
                                                            const SizedBox(
                                                                height: 3),
                                                            SmallText(
                                                                text:
                                                                    dataArr![index]
                                                                        .totalPerson
                                                                        .toString(),
                                                                size: 14,
                                                                color:
                                                                    Colors.black),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SmallText(
                                                                text: 'total_amount'
                                                                    .tr,
                                                                size: 12,
                                                                color: AppColors
                                                                    .greyColor),
                                                            const SizedBox(
                                                                height: 3),
                                                            SmallText(
                                                                text:
                                                                    dataArr![index]
                                                                        .totalAmount
                                                                        .toString(),
                                                                size: 14,
                                                                color:
                                                                    Colors.black),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  dataArr![index].description!.isEmpty?Container():Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SmallText(
                                                          text: 'description'.tr,
                                                          size: 12,
                                                          color: AppColors
                                                              .greyColor),
                                                      const SizedBox(
                                                          height: 3),

                                                      Text("${dataArr![index].description}",
                                                        style: TextStyle(fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color:
                                                          Colors.black)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        );
                                      }),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15),
                                    child: Container(
                                      height: 1,
                                      color: AppColors.chkBodarColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/svg/ic_food.svg",
                                                      height: 35,
                                                      width: 35,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        SmallText(
                                                            text: 'food'.tr,
                                                            size: 14,
                                                            color: AppColors
                                                                .greyColor),
                                                        SmallText(
                                                            text: arragmentItemController.arrangements!.data!.seatingArrangements![index].food == "BOTH" ? "VEG-NONVEG":arragmentItemController.arrangements!.data!.seatingArrangements![index].food!,
                                                            size: 12,
                                                            color: Colors.black),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/svg/ic_repaire.svg",
                                                      height: 35,
                                                      width: 35,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        SmallText(
                                                            text: 'equipment'.tr,
                                                            size: 14,
                                                            color: AppColors
                                                                .greyColor),
                                                        SmallText(
                                                            text: arragmentItemController
                                                                        .arrangements!
                                                                        .data!.seatingArrangements![
                                                            index]
                                                                        .equipment! ==
                                                                    true
                                                                ? "Include"
                                                                : "Exclude",
                                                            size: 12,
                                                            color: Colors.black),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
            )
          ],
        );
    }
      ),
    ));
  }
}
