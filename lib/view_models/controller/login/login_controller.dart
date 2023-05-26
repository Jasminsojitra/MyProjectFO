import 'package:festum_evento/repository/login_repository/login_repository.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/view_models/user_preference/user_preference_view_model.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class LoginController extends GetxController {
  final _api = LoginRepository();

  UserPreference userPreference = UserPreference();

  var keys;
  final emailNameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    Utils().showLoading();
    Map data = {
      'mobile': emailNameController!.text,
      'password': passwordController!.text,
    };

    _api.loginApi(data).then((value) {

      if(value.status == 200){

        if (value.message == "Organizer login successfully!") {
          print("Data  "+"${value.data['token']}");
          var token =value.data['token'];
          userPreference.saveToken(token);
          print("Token  "+token);
          Get.offNamed(RouteName.deshboardScreen);
        } else {
          print("Data OTP "+"${value.data['key']}");
          keys = value.data['key'];
          Get.offNamed(RouteName.otpScreen,
              arguments: [emailNameController.value.text, value.data['key'],"isLogin"]);
        }
      } else {
        Utils().errorMessage(value.message);
      }
      Utils().hideLoading();
    }).onError((error, stackTrace) {
      print(error.toString());
      Utils().hideLoading();
      Utils().errorMessage("Something went wrong");
      //SnackbarWidget("Error");
    });
  }
}
