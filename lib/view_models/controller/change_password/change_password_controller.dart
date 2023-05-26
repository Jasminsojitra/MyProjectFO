import 'package:festum_evento/repository/change_pass_repository/change_pass_repository.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final _api = ChangePassRepository();

  final passwordController = TextEditingController();

  final mobile = Get.arguments;

  void changePassword() {
    Map data = {'mobile': mobile, 'password': passwordController.value.text};

    _api.changePassApi(data).then((value) {
      if (value == null) {
        SnackbarWidget(value['error']);
      } else {
        Get.offNamed(RouteName.deshboardScreen);
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
