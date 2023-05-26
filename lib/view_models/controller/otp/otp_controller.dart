import 'package:festum_evento/repository/otp_repository/otp_repository.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class OtpController extends GetxController{

  final _api = OtpRepository();

  final otpController = TextEditingController().obs;

  var getKeys = Get.arguments;

  void otpApis(){
    Utils().showLoading();
    //print("Key===="+Get.arguments);
    getKeys = Get.arguments;
    Map data = {
      'mobile' : getKeys[0],
      'key' : getKeys[1],
      'otp' : otpController.value.text,
    };

    _api.otpApi(data).then((value){
      if(value.status == 200){
        if(getKeys[2] == "isLogin") {
          Get.offNamed(RouteName.deshboardScreen);
        }else{
          Get.offNamed(RouteName.newPasswordScreen,arguments: getKeys[0]);
        }
      }else{
        Utils().errorMessage(value.message);
      }
      Utils().hideLoading();
    }).onError((error, stackTrace){
      print(error.toString());
      Utils().hideLoading();
      Utils().errorMessage("Something went wrong");
    });
  }
}