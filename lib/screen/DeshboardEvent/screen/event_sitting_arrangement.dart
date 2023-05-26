
import 'package:festum_evento/model/arrangement_item_model/GetarrangementlistModel.dart';
import 'package:festum_evento/screen/DeshboardEvent/widget/select_food.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:festum_evento/view_models/controller/arragement_item/arrangement_item_controller.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EventSittingArrangement extends StatefulWidget {
  String? title;
  String? seatingKey;
  bool isEdit;
  int? indexs;
  List<Arrangements>? arrangementss;
  SeatingArrangements? seatingArrangements;

  EventSittingArrangement(
      {Key? key, this.title, this.seatingKey, this.seatingArrangements, this.isEdit = false, this.arrangementss, this.indexs})
      : super(key: key);

  @override
  State<EventSittingArrangement> createState() =>
      _EventSittingArrangementState();
}

class _EventSittingArrangementState extends State<EventSittingArrangement> {
  final arragmentItemController = Get.put(ArrangementItemController());
  final addTableKey = GlobalKey<FormState>();

  final hello = Get.arguments;

  int isSeleted = 0;
  int isHorizontalSeleted = 0;
  int foodSeleted = 0;
  int equipmentSeleted = 0;
  String vertical = "front";
  String horizontal = "none";
  String isVerticalText = "FRONT";
  String isHorizontalText = "NONE";
  String foodText = "VEG";
  bool equipmentText = true;
  bool isSwitched = false;

  TextEditingController noTableController = TextEditingController();
  TextEditingController perTablePersoneController = TextEditingController();
  TextEditingController totalPersonController = TextEditingController();
  TextEditingController perTablePriceController = TextEditingController();
  TextEditingController perPersonPriceController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();
  TextEditingController equipmentDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    arragmentItemController.total_number_of_seating_items = 0;
    arragmentItemController.total_per_seating_persons = 0;
    arragmentItemController.total_persons = 0;
    arragmentItemController.per_seating_price = 0;
    arragmentItemController.per_person_price = 0;
    arragmentItemController.total_amount = 0;
    arragmentItemController.total_number_of_seating_items = 0;
    foodDescriptionController.text = "";
    equipmentDescriptionController.text = "";
    arragmentItemController.arrangements_Items = [];
    if (widget.isEdit) {
      var data = widget.seatingArrangements;
      for (var arr in widget.seatingArrangements!.arrangements!) {
        arr.isExpand=false;
      }

      foodDescriptionController.text = data!.foodDescription ?? "";
      equipmentDescriptionController.text = data!.equipmentDescription ?? "";
      if ("VEG".toLowerCase() ==
          widget.seatingArrangements!.food!.toLowerCase()) {
        foodSeleted = 0;
      }
      if ("NONVEG".toLowerCase() ==
          widget.seatingArrangements!.food!.toLowerCase()) {
        foodSeleted = 1;
      }
      if ("BOTH".toLowerCase() ==
          widget.seatingArrangements!.food!.toLowerCase()) {
        foodSeleted = 2;
      }
      if ("NONE".toLowerCase() ==
          widget.seatingArrangements!.food!.toLowerCase()) {
        foodSeleted = 3;
      }
      if (widget.seatingArrangements!.equipment ?? false) {
        equipmentSeleted = 0;
      }
      else {
        equipmentSeleted = 1;
      }
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
        backgroundColor: AppColors.edtBgColor,
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.boxLineColor,
                      fixedSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: SmallText(text: 'Cancel'.tr.toUpperCase(),
                      size: 18,
                      color: Colors.white)),
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      fixedSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    number_of_seating_item();
                    if (arragmentItemController.arrangements_Items!.length >
                        0 || widget.isEdit) {
                      if (widget.isEdit) {
                        arragmentItemController.arrangements!
                            .data!.seatingArrangements![widget.indexs!] =
                            SeatingArrangements(
                                seatingItem: SeatingItem(
                                  sId: widget.seatingKey,
                                ),
                                arrangements: widget.seatingArrangements!
                                    .arrangements!,
                                food: foodText,
                                foodDescription: foodDescriptionController.text,
                                equipment: equipmentText,
                                equipmentDescription:
                                equipmentDescriptionController.text,
                                totalCalculations: TotalCalculations(
                                    totalNumberOfSeatingItems: arragmentItemController
                                        .total_number_of_seating_items,
                                    totalPerSeatingPersons: arragmentItemController
                                        .total_per_seating_persons ??
                                        0,
                                    totalPersons: arragmentItemController
                                        .total_persons,
                                    perSeatingPrice:
                                    arragmentItemController.per_seating_price ??
                                        0.0,
                                    perPersonPrice:
                                    arragmentItemController.per_person_price,
                                    totalAmount: arragmentItemController
                                        .total_amount,
                                    totalBooked: 0));
                        //=widget.seatingArrangements;
                      }
                      else {
                        arragmentItemController.arrangements!.data!
                            .seatingArrangements!.add(
                            SeatingArrangements(
                                seatingItem: SeatingItem(
                                  sId: widget.seatingKey,
                                ),
                                arrangements: arragmentItemController
                                    .arrangements_Items!
                                    .toList(),
                                food: foodText,
                                foodDescription: foodDescriptionController.text,
                                equipment: equipmentText,
                                equipmentDescription:
                                equipmentDescriptionController.text,
                                totalCalculations: TotalCalculations(
                                    totalNumberOfSeatingItems: arragmentItemController
                                        .total_number_of_seating_items,
                                    totalPerSeatingPersons: arragmentItemController
                                        .total_per_seating_persons ??
                                        0,
                                    totalPersons: arragmentItemController
                                        .total_persons,
                                    perSeatingPrice:
                                    arragmentItemController.per_seating_price ??
                                        0.0,
                                    perPersonPrice:
                                    arragmentItemController.per_person_price,
                                    totalAmount: arragmentItemController
                                        .total_amount,
                                    totalBooked: 0))
                        );
                      }
                      arragmentItemController.arrangements_Items!.clear();
                      Navigator.pop(context, true);
                    }
                    else {
                      Utils.toastMessage(widget.isEdit?"Edit":"Add"+ "${widget.title!} Details");
                    }
                  },
                  child: SmallText(text: (widget.isEdit?"Edit":'Add').tr.toUpperCase(),
                      size: 18,
                      color: Colors.white)),
            ),
          ],
        ),
        body: GetBuilder<ArrangementItemController>(
          builder: (arragmentItemController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToolbarWidget(
                  text: (widget.isEdit?"Edit":"Add").tr + " ${widget.title!}",
                  tapCallback: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: !widget.isEdit
                        ? arragmentItemController.arrangements_Items!.length !=
                        null
                        ? ListView(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              addDetailsDialog(false, 0,false);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(5),
                              ),
                              backgroundColor: AppColors.redColor,
                              fixedSize:
                              const Size(double.infinity, 50),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.add,
                                    size: 25, color: Colors.white),
                                const SizedBox(width: 10),
                                SmallText(
                                    text:
                                    'Add ${widget.title} Details'
                                        .tr,
                                    size: 16,
                                    color: Colors.white)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: arragmentItemController
                                  .arrangements_Items!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    child: ExpansionTile(
                                      childrenPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      title: SmallText(
                                          text: widget.title!,
                                          size: 16,
                                          color: Colors.black),
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmallText(
                                                        text:
                                                        "${'no_of'.tr} ${widget
                                                            .title!}",
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text: arragmentItemController
                                                            .arrangements_Items![
                                                        index]
                                                            .numberOfSeatingItem
                                                            .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    widget.title! ==
                                                        "Stand" ||
                                                        widget.title! ==
                                                            "Chair"
                                                        ? Container()
                                                        : Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SmallText(
                                                            text:
                                                            "${'per'
                                                                .tr} ${widget
                                                                .title} ${'price'
                                                                .tr}",
                                                            size:
                                                            12,
                                                            color: AppColors
                                                                .greyColor),
                                                        const SizedBox(
                                                            height:
                                                            3),
                                                        SmallText(
                                                            text: arragmentItemController
                                                                .arrangements_Items![
                                                            index]
                                                                .perSeatingPrice
                                                                .toString(),
                                                            size:
                                                            14,
                                                            color: Colors
                                                                .black),
                                                        const SizedBox(
                                                            height:
                                                            20),
                                                      ],
                                                    ),
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
                                                        text: arragmentItemController
                                                            .arrangements_Items![
                                                        index]
                                                            .totalPerson
                                                            .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    SmallText(
                                                        text:
                                                        'total_amount'
                                                            .tr,
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text: arragmentItemController
                                                            .arrangements_Items![
                                                        index]
                                                            .totalAmount
                                                            .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                  ],
                                                )),
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmallText(
                                                        text:
                                                        "${widget
                                                            .title!} ${'location'
                                                            .tr}",
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text: arragmentItemController
                                                            .arrangements_Items![
                                                        index]
                                                            .verticalLocation
                                                            .toString() +
                                                            " - " +
                                                            arragmentItemController
                                                                .arrangements_Items![
                                                            index]
                                                                .horizontalLocation
                                                                .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    widget.title! ==
                                                        "Stand" ||
                                                        widget.title! ==
                                                            "Chair"
                                                        ? Container()
                                                        : Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SmallText(
                                                            text:
                                                            "${'per'
                                                                .tr} ${widget
                                                                .title} ${'price'
                                                                .tr}",
                                                            size:
                                                            12,
                                                            color: AppColors
                                                                .greyColor),
                                                        const SizedBox(
                                                            height:
                                                            3),
                                                        SmallText(
                                                            text: arragmentItemController
                                                                .arrangements_Items![
                                                            index]
                                                                .perSeatingPrice
                                                                .toString(),
                                                            size:
                                                            14,
                                                            color: Colors
                                                                .black),
                                                        const SizedBox(
                                                            height:
                                                            20),
                                                      ],
                                                    ),
                                                    SmallText(
                                                        text:
                                                        'per_person_price'
                                                            .tr,
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text: "${arragmentItemController
                                                            .arrangements_Items![
                                                        index]
                                                            .perPersonPrice}",
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    widget.title! ==
                                                        "Stand" ||
                                                        widget.title! ==
                                                            "Chair"
                                                        ? Container()
                                                        : Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SmallText(
                                                            text: 'booking_accepting'
                                                                .tr,
                                                            size:
                                                            12,
                                                            color: AppColors
                                                                .greyColor),
                                                        const SizedBox(
                                                            height:
                                                            3),
                                                        SmallText(
                                                            text: arragmentItemController
                                                                .arrangements_Items![index]
                                                                .bookingAcceptance ==
                                                                true
                                                                ? "Per Person"
                                                                : 'per'.tr +
                                                                " " +
                                                                widget.title!,
                                                            size: 14,
                                                            color: Colors
                                                                .black),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        arragmentItemController
                                            .arrangements_Items![index]
                                            .description!.isEmpty ?
                                        Container() : Align(
                                          alignment:
                                          Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            children: [
                                              SmallText(
                                                  text: 'description'
                                                      .tr,
                                                  size: 12,
                                                  color: AppColors
                                                      .greyColor),
                                              const SizedBox(
                                                  height: 3),
                                              Text(
                                                arragmentItemController
                                                    .arrangements_Items![
                                                index]
                                                    .description
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                    Colors.black,
                                                    fontFamily:
                                                    'Helvetica',
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        arragmentItemController
                                            .arrangements_Items![index]
                                            .description!.isEmpty ?
                                        Container() : const SizedBox(
                                            height: 20),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: 'select_food'.tr,
                                  size: 14,
                                  color: AppColors.greyColor),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 0;
                                          foodText = "VEG";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_veg.svg",
                                          txtName: 'veg'.tr,
                                          isSelect: foodSeleted == 0),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 1;
                                          foodText = "NONVEG";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_non_veg.svg",
                                          txtName: 'non_veg'.tr,
                                          isSelect: foodSeleted == 1),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 2;
                                          foodText = "BOTH";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_both.svg",
                                          txtName: 'both'.tr,
                                          isSelect: foodSeleted == 2),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 3;
                                          foodText = "NONE";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_non.svg",
                                          txtName: 'none'.tr,
                                          isSelect: foodSeleted == 3),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              EditTextWidget(
                                  line: 3,
                                  isCompulsoryText: false,
                                  text: 'food_dexcription'.tr,
                                  textEditingController:
                                  foodDescriptionController,
                                  textInputAction:
                                  TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'enter_food_description'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                              const SizedBox(height: 20),
                              SmallText(
                                  text: 'select_Equipment'.tr,
                                  size: 14,
                                  color: AppColors.greyColor),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          equipmentSeleted = 0;
                                          equipmentText = true;
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_equipment.svg",
                                          txtName: 'equipment'.tr,
                                          isSelect:
                                          equipmentSeleted == 0),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          equipmentSeleted = 1;
                                          equipmentText = false;
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_non.svg",
                                          txtName: 'none'.tr,
                                          isSelect:
                                          equipmentSeleted == 1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              EditTextWidget(
                                  line: 3,
                                  isCompulsoryText: false,
                                  text: 'equipment_description'.tr,
                                  textEditingController:
                                  equipmentDescriptionController,
                                  textInputAction:
                                  TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'enter_equipment_description'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ])
                        : Container()
                        : widget.seatingArrangements != null
                        ? ListView(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              addDetailsDialog(true, 0,true);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(5),
                              ),
                              backgroundColor: AppColors.redColor,
                              fixedSize:
                              const Size(double.infinity, 50),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.add,
                                    size: 25, color: Colors.white),
                                const SizedBox(width: 10),
                                SmallText(
                                    text:
                                    'Add ${widget.title} Details'
                                        .tr,
                                    size: 16,
                                    color: Colors.white)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: widget.seatingArrangements!
                                  .arrangements!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    child: ExpansionTile(
                                      onExpansionChanged: ((bool ex) {
                                        setState(() {
                                          widget.seatingArrangements!
                                              .arrangements![index]
                                              .isExpand = ex;
                                        });
                                      }),
                                      trailing: Row(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              noTableController.text =
                                                  widget.seatingArrangements!
                                                      .arrangements![index]
                                                      .numberOfSeatingItem
                                                      .toString();
                                              perTablePersoneController.text =
                                                  widget.seatingArrangements!
                                                      .arrangements![index]
                                                      .perSeatingPerson
                                                      .toString();
                                              totalPersonController.text =
                                                  widget.seatingArrangements!
                                                      .arrangements![index]
                                                      .totalPerson.toString();
                                              perTablePriceController.text =
                                                  widget.seatingArrangements!
                                                      .arrangements![index]
                                                      .perSeatingPrice
                                                      .toString();
                                              perPersonPriceController.text =
                                                  widget.seatingArrangements!
                                                      .arrangements![index]
                                                      .perPersonPrice
                                                      .toString();
                                              totalAmountController.text =
                                                  widget.seatingArrangements!
                                                      .arrangements![index]
                                                      .totalAmount.toString();
                                              descriptionController.text =
                                                  widget.seatingArrangements!
                                                      .arrangements![index]
                                                      .description.toString();
                                              if (widget.seatingArrangements!
                                                  .arrangements![index]
                                                  .description == "Front") {
                                                setState(() {
                                                  isSeleted == 0;
                                                });
                                              } else
                                              if (widget.seatingArrangements!
                                                  .arrangements![index]
                                                  .description == "Middle") {
                                                setState(() {
                                                  isSeleted == 1;
                                                });
                                              } else {
                                                setState(() {
                                                  isSeleted == 2;
                                                });
                                              }
                                              addDetailsDialog(
                                                  widget.isEdit, index,false);
                                            },
                                            child: SvgPicture.asset(
                                                "assets/svg/ic_edit.svg",
                                                height: 18,
                                                width: 18,
                                                color: AppColors
                                                    .greyColor),
                                          ),
                                          const SizedBox(width: 10),
                                          widget.seatingArrangements!
                                              .arrangements![index]
                                              .isExpand
                                              ? SvgPicture.asset(
                                              "assets/svg/ic_top_arrow.svg",
                                              height: 10,
                                              width: 10,
                                              color: AppColors
                                                  .greyColor)
                                              : SvgPicture.asset(
                                              "assets/svg/ic_down_arrow.svg",
                                              height: 10,
                                              width: 10,
                                              color: AppColors
                                                  .greyColor),
                                        ],
                                      ),
                                      childrenPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      title: SmallText(
                                          text: widget.title!,
                                          size: 16,
                                          color: Colors.black),
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmallText(
                                                        text:
                                                        "${'no_of'.tr} ${widget
                                                            .title!}",
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text: widget
                                                            .seatingArrangements!
                                                            .arrangements![
                                                        index]
                                                            .numberOfSeatingItem
                                                            .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    widget.title! ==
                                                        "Stand" ||
                                                        widget.title! ==
                                                            "Chair"
                                                        ? Container()
                                                        : Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SmallText(
                                                            text:
                                                            "${'per'
                                                                .tr} ${widget
                                                                .title} ${'price'
                                                                .tr}",
                                                            size:
                                                            12,
                                                            color: AppColors
                                                                .greyColor),
                                                        const SizedBox(
                                                            height:
                                                            3),
                                                        SmallText(
                                                            text: widget
                                                                .seatingArrangements!
                                                                .arrangements![
                                                            index]
                                                                .perSeatingPrice
                                                                .toString(),
                                                            size:
                                                            14,
                                                            color: Colors
                                                                .black),
                                                        const SizedBox(
                                                            height:
                                                            20),
                                                      ],
                                                    ),
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
                                                        text: widget
                                                            .seatingArrangements!
                                                            .arrangements![
                                                        index]
                                                            .totalPerson
                                                            .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    SmallText(
                                                        text:
                                                        'total_amount'
                                                            .tr,
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text: widget
                                                            .seatingArrangements!
                                                            .arrangements![
                                                        index]
                                                            .totalAmount
                                                            .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                  ],
                                                )),
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SmallText(
                                                        text:
                                                        "${widget
                                                            .title!} ${'location'
                                                            .tr}",
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text:
                                                        "${widget
                                                            .seatingArrangements!
                                                            .arrangements![index]
                                                            .verticalLocation} - ${widget
                                                            .seatingArrangements!
                                                            .arrangements![index]
                                                            .horizontalLocation}",
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    widget.title! ==
                                                        "Stand" ||
                                                        widget.title! ==
                                                            "Chair"
                                                        ? Container()
                                                        : Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SmallText(
                                                            text:
                                                            "${'per'
                                                                .tr} ${widget
                                                                .title} ${'price'
                                                                .tr}",
                                                            size:
                                                            12,
                                                            color: AppColors
                                                                .greyColor),
                                                        const SizedBox(
                                                            height:
                                                            3),
                                                        SmallText(
                                                            text: widget
                                                                .seatingArrangements!
                                                                .arrangements![
                                                            index]
                                                                .perSeatingPrice
                                                                .toString(),
                                                            size:
                                                            14,
                                                            color: Colors
                                                                .black),
                                                        const SizedBox(
                                                            height:
                                                            20),
                                                      ],
                                                    ),
                                                    SmallText(
                                                        text:
                                                        'per_person_price'
                                                            .tr,
                                                        size: 12,
                                                        color: AppColors
                                                            .greyColor),
                                                    const SizedBox(
                                                        height: 3),
                                                    SmallText(
                                                        text: widget
                                                            .seatingArrangements!
                                                            .arrangements![
                                                        index]
                                                            .perPersonPrice
                                                            .toString(),
                                                        size: 14,
                                                        color:
                                                        Colors.black),
                                                    const SizedBox(
                                                        height: 20),
                                                    widget.title! ==
                                                        "Stand" ||
                                                        widget.title! ==
                                                            "Chair"
                                                        ? Container()
                                                        : Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SmallText(
                                                            text: 'booking_accepting'
                                                                .tr,
                                                            size:
                                                            12,
                                                            color: AppColors
                                                                .greyColor),
                                                        const SizedBox(
                                                            height:
                                                            3),
                                                        SmallText(
                                                            text: widget
                                                                .seatingArrangements!
                                                                .arrangements![index]
                                                                .bookingAcceptance ==
                                                                true
                                                                ? "Per Person"
                                                                : "${'per'
                                                                .tr} ${widget
                                                                .title!}",
                                                            size:
                                                            14,
                                                            color: Colors
                                                                .black),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                            height: widget.seatingArrangements!
                                                .arrangements![index]
                                                .description!.isEmpty ? 0 : 20),
                                        widget.seatingArrangements!
                                            .arrangements![index].description!
                                            .isEmpty ?
                                        Container() : Align(
                                          alignment:
                                          Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            children: [
                                              SmallText(
                                                  text: 'description'
                                                      .tr,
                                                  size: 12,
                                                  color: AppColors
                                                      .greyColor),
                                              const SizedBox(
                                                  height: 3),
                                              Text(
                                                widget
                                                    .seatingArrangements!
                                                    .arrangements![
                                                index]
                                                    .description
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                    Colors.black,
                                                    fontFamily:
                                                    'Helvetica',
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: 'select_food'.tr,
                                  size: 14,
                                  color: AppColors.greyColor),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 0;
                                          foodText = "VEG";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_veg.svg",
                                          txtName: 'veg'.tr,
                                          isSelect: foodSeleted == 0),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 1;
                                          foodText = "NONVEG";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_non_veg.svg",
                                          txtName: 'non_veg'.tr,
                                          isSelect: foodSeleted == 1),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 2;
                                          foodText = "BOTH";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_both.svg",
                                          txtName: 'both'.tr,
                                          isSelect: foodSeleted == 2),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          foodSeleted = 3;
                                          foodText = "NONE";
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_non.svg",
                                          txtName: 'none'.tr,
                                          isSelect: foodSeleted == 3),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              EditTextWidget(
                                  line: 3,
                                  isCompulsoryText: false,
                                  text: 'food_dexcription'.tr,
                                  textEditingController:
                                  foodDescriptionController,
                                  textInputAction:
                                  TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'enter_food_description'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                              const SizedBox(height: 20),
                              SmallText(
                                  text: 'select_Equipment'.tr,
                                  size: 14,
                                  color: AppColors.greyColor),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          equipmentSeleted = 0;
                                          equipmentText = true;
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_equipment.svg",
                                          txtName: 'equipment'.tr,
                                          isSelect:
                                          equipmentSeleted == 0),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          equipmentSeleted = 1;
                                          equipmentText = false;
                                        });
                                      },
                                      child: SelectFood(
                                          img:
                                          "assets/svg/ic_non.svg",
                                          txtName: 'none'.tr,
                                          isSelect:
                                          equipmentSeleted == 1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              EditTextWidget(
                                  line: 3,
                                  isCompulsoryText: false,
                                  text: 'equipment_description'.tr,
                                  textEditingController:
                                  equipmentDescriptionController,
                                  textInputAction:
                                  TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'enter_equipment_description'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ])
                        : Container())
              ],
            );
          },
        ));
  }

  addDetailsDialog(isEdit, index,isEditAdd) async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: AppColors.edtBgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  Form(
                    key: addTableKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                                text: (totalPersonController.text.isNotEmpty?"Edit":"Add").tr + " ${widget.title!}",
                                size: 18,
                                color: Colors.black),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset("assets/svg/ic_close.svg",
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        widget.title == "Chair" || widget.title == "Stand"
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditTextWidget(
                                isCompulsoryText: false,
                                line: 1,
                                text: "${'no_of'.tr} ${widget.title}",
                                textEditingController: noTableController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${'enter'.tr}${'no_of'.tr} ${widget
                                        .title}';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      totalPersonController.text =
                                          noTableController.text;
                                      if(isEdit) totalAmountController.text =(int.parse(noTableController.text)*double.parse(perTablePriceController.text)).toString();
                                    });
                                  }
                                },
                                bgColor: Colors.white),
                            const SizedBox(height: 20),
                            SmallText(
                                text: 'vettical_location'.tr,
                                size: 14,
                                color: AppColors.greyColor),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topLeft:
                                              Radius.circular(5),
                                              bottomLeft:
                                              Radius.circular(5)),
                                          color: isSeleted == 0
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'front'.tr,
                                              size: 16,
                                              color: isSeleted == 0
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isSeleted = 0;
                                        isVerticalText = "FRONT";
                                        vertical = "front";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          color: isSeleted == 1
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'middle'.tr,
                                              size: 16,
                                              color: isSeleted == 1
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isSeleted = 1;
                                        isVerticalText = "CENTER";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.circular(5),
                                              bottomRight:
                                              Radius.circular(5)),
                                          color: isSeleted == 2
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'back'.tr,
                                              size: 16,
                                              color: isSeleted == 2
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isSeleted = 2;
                                        isVerticalText = "BACK";
                                        vertical = "back";
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SmallText(
                                text: 'horizontal_location'.tr,
                                size: 14,
                                color: AppColors.greyColor),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topLeft:
                                              Radius.circular(5),
                                              bottomLeft:
                                              Radius.circular(5)),
                                          color: isHorizontalSeleted == 0
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'none'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 0
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 0;
                                        isHorizontalText = "NONE";
                                        horizontal = "none";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          color: isHorizontalSeleted == 1
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'left'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 1
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 1;
                                        isHorizontalText = "LEFT";
                                        horizontal = "left";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          color: isHorizontalSeleted == 2
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'center'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 2
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 2;
                                        isHorizontalText = "CENTER";
                                        horizontal = "center";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.circular(5),
                                              bottomRight:
                                              Radius.circular(5)),
                                          color: isHorizontalSeleted == 3
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'right'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 3
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 3;
                                        isHorizontalText = "RIGHT";
                                        horizontal = "right";
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            AbsorbPointer(
                              absorbing: true,
                              child: EditTextWidget(
                                  line: 1,
                                  isCompulsoryText: false,
                                  text: 'total_person_capacity'.tr,
                                  textEditingController:
                                  totalPersonController,
                                  enable: false,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${'enter'
                                          .tr}${'total_person_capacity'.tr}';
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            EditTextWidget(
                                line: 1,
                                isCompulsoryText: false,
                                text: 'per_person_price'.tr,
                                textEditingController:
                                perPersonPriceController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${'enter'.tr}${'per_person_price'
                                        .tr}';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      totalAmountController
                                          .text = (int.parse(
                                          perPersonPriceController
                                              .text) *
                                          int.parse(
                                              totalPersonController
                                                  .text))
                                          .toString();
                                    });
                                  }
                                },
                                bgColor: Colors.white),
                            const SizedBox(height: 20),
                            AbsorbPointer(
                                absorbing: true,
                                child: EditTextWidget(
                                    line: 1,
                                    isCompulsoryText: false,
                                    text: 'total_amount'.tr,
                                    textEditingController:
                                    totalAmountController,
                                    enable: false,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '${'enter'.tr}${'total_amount'
                                            .tr}';
                                      }
                                      return null;
                                    },
                                    bgColor: Colors.white)),
                            const SizedBox(height: 20),
                            EditTextWidget(
                                line: 3,
                                isCompulsoryText: false,
                                text: 'description'.tr,
                                textEditingController:
                                descriptionController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return 'enter_description'.tr;
                                  // }
                                  return null;
                                },
                                bgColor: Colors.white),
                            const SizedBox(height: 20),
                            ButtonWidget(
                                callback: () {
                                  if (addTableKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      if (isEdit) {
                                        if(isEditAdd)
                                          widget.seatingArrangements!
                                              .arrangements!.add(
                                              Arrangements(
                                                  numberOfSeatingItem: int.parse(
                                                      noTableController.text),
                                                  verticalLocation:
                                                  isVerticalText,
                                                  horizontalLocation:
                                                  isHorizontalText,
                                                  totalPerson:
                                                  int.parse(
                                                      totalPersonController
                                                          .text),
                                                  perPersonPrice: double.parse(
                                                      perPersonPriceController
                                                          .text),
                                                  totalAmount: double.parse(
                                                      totalAmountController
                                                          .text),
                                                  description:
                                                  descriptionController.text,
                                                  icon: "global/icons/${vertical}_$horizontal.svg",
                                                  totalBooked: 0,
                                                  totalAvailableSeats: 0,
                                                  totalSeats: 0));
                                          else
                                        widget.seatingArrangements!
                                            .arrangements![index] =
                                            Arrangements(
                                                numberOfSeatingItem: int.parse(
                                                    noTableController.text),
                                                verticalLocation:
                                                isVerticalText,
                                                horizontalLocation:
                                                isHorizontalText,
                                                totalPerson:
                                                int.parse(
                                                    totalPersonController
                                                        .text),
                                                perPersonPrice: double.parse(
                                                    perPersonPriceController
                                                        .text),
                                                totalAmount: double.parse(
                                                    totalAmountController
                                                        .text),
                                                description:
                                                descriptionController.text,
                                                icon: "global/icons/${vertical}_$horizontal.svg",
                                                totalBooked: 0,
                                                totalAvailableSeats: 0,
                                                totalSeats: 0);
                                      }
                                      else {
                                        arragmentItemController
                                            .arrangements_Items!
                                            .add(Arrangements(
                                            numberOfSeatingItem: int.parse(
                                                noTableController.text),
                                            verticalLocation:
                                            isVerticalText,
                                            horizontalLocation:
                                            isHorizontalText,
                                            totalPerson:
                                            int.parse(
                                                totalPersonController
                                                    .text),
                                            perPersonPrice: double.parse(
                                                perPersonPriceController
                                                    .text),
                                            totalAmount: double.parse(
                                                totalAmountController
                                                    .text),
                                            description:
                                            descriptionController.text,
                                            icon: "global/icons/${vertical}_$horizontal.svg",
                                            totalBooked: 0,
                                            totalAvailableSeats: 0,
                                            totalSeats: 0));
                                        print(arragmentItemController
                                            .arrangements_Items!);
                                      }
                                    });
                                    Navigator.pop(context);
                                    setState(() {
                                      setState(() {});
                                    });
                                  }
                                },
                                bgColor: AppColors.redColor,
                                text: 'submit'.tr)
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditTextWidget(
                                isCompulsoryText: false,
                                line: 1,
                                text: "${'no_of'.tr} ${widget.title}",
                                textEditingController: noTableController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter_no_of_table'.tr;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      totalPersonController.text =
                                          (int.parse(noTableController.text) *
                                              int.parse(
                                                  perTablePersoneController
                                                      .text))
                                              .toString();
                                        totalAmountController.text =(int.parse(noTableController.text)*double.parse(perTablePriceController.text)).toString();

                                    });
                                  }
                                },
                                bgColor: Colors.white),
                            const SizedBox(height: 20),
                            SmallText(
                                text: 'vettical_location'.tr,
                                size: 14,
                                color: AppColors.greyColor),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topLeft:
                                              Radius.circular(5),
                                              bottomLeft:
                                              Radius.circular(5)),
                                          color: isSeleted == 0
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'Front'.tr,
                                              size: 16,
                                              color: isSeleted == 0
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isSeleted = 0;
                                        isVerticalText = "Front";
                                        vertical = "front";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          color: isSeleted == 1
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'Middle'.tr,
                                              size: 16,
                                              color: isSeleted == 1
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isSeleted = 1;
                                        isVerticalText = "MIDDLE";
                                        vertical = "middle";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.circular(5),
                                              bottomRight:
                                              Radius.circular(5)),
                                          color: isSeleted == 2
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'Back'.tr,
                                              size: 16,
                                              color: isSeleted == 2
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isSeleted = 2;
                                        isVerticalText = "BACK";
                                        vertical = "back";
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SmallText(
                                text: 'horizontal_location'.tr,
                                size: 14,
                                color: AppColors.greyColor),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topLeft:
                                              Radius.circular(5),
                                              bottomLeft:
                                              Radius.circular(5)),
                                          color: isHorizontalSeleted == 0
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'none'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 0
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 0;
                                        isHorizontalText = "NONE";
                                        horizontal = "none";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          color: isHorizontalSeleted == 1
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'left'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 1
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 1;
                                        isHorizontalText = "LEFT";
                                        horizontal = "left";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          color: isHorizontalSeleted == 2
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'center'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 2
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 2;
                                        isHorizontalText = "CENTER";
                                        horizontal = "center";
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.circular(5),
                                              bottomRight:
                                              Radius.circular(5)),
                                          color: isHorizontalSeleted == 3
                                              ? AppColors.redColor
                                              : Colors.white),
                                      child: Center(
                                          child: SmallText(
                                              text: 'right'.tr,
                                              size: 16,
                                              color:
                                              isHorizontalSeleted == 3
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isHorizontalSeleted = 3;
                                        isHorizontalText = "RIGHT";
                                        horizontal = "right";
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            EditTextWidget(
                                line: 1,
                                isCompulsoryText: false,
                                text:
                                "${'per'.tr} ${widget.title} ${'person_capacity'
                                    .tr}",
                                textEditingController:
                                perTablePersoneController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter_per_table_capacity'.tr;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      totalPersonController
                                          .text = (int.parse(
                                          noTableController
                                              .text) *
                                          int.parse(
                                              perTablePersoneController
                                                  .text))
                                          .toString();
                                    });
                                  }
                                },
                                bgColor: Colors.white),
                            const SizedBox(height: 20),
                            AbsorbPointer(
                              absorbing: true,
                              child: EditTextWidget(
                                  line: 1,
                                  isCompulsoryText: false,
                                  text: 'total_person_capacity'.tr,
                                  textEditingController:
                                  totalPersonController,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter_total_person_capacity'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            EditTextWidget(
                                line: 1,
                                isCompulsoryText: false,
                                text:
                                "${'per'.tr} ${widget.title} ${'price'.tr}",
                                textEditingController:
                                perTablePriceController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter_per_table_price'.tr;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      totalAmountController
                                          .text = (int.parse(
                                          noTableController
                                              .text) *
                                          int.parse(
                                              perTablePriceController
                                                  .text))
                                          .toString();
                                      perPersonPriceController
                                          .text = (double.parse(
                                          perTablePriceController
                                              .text) /
                                          double.parse(
                                              perTablePersoneController
                                                  .text))
                                          .toStringAsFixed(2)
                                          .toString();
                                    });
                                  }
                                },
                                bgColor: Colors.white),
                            const SizedBox(height: 20),
                            AbsorbPointer(
                              absorbing: true,
                              child: EditTextWidget(
                                  line: 1,
                                  isCompulsoryText: false,
                                  text: 'per_person_price'.tr,
                                  textEditingController:
                                  perPersonPriceController,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter_per_person_price'.tr;
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            AbsorbPointer(
                              absorbing: true,
                              child: EditTextWidget(
                                  line: 1,
                                  isCompulsoryText: false,
                                  text: 'total_amount'.tr,
                                  textEditingController:
                                  totalAmountController,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter_total_amount'.tr;
                                    }
                                    return null;
                                  },
                                  bgColor: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            EditTextWidget(
                                line: 3,
                                isCompulsoryText: false,
                                text: 'description'.tr,
                                textEditingController:
                                descriptionController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return 'enter_description'.tr;
                                  // }
                                  return null;
                                },
                                bgColor: Colors.white),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmallText(
                                    text: "${'per'.tr} ${widget.title}",
                                    size: 14,
                                    color: isSwitched
                                        ? Colors.black
                                        : AppColors.greenColor),
                                const SizedBox(width: 10),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    if (isSwitched == false) {
                                      setState(() {
                                        isSwitched = true;
                                      });
                                    } else {
                                      setState(() {
                                        isSwitched = false;
                                      });
                                    }
                                  },
                                  inactiveThumbColor:
                                  AppColors.greenColor,
                                  inactiveTrackColor: AppColors.greenColor
                                      .withOpacity(0.5),
                                  activeColor: AppColors.greenColor,
                                  activeTrackColor: AppColors.greenColor
                                      .withOpacity(0.5),
                                ),
                                const SizedBox(width: 10),
                                SmallText(
                                    text: 'per_person'.tr,
                                    size: 14,
                                    color: isSwitched
                                        ? AppColors.greenColor
                                        : Colors.black),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ButtonWidget(
                                callback: () {
                                  if (addTableKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      if (isEdit) {
                                        if(isEditAdd)
                                          widget.seatingArrangements!
                                              .arrangements!.add(Arrangements(
                                                  numberOfSeatingItem: int.parse(
                                                      noTableController.text),
                                                  verticalLocation:
                                                  isVerticalText,
                                                  horizontalLocation:
                                                  isHorizontalText,
                                                  perSeatingPerson: int.parse(
                                                      perTablePersoneController
                                                          .text),
                                                  totalPerson: int.parse(
                                                      totalPersonController.text),
                                                  perSeatingPrice: double.parse(
                                                      perTablePriceController
                                                          .text),
                                                  perPersonPrice:
                                                  double.parse(
                                                      perPersonPriceController
                                                          .text)
                                                  ,
                                                  totalAmount: double.parse(
                                                      totalAmountController.text),
                                                  description: descriptionController
                                                      .text,
                                                  bookingAcceptance: isSwitched,
                                                  icon: "global/icons/${vertical}_$horizontal.svg",
                                                  totalBooked: 0,
                                                  totalAvailableSeats: 0,
                                                  totalSeats: 0));
                                          else
                                        widget.seatingArrangements!
                                            .arrangements![index] =Arrangements(
                                                numberOfSeatingItem: int.parse(
                                                    noTableController.text),
                                                verticalLocation:
                                                isVerticalText,
                                                horizontalLocation:
                                                isHorizontalText,
                                                perSeatingPerson: int.parse(
                                                    perTablePersoneController
                                                        .text),
                                                totalPerson: int.parse(
                                                    totalPersonController.text),
                                                perSeatingPrice: double.parse(
                                                    perTablePriceController
                                                        .text),
                                                perPersonPrice:
                                                double.parse(
                                                    perPersonPriceController
                                                        .text)
                                                ,
                                                totalAmount: double.parse(
                                                    totalAmountController.text),
                                                description: descriptionController
                                                    .text,
                                                bookingAcceptance: isSwitched,
                                                icon: "global/icons/${vertical}_$horizontal.svg",
                                                totalBooked: 0,
                                                totalAvailableSeats: 0,
                                                totalSeats: 0);
                                        setState(() {},);
                                      }
                                      else {
                                        arragmentItemController
                                            .arrangements_Items!.add(
                                            Arrangements(
                                                numberOfSeatingItem: int.parse(
                                                    noTableController.text),
                                                verticalLocation:
                                                isVerticalText,
                                                horizontalLocation:
                                                isHorizontalText,
                                                perSeatingPerson: int.parse(
                                                    perTablePersoneController
                                                        .text),
                                                totalPerson: int.parse(
                                                    totalPersonController.text),
                                                perSeatingPrice: double.parse(
                                                    perTablePriceController
                                                        .text),
                                                perPersonPrice:
                                                double.parse(
                                                    perPersonPriceController
                                                        .text)
                                                ,
                                                totalAmount: double.parse(
                                                    totalAmountController.text),
                                                description: descriptionController
                                                    .text,
                                                bookingAcceptance: isSwitched,
                                                icon: "global/icons/${vertical}_$horizontal.svg",
                                                totalBooked: 0,
                                                totalAvailableSeats: 0,
                                                totalSeats: 0));
                                      }
                                    });
                                    Navigator.pop(context);
                                    setState(() {
                                      setState(() {});
                                    });
                                  }
                                },
                                bgColor: AppColors.redColor,
                                text: 'submit'.tr)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        }).then((value) =>
        setState(() {
          noTableController.clear();
          perTablePersoneController.clear();
          totalPersonController.clear();
          perTablePriceController.clear();
          perPersonPriceController.clear();
          totalAmountController.clear();
          descriptionController.clear();
          isSeleted = 0;
          isHorizontalSeleted = 0;
          isVerticalText;
          isHorizontalText;
        }));
  }

  number_of_seating_item() {
    for (int i = 0;
    i < arragmentItemController.arrangements_Items!.length;
    i++) {
      arragmentItemController.total_number_of_seating_items +=
      arragmentItemController.arrangements_Items![i].numberOfSeatingItem!;
      arragmentItemController.total_per_seating_persons +=
      arragmentItemController.arrangements_Items![i].perSeatingPerson ==
          null
          ? 0
          : arragmentItemController.arrangements_Items![i].perSeatingPerson!
          .toInt();
      arragmentItemController.total_persons +=
      arragmentItemController.arrangements_Items![i].totalPerson!;
      arragmentItemController.per_seating_price +=
      arragmentItemController.arrangements_Items![i].perSeatingPrice == null
          ? 0.0
          : arragmentItemController.arrangements_Items![i].perSeatingPrice!;
      arragmentItemController.per_person_price +=
      arragmentItemController.arrangements_Items![i].perPersonPrice!;
      arragmentItemController.total_amount +=
      arragmentItemController.arrangements_Items![i].totalAmount!;
    }
  }
}
