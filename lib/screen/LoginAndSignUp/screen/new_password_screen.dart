import 'package:festum_evento/screen/LoginAndSignUp/screen/login_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/controller/change_password/change_password_controller.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  final changePasswordController = ChangePasswordController();
  final rePassword = TextEditingController();

  final passKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: passKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset("assets/svg/ic_back_arrow.svg",
                        height: 18, width: 22),
                  ),
                  const SizedBox(height: 40),
                  BigText(
                      text: 'create_new_password'.tr,
                      color: Colors.black,
                      weight: FontWeight.bold),
                  const SizedBox(height: 25),
                  EditTextWidget(
                      line: 1,
                      isCompulsoryText: false,
                      text: 'password'.tr,
                      bgColor: AppColors.edtBgColor,
                      textInputAction: TextInputAction.next,
                      textEditingController: changePasswordController.passwordController,
                      textInputType: TextInputType.name,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_password'.tr;
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 1,
                      isCompulsoryText: false,
                      text: 're_type_password'.tr,
                      bgColor: AppColors.edtBgColor,
                      textEditingController: rePassword,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_re_type_password'.tr;
                        }
                        return null;
                      }),
                  const SizedBox(height: 30),
                  ButtonWidget(
                      callback: () {
                        if (passKey.currentState!.validate()) {
                          if(changePasswordController.passwordController!.text == rePassword.text){
                            changePasswordController.changePassword();
                          }else{
                            SnackbarWidget("Please Enter same password");
                          }
                        }
                      },
                      bgColor: AppColors.redColor,
                      text: 'save'.tr)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
