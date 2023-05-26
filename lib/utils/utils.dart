import 'package:cached_network_image/cached_network_image.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../model/arrangement_item_model/location_model.dart';
import '../view_models/controller/LoadingController.dart';
import '../widget/cust_place_picker.dart';

class Utils {

  BuildContext? context;
  var loadingCtrl = Get.find<LoadingController>();
  void showLoading() => loadingCtrl.showLoading();
  static LocationResult? locationResult;
  void hideLoading() => loadingCtrl.hideLoading();
  static const String mapKey = "AIzaSyDLgr8YB5IK8dBIEWClexZGzXaB7UlVm7Q";
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isNumericCheck(string) {
    if (string == null || string == 'null' || string.isEmpty) {
      return false;
    }
    final number = num.tryParse(string);
    if (number == null) {
      return false;
    }
    return true;
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER);
  }

  static snackBar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }
  static void onLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.redColor),
                ),
              ),
            ),
          );
        });
  }

  //24 String to 12 hr string
  static String String24FormatTimeOfDay(String tod) {
    var temp = tod.split(':');
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day,
        int.parse(temp[0]), int.parse(temp[1]));
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  //24 hr to string
  static String formatTimeOfDay24Hr(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm(); //"24:00"
    return format.format(dt);
  }

  //15-03-2023 to 15 Mar,2023
  static String formatSelectedDate(String str){
    DateTime d1 = DateFormat('dd-MM-yyyy').parse(str);
    var starDate = DateTime.parse(d1.toString());
    var outputFormat = DateFormat('dd MMM,yyyy');
    var outputDate = outputFormat.format(starDate);
    return outputDate;
  }

  static DateFormat convertDateFormat = DateFormat("dd MMM yyyy");
  static dayMonthDateConvert(String value) {
    return convertDateFormat.format(DateTime.parse(value));
  }

  static String formatSelectDate(String str){
    DateTime d1 = DateFormat('dd MMM,yyyy').parse(str);
    var starDate = DateTime.parse(d1.toString());
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(starDate);
    return outputDate;
  }

  //format Time
  static String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  //string to 24 hr
  static TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.Hm(); //"24:00"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  successMessage(message) {
    return Get.rawSnackbar(
        title: "Success",
        message: message,
        backgroundColor: Colors.green.shade400,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.check),
        shouldIconPulse: true,
        instantInit: true);
  }

  topSnack(message, IconData icon, Color color) {
    return Get.rawSnackbar(
        message: message,
        backgroundColor: color,
        snackPosition: SnackPosition.TOP,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        instantInit: true);
  }

  bottomSnack(message, Color color) {
    return Get.rawSnackbar(
        message: message,
        backgroundColor: color,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        instantInit: true);
  }

  errorMessage(message) {
    return Get.rawSnackbar(
        title: "Error",
        message: message,
        backgroundColor: Colors.red.shade400,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.error,color: Colors.white70),
        shouldIconPulse: true,
        instantInit: true);
  }

  alertMessage(message) {
    return Get.snackbar('Alert', message,
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
        borderRadius: 2,
        margin: const EdgeInsets.all(0));
  }

  static String findResult(List<AddressComponent> results, key) {
    for (int i = 0; i < results.length; i++) {
      for (int j = 0; j < results[i].types!.length; j++) {
        if (results[i].types![j] == key) {
          return results[i]!.longName!;
        }
      }
    }
    return "";
  }


  //WIDGETS HELPER
  Widget imageNetwork({
    required String url,
    double? height,
    double? width,
    BoxFit? fit,
    Widget? placeholder,
    String? errorImageAsset,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
      placeholder ??
          Center(
            child:
            Lottie.asset('assets/png/imageLoader.json',height: 130),
          ),
      errorWidget: (context, url, error) => Image.asset(
        errorImageAsset ?? "assets/svg/ic_add_image.svg",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
  //number
}
