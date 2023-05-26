import 'package:festum_evento/screen/SideMenu/Model/HistoryModel.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<HistoryModel> _historyList = [
    HistoryModel(
        mainText: "Event Created",
        subtext: "Mark Jecno Event Created",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Coin Trasfer ",
        subtext: "Coin Trasfer to Orgenaizer",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Event Created",
        subtext: "Mark Jecno Event Created",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Coin Trasfer ",
        subtext: "Coin Trasfer to Orgenaizer",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Coin Trasfer ",
        subtext: "Coin Trasfer to Orgenaizer",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
    HistoryModel(
        mainText: "Offer Booked",
        subtext: "Mark Jecno Offer Booked",
        dateText: "July 25, 2021",
        timeText: "10:00AM"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(child: AppBar(elevation: 0), preferredSize: Size(0, 0)),
      body: Column(
        children: [
          ToolbarWidget(
              text: 'history'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          const SizedBox(height: 20),
          Expanded(child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _historyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 10),
                      child: Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SmallText(
                                              
                                              text:
                                              _historyList[index].mainText,
                                              size: 14,
                                              color: Colors.black),
                                          SmallText(
                                              
                                              text: _historyList[index].dateText,
                                              size: 10,
                                              color: AppColors.txtgreyColor),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SmallText(
                                              
                                              text: _historyList[index].subtext,
                                              size: 12,
                                              color: AppColors.txtgreyColor),
                                          SmallText(
                                              
                                              text: _historyList[index].timeText,
                                              size: 10,
                                              color: AppColors.txtgreyColor),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                );
              })),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
