import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventInvoiceScreen extends StatefulWidget {
  const EventInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<EventInvoiceScreen> createState() => _EventInvoiceScreenState();
}

class _EventInvoiceScreenState extends State<EventInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(elevation: 0),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
            backgroundColor: AppColors.redColor,
            shape:
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: SmallText(
            text: 'withdraw_amount'.tr.toUpperCase(),
            size: 18,
            color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWidget(
              text: 'invoice'.tr,
              txtColor: Colors.white,
              iconColor: Colors.white,
              bgColor: AppColors.appColor,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    SmallText(
                        text: 'invoice_no'.tr, size: 14, color: Colors.white),
                    SmallText(
                        text: '58595754', size: 14, color: AppColors.greenColor)
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar.builder(
                              itemSize: 15,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) =>
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (double value) {
                                print(value);
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              height: 18,
                              color: AppColors.redColor,
                              child: const Center(
                                child: SmallText(
                                  text: "Music",
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SmallText(
                                text: "Cooking Together",
                                size: 24,
                                color: Colors.black),
                            const SizedBox(height: 10),
                            SmallText(
                                text: "July 23, 2021 - 10:00AM",
                                size: 14,
                                color: AppColors.txtgreyColor),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                        text: 'total_ticket_book'.tr,
                                        size: 12,
                                        color: AppColors.txtgreyColor,
                                        fontWeight: FontWeight.normal),
                                    const SizedBox(height: 5),
                                    const SmallText(
                                        text: "65895",
                                        size: 18,
                                        color: Colors.black),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                        text: 'total_amount'.tr,
                                        size: 12,
                                        color: AppColors.txtgreyColor,
                                        fontWeight: FontWeight.normal),
                                    const SizedBox(height: 5),
                                    const SmallText(
                                        text: "\$5696.00",
                                        size: 18,
                                        color: Colors.black),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        color: AppColors.edtBgColor,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                        text: 'sub_total'.tr,
                                        size: 14,
                                        color: AppColors.txtgreyColor),
                                    const SmallText(
                                        text: '\$600.00',
                                        size: 14,
                                        color: Colors.black),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 1,
                                  color: AppColors.lineColor,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                        text: 'commission'.tr,
                                        size: 14,
                                        color: AppColors.txtgreyColor),
                                    const SmallText(
                                        text: '\$100.00',
                                        size: 14,
                                        color: Colors.black),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 1,
                                  color: AppColors.lineColor,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                        text: 'gst'.tr,
                                        size: 14,
                                        color: AppColors.txtgreyColor),
                                    const SmallText(
                                        text: '\$20.00',
                                        size: 14,
                                        color: Colors.black),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 1,
                                  color: AppColors.lineColor,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                        text: 'payable_amount'.tr,
                                        size: 14,
                                        color: AppColors.txtgreyColor),
                                    const SmallText(
                                        text: '\$520.00',
                                        size: 14,
                                        color: Colors.black),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child:Center(
                          child: QrImage(
                            data: "1234567890",
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  child: Center(
                    child: SmallText(
                      text: 'download_invoice'.tr,
                      color: AppColors.greenColor,
                      size: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
