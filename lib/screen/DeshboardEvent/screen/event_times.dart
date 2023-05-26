import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:festum_evento/view_models/controller/event_time/event_time_controller.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EventTimesScreen extends StatefulWidget {
  const EventTimesScreen({Key? key}) : super(key: key);

  @override
  State<EventTimesScreen> createState() => _EventTimesScreenState();
}

class _EventTimesScreenState extends State<EventTimesScreen> {
  final eventTimeController = Get.put(EventTimeController());

  final idKeys = GlobalKey<FormState>();
  //DateTime? startDate;
  //DateTime? enddate;
  //TimeOfDay? parsedEndTime, parsedStartTime;
  String? selectDate;
  var eventLists = Get.arguments;

  String? start;

  var hello;

  @override
  void initState() {
    super.initState();
    eventTimeController.ids = eventLists;
    eventTimeController.getEventTimeApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () {
            if (idKeys.currentState!.validate()) {


              // if (startDate!.isAtSameMomentAs(enddate!)) {
              //   double _doubleYourTime = parsedStartTime!.hour.toDouble() +
              //       (parsedStartTime!.minute.toDouble() / 60);
              //   double _doubleNowTime = parsedEndTime!.hour.toDouble() +
              //       (parsedEndTime!.minute.toDouble() / 60);
              //   if (_doubleYourTime < _doubleNowTime) {
              //
              //   }
              // }

              if (eventTimeController.date_Start!.isAtSameMomentAs(eventTimeController.date_End??eventTimeController.date_Start!)) {
                if (eventTimeController.end != "" && eventTimeController.start != "") {
                  double _doubleYourTime = eventTimeController.start!.hour.toDouble() +
                      (eventTimeController.start!.minute.toDouble() / 60);
                  double _doubleNowTime = eventTimeController.end!.hour.toDouble() +
                      (eventTimeController.end!.minute.toDouble() / 60);
                  if (_doubleYourTime < _doubleNowTime) {
                    eventTimeController.eventTimeApi(context);
                    Navigator.pop(context);
                  } else {
                    Utils.toastMessage("Select prorper Time");
                  }
                } else {
                  Utils.toastMessage("Select Start and End Time");
                  Navigator.pop(context);
                }
              } else {
                if (eventTimeController.end != "" && eventTimeController.start != "") {
                  eventTimeController.eventTimeApi(context);
                  Navigator.pop(context);
                } else {
                  Utils.toastMessage("Select Start and End Time");
                  Navigator.pop(context);
                }
              }

            }
          },
          firstTxt: 'back'.tr,
          secondTxt: 'next'.tr),
      backgroundColor: AppColors.edtBgColor,
      body: GetBuilder<EventTimeController>(
        builder: (eventTimeController) {
          return eventTimeController.loading.value
              ? const Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Form(
                  key: idKeys,
                  child: Column(
                    children: [
                      ToolbarWidget(
                          text: 'create_new_event'.tr,
                          tapCallback: () {
                            Navigator.pop(context);
                          }),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            SmallText(
                                text: 'can_know_date'.tr,
                                size: 14,
                                color: AppColors.txtgreyColor),
                            const SizedBox(height: 10),
                            TextFormField(
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'select_date'.tr;
                                }
                                return null;
                              },
                              controller: eventTimeController
                                  .selectDateController.value,
                              style: TextStyle(
                                  color: AppColors.appColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: 'select_date'.tr,
                                hintStyle: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  highlightColor: Colors.transparent,
                                  icon: SvgPicture.asset(
                                    "assets/svg/ic_calender_icon.svg",
                                    height: 18,
                                    width: 18,
                                    color: AppColors.greyColor,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: SfDateRangePicker(
                                enablePastDates: false,
                                controller: eventTimeController
                                    .startSelectDateController.value,
                                view: DateRangePickerView.month,
                                initialSelectedRange:
                                    eventTimeController.pickerDateRanges,
                                rangeSelectionColor:
                                    AppColors.dateColor.withOpacity(0.2),
                                startRangeSelectionColor: AppColors.dateColor,
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
                                    print(timeStamp);
                                    eventTimeController.date_Start = args.value.startDate;
                                    eventTimeController.date_End = args.value.endDate;
                                    if (eventTimeController.date_Start != null && eventTimeController.date_End != null) {
                                      String starDate =
                                          DateFormat('dd MMM,yyyy')
                                              .format(eventTimeController.date_Start!);
                                      String end_Date =
                                          DateFormat('dd MMM,yyyy')
                                              .format(eventTimeController.date_End!);
                                      selectDate = "$starDate - $end_Date";

                                      String s_Date = DateFormat('dd-MM-yyyy')
                                          .format(eventTimeController.date_Start!);
                                      String e_Date = DateFormat('dd-MM-yyyy')
                                          .format(eventTimeController.date_End!);
                                      setState(() {
                                        eventTimeController.startDates = s_Date;
                                        eventTimeController.endDates = e_Date;
                                        eventTimeController.selectDateController.value.text = selectDate!;
                                        eventTimeController.dateStartController.value.text = starDate;
                                        eventTimeController.dateEndController.value.text = end_Date;
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackbarWidget(
                                              'select_start_date_end'.tr));
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SmallText(
                                          text: 'start_time'.tr,
                                          size: 14,
                                          color: AppColors.txtgreyColor),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: eventTimeController
                                            .startTimeController.value,
                                        style: TextStyle(
                                            color: AppColors.appColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          hintText: "HH : MM",
                                          hintStyle: TextStyle(
                                              color: AppColors.greyColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(
                                            Icons.access_time_filled,
                                            color: AppColors.greyColor,
                                          ), //icon of text field
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay? pickedTime = await showTimePicker(
                                            cancelText: 'Cancel'.tr,
                                            confirmText: 'Select'.tr,
                                            initialTime: eventTimeController.start??TimeOfDay.now(),
                                            context: context,
                                              builder: (BuildContext context, Widget? child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                                  child: Theme(
                                                    child: child!,
                                                    data: Theme.of(context).copyWith(
                                                      // colorScheme: ColorScheme.light(
                                                      //   primary: _color.primaryDarkColor, // header background color
                                                      //   onPrimary: _color.whiteColor, // header text color
                                                      //   onSurface: _color.darkGreyColor,
                                                      //   // body text color
                                                      // ),
                                                      // textButtonTheme: TextButtonThemeData(
                                                      //   style: TextButton.styleFrom(
                                                      //     primary: _color.primaryDarkColor, // button text color
                                                      //   ),
                                                     // ),
                                                    ),
                                                  ),
                                                );
                                              }
                                          );
                                          if (pickedTime != null) {
                                            setState(() {
                                              //timeStart = DateFormat.jm().parse(pickedTime.format(context).toString());
                                              var str = Utils.formatTimeOfDay(pickedTime);
                                                eventTimeController.start = pickedTime;
                                                eventTimeController.startTimeController.value.text = str;
                                            });
                                          } else {
                                            print("Time is not selected");
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SmallText(
                                          text: 'end_time'.tr,
                                          size: 14,
                                          color: AppColors.txtgreyColor),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: eventTimeController
                                            .endTimeController.value,
                                        style: TextStyle(
                                            color: AppColors.appColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          hintText: "HH : MM",
                                          hintStyle: TextStyle(
                                              color: AppColors.greyColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(
                                            Icons.access_time_filled,
                                            color: AppColors.greyColor,
                                          ), //icon of text field
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: eventTimeController.end??TimeOfDay.now(),
                                                  cancelText: 'Cancel'.tr,
                                                  confirmText: 'Select'.tr,
                                            context: context,
                                                  builder: (BuildContext context, Widget? child) {
                                                    return MediaQuery(
                                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                                      child: Theme(
                                                        child: child!,
                                                        data: Theme.of(context).copyWith(
                                                          // colorScheme: ColorScheme.light(
                                                          //   primary: _color.primaryDarkColor, // header background color
                                                          //   onPrimary: _color.whiteColor, // header text color
                                                          //   onSurface: _color.darkGreyColor,
                                                          //   // body text color
                                                          // ),
                                                          // textButtonTheme: TextButtonThemeData(
                                                          //   style: TextButton.styleFrom(
                                                          //     primary: _color.primaryDarkColor, // button text color
                                                          //   ),
                                                          // ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                          );
                                          if (pickedTime != null) {
                                            setState(() {
                                              //timeEnd = DateFormat.jm().parse(pickedTime.format(context).toString());
                                              var str = Utils.formatTimeOfDay(
                                                  pickedTime);
                                                eventTimeController.end =
                                                    pickedTime;
                                                eventTimeController
                                                    .endTimeController
                                                    .value
                                                    .text = str;
                                            });
                                          } else {
                                            print("Time is not selected");
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            EditTextWidget(
                                line: 1,
                                isCompulsoryText: false,
                                text: 'event_description'.tr,
                                textEditingController: eventTimeController
                                    .aboutEventController.value,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter_description'.tr;
                                  }
                                  return null;
                                },
                                bgColor: Colors.white)
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
