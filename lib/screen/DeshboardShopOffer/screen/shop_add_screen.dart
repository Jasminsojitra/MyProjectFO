import 'dart:collection';
import 'package:festum_evento/screen/DeshboardShopOffer/screen/shop_social_media_screen.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/time_picker_widgets.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DayModel {
  String day;
  bool isSelect = false;

  DayModel({required this.day});
}

class ShopAddScreen extends StatefulWidget {
  const ShopAddScreen({Key? key}) : super(key: key);

  @override
  State<ShopAddScreen> createState() => _ShopAddScreenState();
}

class _ShopAddScreenState extends State<ShopAddScreen> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutUsController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  final shopKey = GlobalKey<FormState>();

  String? valueChoose;
  final listDropItem = ["Kid's Wear", "Men's Wear", "Women's Wear"];

  final List listDay = ["SU", "MO", "TU", "WE", "TH", "FR", "SR"];

  HashSet selectItem = new HashSet();

  double? lat;

  double? long;

  String address = "";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      print("value $value");
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }

  //For convert lat long to address
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      address =
          '${placemarks[0].street}, ${placemarks[0].subLocality},${placemarks[0].subAdministrativeArea}, ${placemarks[0].postalCode}';
      addressController.text = address.toString();
    });

    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }

  @override
  void initState() {
    startTimeController.text = "";
    endTimeController.text = "";
    getLatLong();
    super.initState();
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
            // if (shopKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopSocialMediaScreen(),
                ),
              );
            // }
          },
          firstTxt: 'cancel'.tr,
          secondTxt: 'continue'.tr),
      body: Form(
        key: shopKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWidget(
              text: 'let_add_shop'.tr,
              tapCallback: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  EditTextWidget(
                      line: 1,
                      text: 'shop_name'.tr,
                      textEditingController: shopNameController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_shop_name'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: SmallText(
                          text: 'select_category'.tr,
                          size: 14,
                          color: Colors.black),
                      icon: Transform.rotate(
                          angle: -180 * 3.14 / 360,
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          )),
                      value: valueChoose,
                      underline: const SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          valueChoose = value;
                        });
                      },
                      items: listDropItem.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: SmallText(
                              text: value, size: 16, color: Colors.black),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SmallText(
                      text: 'shop_day'.tr,
                      size: 14,
                      color: AppColors.greyColor),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 7,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: listDay.map((path) {
                        return GridTile(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (selectItem.contains(path)) {
                                  selectItem.remove(path);
                                } else {
                                  selectItem.add(path);
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: selectItem.contains(path)
                                    ? Border.all(
                                        color: AppColors.greenColor, width: 1)
                                    : Border.all(
                                        color: Colors.transparent, width: 0),
                              ),
                              child: SizedBox(
                                width: 42,
                                height: 42,
                                child: Center(
                                  child: SmallText(
                                      text: path,
                                      size: 12,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TimePickerWidget(
                            text: 'start_time'.tr,
                            txtController: startTimeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter_start_time'.tr;
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TimePickerWidget(
                            text: 'end_time'.tr,
                            txtController: endTimeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter_end_time'.tr;
                              }
                              return null;
                            }),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 3,
                      text: 'about_us'.tr,
                      textEditingController: aboutUsController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_about_us'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 1,
                      text: 'state'.tr,
                      textEditingController: stateController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_state'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 1,
                      text: 'city'.tr,
                      textEditingController: cityController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_city'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  EditTextWidget(
                      line: 1,
                      text: 'pincode'.tr,
                      textEditingController: pinCodeController,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      isCompulsoryText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_pincode'.tr;
                        }
                        return null;
                      },
                      bgColor: Colors.white),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'type_here_address'.tr,
                              hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none)),
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          textAlignVertical: TextAlignVertical.top,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.maxFinite, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: AppColors.redColor,
                            ),
                            child: SmallText(
                                text: 'location_from_google_map'.tr,
                                size: 16,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
