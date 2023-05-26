import 'package:festum_evento/model/event_times/EventTimeModel.dart';
import 'package:festum_evento/repository/event_time_repository/event_time_repository.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EventTimeController extends GetxController {
  final _apiService = EventTimeRepository();

  var ids;

  String? startDates, endDates;
  TimeOfDay? start;
  TimeOfDay? end;
  var startTime, endTimes;
  DateTime? date_Start;
  DateTime? date_End;
  var rangeStart, rangeEnd;
  bool isStatus = false;
  PickerDateRange? pickerDateRanges;

  final selectDateController = TextEditingController().obs;
  final dateStartController = TextEditingController().obs;
  final dateEndController = TextEditingController().obs;

  final startSelectDateController = DateRangePickerController().obs;
  final startTimeController = TextEditingController().obs;
  final endTimeController = TextEditingController().obs;
  final aboutEventController = TextEditingController().obs;

  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();



  RxBool loading = false.obs;

  var eventIds;

  About? eventlist;

  void eventTimeApi(context) {
    Utils.onLoading(context);
    times();
    var sdate=startDates =DateFormat('yyyy-MM-dd').format(date_Start!);
    var eDate =DateFormat('yyyy-MM-dd').format(date_End!);
    eventIds = Get.arguments;

    Map data = {
      'eventid': ids == null
          ? eventIds != null
              ? eventIds
              : ids
          : ids,
      'start_date': sdate,
      'end_date': eDate,
      'start_time': startTime,
      'end_time': endTimes,
      'about_event': aboutEventController.value.text
    };

    _apiService.eventTimeRepo(data).then((value) {
      if (value == null) {
        Utils.toastMessage("Data Not Add!!");
      } else {
        String ids = value.data.sId;
        if (ids != null) {
          Get.toNamed(RouteName.eventSittingListScreen, arguments: ids);
        }
      }
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  void getEventTimeApi() {
    loading.value = true;
    _apiService.getEventTimeRepo().then((value) {
      if (value == null) {
        Utils.toastMessage("Data Not Add!!");
        loading.value = false;
        update();
      } else {
        eventlist = value.data!.about!;
        var dateStart =  value.data!.about!.startDate;
        var dateEnd = value.data!.about!.endDate;
        var timeStart = value.data!.about!.startTime;
        var timeEnd = value.data!.about!.endTime;
        var aboutText = value.data!.about!.aboutEvent;

        //Converted DateTime
        var startDate = Utils.dayMonthDateConvert(dateStart!);
        var endDate = Utils.dayMonthDateConvert(dateEnd!);

        //start
        date_Start = DateTime.parse(dateStart.toString());
        var startFormat = DateFormat('yyyyMMdd');
        var otStart = startFormat.format(date_Start!);

        //end
        date_End = DateTime.parse(dateEnd.toString());
        var endFormat = DateFormat('yyyyMMdd');
        var otEnd = endFormat.format(date_End!);

        pickerDateRanges =
            PickerDateRange(DateTime.parse(otStart), DateTime.parse(otEnd));
        print(pickerDateRanges);

        var startTime = Utils.String24FormatTimeOfDay(timeStart!);
        var endTime = Utils.String24FormatTimeOfDay(timeEnd!);
        start=Utils.stringToTimeOfDay(timeStart);
        end=Utils.stringToTimeOfDay(timeEnd);
        selectDateController.value.text = startDate + " - " + endDate;

        startTimeController.value.text = startTime;
        endTimeController.value.text = endTime;
        aboutEventController.value.text = aboutText!;
        update();
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      update();
    });
  }

  void times() {
    // StartTime

    startTime = Utils.formatTimeOfDay24Hr(start!);
    endTimes = Utils.formatTimeOfDay24Hr(end!);


  }

  void dates() {
    // StartDate

    startDates =DateFormat('yyyy-MM-dd').format(date_Start!);
    endDates =DateFormat('yyyy-MM-dd').format(date_End!);
    //EndDate

  }
}