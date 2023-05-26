import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersAttendeeModel {
  String mainText, dateTxt, priceTxt, ticketTxt, codeTxt;

  OffersAttendeeModel(
      {required this.mainText,
        required this.dateTxt,
        required this.priceTxt,
        required this.ticketTxt,
        required this.codeTxt});
}

class OffersAttendeeFragment extends StatefulWidget {
  const OffersAttendeeFragment({Key? key}) : super(key: key);

  @override
  State<OffersAttendeeFragment> createState() => _OffersAttendeeFragmentState();
}

class _OffersAttendeeFragmentState extends State<OffersAttendeeFragment> {
  double sliderValue = 50;

  final List<OffersAttendeeModel> listAttendee = <OffersAttendeeModel>[
    OffersAttendeeModel(
        mainText: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        priceTxt: "\$560.00",
        ticketTxt: "15 Ticket",
        codeTxt: "#55841251"),
    OffersAttendeeModel(
        mainText: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        priceTxt: "\$560.00",
        ticketTxt: "15 Ticket",
        codeTxt: "#55841251"),
    OffersAttendeeModel(
        mainText: "Reynaldo Franklin",
        dateTxt: "July 13, 2021",
        priceTxt: "\$560.00",
        ticketTxt: "15 Ticket",
        codeTxt: "#55841251"),
    OffersAttendeeModel(
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: AppColors.redColor,

        child: Image.asset("assets/png/ic_scanner.png"),
      ),
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
                      )),
                  child: SmallText(
                      text: 'check'.tr, size: 18, color: Colors.white))
            ],
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.network(
            "https://fastly.picsum.photos/id/755/5000/3800.jpg?hmac=kHxjzz3TQ4ZQLtUF3fNgIiBMwHc04Kf9xg9jfYsabxM",
            width: double.infinity,
            fit: BoxFit.fill,
            height: 210,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                                text: listAttendee[index].mainText,
                                size: 16,
                                color: Colors.black),
                            SmallText(
                                text: listAttendee[index].codeTxt,
                                size: 12,
                                color: AppColors.greenColor),
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
    );
  }
}
