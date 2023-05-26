import 'dart:async';

import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/view_models/user_preference/user_preference_view_model.dart';
import 'package:get/get.dart';

class SplashServices {

  UserPreference userPreference = UserPreference();

  void isLogin() {

    userPreference.getToken().then((value){
      if(value.toString() == 'null'){
        Timer(const Duration(seconds: 2), () => Get.offNamed(RouteName.loginScreen));
      }else{
        Timer(const Duration(seconds: 2), () => Get.offNamed(RouteName.deshboardScreen));
      }
    });
  }
}