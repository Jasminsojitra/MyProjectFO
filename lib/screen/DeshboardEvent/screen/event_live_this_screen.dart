import 'package:festum_evento/screen/deshboard_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventLiveThisScreen extends StatefulWidget {
  const EventLiveThisScreen({Key? key}) : super(key: key);

  @override
  State<EventLiveThisScreen> createState() => _EventLiveThisScreenState();
}

class _EventLiveThisScreenState extends State<EventLiveThisScreen> {
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
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.edtBgColor,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_close.svg",
                                        color: Colors.black),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Align(
                                  alignment: Alignment.center,
                                  child: SmallText(
                                      text: 'live_this_event'.tr,
                                      size: 25,
                                      color: Colors.black),
                                ),
                                SvgPicture.asset(
                                    "assets/svg/ic_live_event_vector.svg")
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10)),
                                    ),
                                    backgroundColor: AppColors.redColor,
                                    fixedSize: Size(double.infinity, 50)),
                                child: SmallText(
                                    text: 'cancel'.tr,
                                    size: 18,
                                    color: Colors.white),
                              )),
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DeshboardScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    fixedSize: const Size(double.infinity, 50),
                                    backgroundColor: AppColors.greenColor),
                                child: SmallText(
                                    text: 'apply'.tr,
                                    size: 18,
                                    color: Colors.white),
                              )),
                            ],
                          )
                        ],
                      ),
                    );
                  });
                });
          },
          firstTxt: 'back'.tr,
          secondTxt: "save".tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWidget(
              text: 'let_create_it'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
              child: ListView(
            children: [SvgPicture.asset("assets/svg/ic_live_event_vector.svg")],
          ))
        ],
      ),
    );
  }
}
