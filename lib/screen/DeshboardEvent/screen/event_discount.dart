import 'package:festum_evento/screen/DeshboardEvent/screen/event_compuny_detils.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventDiscountScreen extends StatefulWidget {
  const EventDiscountScreen({Key? key}) : super(key: key);

  @override
  State<EventDiscountScreen> createState() => _EventDiscountScreenState();
}

class _EventDiscountScreenState extends State<EventDiscountScreen> {
  TextEditingController? billController;
  final totalKey = GlobalKey<FormState>();
  String totalDiscount = "20";

  @override
  void initState() {
    billController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    billController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(elevation: 0),
      ),
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EventCompanyDetailsScreen()));
          },
          firstTxt: 'back'.tr,
          secondTxt: 'next'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWidget(
              text: 'let_create_it'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.greenColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                                text: 'discount_total_bill'.tr,
                                size: 16,
                                color: Colors.white),
                            InkWell(
                              child: SvgPicture.asset(
                                  "assets/svg/icon_edit_btn.svg"),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: AppColors.edtBgColor,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Form(
                                              key: totalKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SmallText(
                                                          text:
                                                              'discount_total_bill'.tr,
                                                          size: 18,
                                                          color: Colors.black),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: SvgPicture.asset(
                                                            "assets/svg/ic_close.svg",
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  EditTextWidget(
                                                      isCompulsoryText: false,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          totalDiscount = value;
                                                        });
                                                      },
                                                      line: 1,
                                                      text:
                                                          'discount_total_bill'.tr,
                                                      textEditingController:
                                                          billController!,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      textInputType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Enter Discount On Total Bill";
                                                        }
                                                        return null;
                                                      },
                                                      bgColor: Colors.white),
                                                  const SizedBox(height: 15),
                                                  const SmallText(
                                                      text:
                                                          "* Terms & Conditions",
                                                      size: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  const SizedBox(height: 5),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF2E363F),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          height: 1.5),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    fixedSize: const Size(
                                                        double.maxFinite, 50),
                                                    backgroundColor:
                                                        AppColors.redColor,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  child: SmallText(
                                                      text: 'cancel'.tr,
                                                      color: Colors.white,
                                                      size: 18),
                                                ),
                                              ),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (totalKey.currentState!
                                                        .validate()) {
                                                      setState(
                                                        () {
                                                          totalDiscount =
                                                              billController!
                                                                  .text;
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      fixedSize: const Size(
                                                          double.maxFinite, 50),
                                                      backgroundColor:
                                                          AppColors.greenColor,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)))),
                                                  child: SmallText(
                                                      text: 'apply'.tr,
                                                      color: Colors.white,
                                                      size: 18),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SmallText(
                            text: totalDiscount.isEmpty
                                ? totalDiscount
                                : totalDiscount + "%",
                            size: 20,
                            color: Colors.black),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
