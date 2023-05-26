import 'package:festum_evento/repository/forgot_repository/forgot_repository.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/view_models/user_preference/user_preference_view_model.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class ForgotPasswordController extends GetxController{

  final forgotApi = ForgotRepository();
  var keys;
  final phoneController = TextEditingController().obs;
  UserPreference userPreference = UserPreference();

  void forgot(){
    Utils().showLoading();
    Map data ={
      'mobile' : phoneController.value.text
    };

    forgotApi.forgotApi(data).then((value){
      if(value.status == 200){
        keys = value.data['key'];
        Get.toNamed(RouteName.otpScreen,arguments: [phoneController.value.text,value.data['key'],"isForgot"]);
      }else{
        Utils().errorMessage(value.message);
      }
      Utils().hideLoading();
    }).onError((error, stackTrace){
      Utils().hideLoading();
      Utils().errorMessage("Something went wrong");
    });
  }
}