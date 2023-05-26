import 'package:festum_evento/screen/SideMenu/Screen/event_invoice_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyOfferModel {
  String imgUri, mainText, dateText, priceText, lableText;

  MyOfferModel(
      {required this.imgUri,
      required this.mainText,
      required this.dateText,
      required this.priceText,
      required this.lableText});
}

class MyOfferFragment extends StatefulWidget {
  const MyOfferFragment({Key? key}) : super(key: key);

  @override
  State<MyOfferFragment> createState() => _MyOfferFragmentState();
}

class _MyOfferFragmentState extends State<MyOfferFragment> {
  TextEditingController dateController = TextEditingController();

  final idKeys = GlobalKey<FormState>();
  DateTime? startDate;
  DateTime? enddate;
  String? selectDate;

  String? start;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  final List<MyOfferModel> _listOffer = <MyOfferModel>[
    MyOfferModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainText: "Cooking Together",
        dateText: "July 23, 2021 - 10:00AM",
        priceText: "\$2563.00",
        lableText: "Music"),
    MyOfferModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainText: "Cooking Together",
        dateText: "July 23, 2021 - 10:00AM",
        priceText: "\$2563.00",
        lableText: "Music"),
    MyOfferModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainText: "Cooking Together",
        dateText: "July 23, 2021 - 10:00AM",
        priceText: "\$2563.00",
        lableText: "Music"),
    MyOfferModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainText: "Cooking Together",
        dateText: "July 23, 2021 - 10:00AM",
        priceText: "\$2563.00",
        lableText: "Music"),
    MyOfferModel(
        imgUri: "assets/svg/ic_booth.svg",
        mainText: "Cooking Together",
        dateText: "July 23, 2021 - 10:00AM",
        priceText: "\$2563.00",
        lableText: "Music"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      body: ListView(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.redColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset("assets/svg/ic_calender_icon.svg",
                      height: 21, width: 21),
                ),
                Expanded(
                  flex: 9,
                  child: Center(
                    child: TextFormField(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.white,
                                child: Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: SfDateRangePicker(
                                    view: DateRangePickerView.month,
                                    rangeSelectionColor:
                                        AppColors.dateColor.withOpacity(0.2),
                                    startRangeSelectionColor:
                                        AppColors.dateColor,
                                    endRangeSelectionColor: AppColors.dateColor,
                                    selectionTextStyle:
                                        const TextStyle(color: Colors.white),
                                    monthViewSettings:
                                        const DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: 6),
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    onSelectionChanged: (args) {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        startDate = args.value.startDate;
                                        enddate = args.value.endDate;
                                        if (startDate != null &&
                                            enddate != null) {
                                          String starDate =
                                              DateFormat('dd MMM,yyyy')
                                                  .format(startDate!);
                                          String end_Date =
                                              DateFormat('dd MMM,yyyy')
                                                  .format(enddate!);
                                          selectDate = "$starDate - $end_Date";
                                          dateController.text = selectDate!;
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackbarWidget(
                                                  'select_start_date_end'.tr));
                                        }
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                      readOnly: true,
                      controller: dateController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      maxLines: 1,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 50),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.redColor,
                        hintText: 'select_start_date_end'.tr,
                        hintStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: _listOffer.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.white,
                                child: SizedBox(
                                  height: 125,
                                  width: 125,
                                  child: SvgPicture.asset(
                                      _listOffer[index].imgUri,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: RatingBar.builder(
                                            itemSize: 10,
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
                                            onRatingUpdate: (double value) {
                                              print(value);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 18,
                                            color: AppColors.redColor,
                                            child: Center(
                                              child: SmallText(
                                                text: _listOffer[index].lableText,
                                                size: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    SmallText(
                                        text: _listOffer[index].mainText,
                                        size: 18,
                                        color: Colors.black),
                                    const SizedBox(height: 10),
                                    SmallText(
                                        text: _listOffer[index].dateText,
                                        size: 12,
                                        color: AppColors.txtgreyColor),
                                    const SizedBox(height: 15),
                                    SmallText(
                                        text: _listOffer[index].priceText,
                                        size: 16,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EventInvoiceScreen()));
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              height: 30,
                              width: double.infinity,
                              child: Center(
                                child: SmallText(
                                    text: 'view_invoice'.tr,
                                    size: 12,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
