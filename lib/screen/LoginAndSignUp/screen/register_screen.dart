import 'package:festum_evento/screen/LoginAndSignUp/screen/login_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/view_models/Controller/register/register_controller.dart';
import 'package:festum_evento/widget/big_text.dart';
import 'package:festum_evento/widget/button_widget.dart';
import 'package:festum_evento/widget/common_function.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utils.dart';
import '../../LoadingComponent.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerController = RegisterController();

  final camPassController = TextEditingController();
  bool isAccepted=false;
  final registerKey = GlobalKey<FormState>();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'IN');
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
                key: registerKey,
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
                        text: 'title_register'.tr,
                        color: Colors.black,
                        weight: FontWeight.bold),
                    const SizedBox(height: 30),
                    EditTextWidget(
                      text: 'your_name'.tr,
                      bgColor: AppColors.edtBgColor,
                      textEditingController:
                          registerController.nameController,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_your_name'.tr;
                        }
                        return null;
                      },
                      line: 1,
                      isCompulsoryText: false,
                    ),
                    const SizedBox(height: 20),
                    EditTextWidget(
                      text: 'email'.tr,
                      isCompulsoryText: false,
                      line: 1,
                      bgColor: AppColors.edtBgColor,
                      textEditingController:
                          registerController!.emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_your_email'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // EditTextWidget(
                    //   line: 1,
                    //   textLength: 10,
                    //   isCompulsoryText: false,
                    //   bgColor: AppColors.edtBgColor,
                    //   text: 'phone_number'.tr,
                    //   textEditingController:
                    //       registerController.mobileController,
                    //   textInputType: TextInputType.phone,
                    //   textInputAction: TextInputAction.next,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'enter_your_phone_number'.tr;
                    //     } else if (value.length != 10) {
                    //       return 'mobile_number_must_10_digit'.tr;
                    //     }
                    //     return null;
                    //   },
                    // ),

                    SmallText(
                        text:'phone_number'.tr,color: AppColors.greyColor, size: 14),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(color: AppColors.edtBgColor,
                      borderRadius: BorderRadius.circular(5.0)),
                      padding: EdgeInsets.only(top: 2,bottom: 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                phoneNumber = number;
                                registerController.dialCode=number.dialCode;
                              },
                              onInputValidated: (bool value) {},
                              initialValue: phoneNumber,
                              selectorConfig: SelectorConfig(
                                selectorType: PhoneInputSelectorType.DROPDOWN,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                              TextStyle(color: Colors.black),
                              textFieldController:
                              registerController.mobileController,
                              formatInput: false,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              inputBorder: InputBorder.none,
                            ),
                          ),
                          // GestureDetector(
                          //     onTap: () async {
                          //       bool isvalid =
                          //           await _signUpController.validation(
                          //               phoneNumber.phoneNumber!,
                          //               phoneNumber.isoCode!);
                          //       print("object" + isvalid.toString());
                          //       if (isvalid &&
                          //           _signUpController
                          //               .phoneNumber.text.isNotEmpty) {
                          //         _signUpController
                          //             .verificationPhoneNumber(phoneNumber);
                          //       } else {
                          //         _signUpController.isPhone = true;
                          //         setState(() {});
                          //       }
                          //     },
                          //     child: Text("verify".tr,
                          //         style: _appCss.sh4
                          //             .copyWith(color: Color(0xff20c0e8)))),
                          // SizedBox(
                          //   width: 10,
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    EditTextWidget(
                      line: 1,
                      isCompulsoryText: false,
                      bgColor: AppColors.edtBgColor,
                      text: 'password'.tr,
                      textEditingController:
                          registerController.passwordController,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      suffixicon: true,
                      validator: (value) {
                        RegExp regex =
                        RegExp(r'^(?=.*[a-zA-Z]{5,})(?=.*[0-9]{2,})(?=.*[#$@!%&*?]{1,})[A-Za-z0-9#$@!%&*?]{8,20}$');

                        if (value == null || value.isEmpty) {
                          return 'enter_password'.tr;
                        } else if (!regex.hasMatch(value!))
                        {
                          return "5 alphabets, 2 number and 1 symbol in password with 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    EditTextWidget(
                      line: 1,
                      isCompulsoryText: false,
                      bgColor: AppColors.edtBgColor,
                      text: 'confirm_password'.tr,
                      textEditingController: camPassController,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      suffixicon: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_your_confirm_password'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                            text: 'refer_code'.tr,
                            color: AppColors.greyColor,
                            size: 14),
                        SmallText(
                            text: 'optional'.tr,
                            color: AppColors.greyColor,
                            size: 14,
                            fontWeight: FontWeight.normal),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 1,
                      controller: registerController.referController,
                      obscureText: false,
                      cursorColor: AppColors.appColor,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          fillColor: AppColors.edtBgColor,
                          filled: true),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child:Checkbox(
                              activeColor: AppColors.redColor,
                              value: isAccepted,
                              onChanged: (bool? value) {
                                setState(() {
                                  isAccepted = value!;
                                });
                              },
                            )),
                        const SizedBox(width: 3),
                        Text.rich(
                            TextSpan(
                                text: 'I agree to these '.tr,
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: "Terms and Conditions.".tr,
                                    recognizer: new TapGestureRecognizer()..onTap = (){
                                      launchUrl(Uri.parse("https://festumevento.com/#/privacy-policy"));
                                    },
                                    style: TextStyle(color: AppColors.greenColor)
                                      // decoration: TextDecoration.underline,
                                    ),
                                ]
                            )
                        ),

                      ],
                    ),
                    const SizedBox(height: 30),
                    ButtonWidget(
                        callback: () async {
                          if (registerKey.currentState!.validate()) {
                            if(registerController.passwordController.text == camPassController.text){
                              if(isAccepted){
                              registerController.registerApi();
                              }
                              else{
                                Utils().errorMessage("Please Agree Terms and Conditions".tr);
                              }
                            }else{
                              Utils().errorMessage("Please Enter Same Password".tr);
                            }
                          }
                        },
                        bgColor: AppColors.redColor,
                        text: 'register_now'.tr),
                    const SizedBox(height: 30),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'are_already_user'.tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Helvetica'),
                          children: [
                            TextSpan(
                              text: 'login_now'.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Helvetica',
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
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
