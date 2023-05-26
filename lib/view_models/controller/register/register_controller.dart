import 'package:festum_evento/repository/register_repository/register_repository.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class RegisterController extends GetxController {
  final _api = RegisterRepository();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final referController = TextEditingController();
  String? dialCode;


  registerApi() async {
    Utils().showLoading();
    Map data = {
      'name' :nameController.text,
      'email' :emailController.text,
      'mobile' :mobileController.text,
      'country_code' :dialCode,
      'password' :passwordController.text,
      'refer_code' :referController.text??"",
    };

    await _api.registerApi(data).then((value){
      print(value.status);
      if(value.status == 200){
        Get.offNamed(RouteName.otpScreen);
        //Utils().successMessage("Register successfully!!!");
        }else{
        print("Data Error");
        Utils().errorMessage(value.message);
        }
      Utils().hideLoading();
    }).onError((error, stackTrace){
      Utils().hideLoading();
      print(error.toString());
    });

  }
}
