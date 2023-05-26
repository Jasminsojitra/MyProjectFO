import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/forget_password_screen.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/otp_screen.dart';
import 'package:festum_evento/screen/LoginAndSignUp/screen/register_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/Controller/login/login_controller.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../LoadingComponent.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = LoginController();

  final emailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingComponent(
        child: ListView(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
              child: Form(
                key: emailKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                        text: 'title_login'.tr,
                        color: Colors.black,
                        weight: FontWeight.bold),
                    const SizedBox(height: 30),
                    EditTextWidget(
                      line: 1,
                      isCompulsoryText: false,
                      bgColor: AppColors.edtBgColor,
                      textEditingController:
                          loginController.emailNameController,
                      textInputType: TextInputType.phone,
                      text: 'email_phone'.tr,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_email_number'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    EditTextWidget(
                      line: 1,
                      isCompulsoryText: false,
                      bgColor: AppColors.edtBgColor,
                      textEditingController:
                          loginController.passwordController,
                      textInputType: TextInputType.emailAddress,
                      text: 'password'.tr,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_password'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.topRight,
                      child: RichText(
                        text: TextSpan(
                            text: 'forget_password'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Helvetica',
                                color: AppColors.greenColor,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(RouteName.forgotPasswordScreen);
                              }),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ButtonWidget(
                        callback: () {
                          if (emailKey.currentState!.validate()) {
                            loginController.login();
                            FocusScope.of(context).unfocus();
                          }
                        },
                        bgColor: AppColors.redColor,
                        text: 'login_now'.tr),
                    const SizedBox(height: 30),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'are_you_new'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "register_now".tr,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Helvetica',
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(RouteName.registerScreen);
                                    }),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
