import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AttendeeModel {
  String mainText, dateTxt, priceTxt, ticketTxt, codeTxt;

  AttendeeModel(
      {required this.mainText,
      required this.dateTxt,
      required this.priceTxt,
      required this.ticketTxt,
      required this.codeTxt});
}

class AttendeeFragment extends StatefulWidget {
  const AttendeeFragment({Key? key}) : super(key: key);

  @override
  State<AttendeeFragment> createState() => _AttendeeFragmentState();
}

class _AttendeeFragmentState extends State<AttendeeFragment> {
  double? sliderValue = 10;

  final List<AttendeeModel> listAttendee = <AttendeeModel>[
    AttendeeModel(
        mainText: "Reynaldo Franklin Reynaldo Franklin Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        priceTxt: "\$560.00",
        ticketTxt: "15 Ticket",
        codeTxt: "#55841251"),
    AttendeeModel(
        mainText: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        priceTxt: "\$560.00",
        ticketTxt: "15 Ticket",
        codeTxt: "#55841251"),
    AttendeeModel(
        mainText: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        priceTxt: "\$560.00",
        ticketTxt: "15 Ticket",
        codeTxt: "#55841251"),
    AttendeeModel(
        mainText: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        priceTxt: "\$560.00",
        ticketTxt: "15 Ticket",
        codeTxt: "#55841251"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      bottomNavigationBar: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.transparent,
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 0.0)),
                child: Slider(
                  thumbColor: Colors.transparent,
                  min: 0,
                  max: 100,
                  activeColor: AppColors.greenColor,
                  inactiveColor: AppColors.sliderColor,
                  value: sliderValue!,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(
                            text: 'sold'.tr,
                            size: 18,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.normal),
                        const SmallText(
                            text: "2556", size: 18, color: Colors.black),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(
                            text: 'unsold'.tr,
                            size: 18,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.normal),
                        const SmallText(
                            text: "2556", size: 18, color: Colors.black),
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    fixedSize: const Size(double.maxFinite, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: SmallText(
                      text: 'check'.tr, size: 18, color: Colors.white))
            ],
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 235,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(
                          "https://fastly.picsum.photos/id/755/5000/3800.jpg?hmac=kHxjzz3TQ4ZQLtUF3fNgIiBMwHc04Kf9xg9jfYsabxM",
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 210,
                        ),
                      ],
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 25,
                                      color: AppColors.redColor,
                                      child: const Center(
                                        child: SmallText(
                                            text: "Music",
                                            size: 14,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 72,
                                      height: 25,
                                      color: AppColors.greenColor,
                                      child: const Center(
                                        child: SmallText(
                                            text: "Festival",
                                            size: 14,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_booth.svg"),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_booth.svg"),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_booth.svg"),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  itemCount: listAttendee.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: SmallText(
                                      text: listAttendee[index].mainText,
                                      size: 16,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: SmallText(
                                        text: listAttendee[index].codeTxt,
                                        size: 12,
                                        color: AppColors.greenColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SmallText(
                                text: listAttendee[index].dateTxt,
                                size: 12,
                                color: AppColors.greyColor),
                            const SizedBox(height: 20),
                            Container(
                              height: 1,
                              color: AppColors.edtBgColor,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                    text: listAttendee[index].priceTxt,
                                    size: 18,
                                    color: Colors.black),
                                SmallText(
                                    text: listAttendee[index].ticketTxt,
                                    size: 14,
                                    color: AppColors.redColor),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
