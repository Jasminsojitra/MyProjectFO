import 'package:festum_evento/screen/LoginAndSignUp/screen/otp_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/controller/forgot_password/Forgot_Password_controller.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../LoadingComponent.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgotPasswordController = ForgotPasswordController();

  final forgetKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingComponent(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: forgetKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/svg/ic_back_arrow.svg",
                          height: 18, width: 22),
                    ),
                    const SizedBox(height: 40),
                    BigText(
                        text: 'forgot_password'.tr,
                        color: Colors.black,
                        weight: FontWeight.bold),
                    const SizedBox(height: 30),
                    EditTextWidget(
                      line: 1,
                      isFocus: true,
                      isCompulsoryText: false,
                      text: 'email_phone'.tr,
                      textEditingController: forgotPasswordController.phoneController.value,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_email_number'.tr;
                        }
                        return null;
                      },
                      bgColor: AppColors.edtBgColor,
                    ),
                    const SizedBox(height: 30),
                    ButtonWidget(
                        callback: () {
                          if (forgetKey.currentState!.validate()) {
                             forgotPasswordController.forgot();
                          }
                        },
                        bgColor: AppColors.redColor,
                        text: 'send_otp'.tr)
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
