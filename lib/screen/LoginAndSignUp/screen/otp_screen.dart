import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/Controller/otp/otp_controller.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../LoadingComponent.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = OtpController();

  String currentText = "";

  final optKey = GlobalKey<FormState>();

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
                  key: optKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: SvgPicture.asset("assets/svg/ic_back_arrow.svg",
                            height: 18, width: 22),
                      ),
                      const SizedBox(height: 40),
                      BigText(
                          text: 'enter_otp'.tr,
                          color: Colors.black,
                          weight: FontWeight.bold),
                      const SizedBox(height: 40),
                      PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_otp'.tr;
                          }
                          return null;
                        },
                        pinTheme: PinTheme(
                          inactiveColor: AppColors.edtBgColor,
                          activeColor: AppColors.edtBgColor,
                          inactiveFillColor: AppColors.edtBgColor,
                          selectedColor: AppColors.edtBgColor,
                          selectedFillColor: AppColors.edtBgColor,
                          disabledColor: AppColors.edtBgColor,
                          shape: PinCodeFieldShape.box,
                          borderWidth: 0,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: AppColors.edtBgColor,
                        ),
                        enableActiveFill: true,
                        controller: otpController.otpController.value,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        cursorColor: AppColors.otpColor,
                        textStyle: TextStyle(
                            color: AppColors.otpColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        beforeTextPaste: (text) {
                          return true;
                        },
                        enablePinAutofill: true,
                        appContext: context,
                      ),
                      const SizedBox(height: 30),
                      ButtonWidget(
                          callback: () {
                            print("Key===="+Get.arguments.toString()??"");
                            if (optKey.currentState!.validate()) {
                              otpController.otpApis();
                            }
                          },
                          bgColor: AppColors.redColor,
                          text: 'verified'.tr),
                      const SizedBox(height: 30),
                      Center(
                        child:
                        RichText(
                          text: TextSpan(
                              text: 'not_get'.tr,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: 're_send'.tr,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Helvetica',
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      Get.back();
                                      }),
                              ]),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
