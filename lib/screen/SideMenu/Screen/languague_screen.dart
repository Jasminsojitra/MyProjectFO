import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LanguagueModel {
  String nameTxt, currency;
  bool isSelect = false;
  FlagsCode flagsCode;
  Locale local;

  LanguagueModel(
      {required this.nameTxt,
      required this.currency,
      required this.isSelect,
      required this.flagsCode,
      required this.local});
}

class LanguagueScreen extends StatefulWidget {
  const LanguagueScreen({Key? key}) : super(key: key);

  @override
  State<LanguagueScreen> createState() => _LanguagueScreenState();
}

class _LanguagueScreenState extends State<LanguagueScreen> {
  final List<LanguagueModel> listLanguague = <LanguagueModel>[
    LanguagueModel(
      nameTxt: "United States - English",
      currency: "Dollar",
      isSelect: false,
      flagsCode: FlagsCode.US,
      local:const Locale('en', 'US'),
    ),
    LanguagueModel(
        flagsCode: FlagsCode.IN,
        nameTxt: "India - Hindi",
        currency: "Indian Rupee",
        local: const Locale('hi', 'IN'),
        isSelect: false),
    LanguagueModel(
        flagsCode: FlagsCode.DE,
        local: const Locale('ger', 'GE'),
        nameTxt: "Germany - German",
        currency: "German Mark (DEM)",
        isSelect: false),
    LanguagueModel(
        flagsCode: FlagsCode.CN,
        local:const Locale('en', 'US'),
        nameTxt: "China - Mandarin",
        currency: "Renminbi",
        isSelect: false),
    LanguagueModel(
        flagsCode: FlagsCode.TH,
        nameTxt: "Thailand - Thai",
        local: const Locale('en', 'US'),
        currency: "Thai Baht",
        isSelect: false),
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(elevation: 0),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.redColor,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            fixedSize: const Size(double.infinity, 50)),
        onPressed: () {
          for(int i = 0;i<listLanguague.length;i++){
            if(listLanguague[i].isSelect == true){
              updateLanguage(listLanguague[i].local);
            }
          }
        },
        child: const SmallText(text: "SAVE", size: 18, color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWidget(
              text: 'language_and_currency'.tr,
              tapCallback: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listLanguague.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: ListTile(
                          leading: Flag.fromCode(
                            listLanguague[index].flagsCode,
                            height: 25,
                            width: 40,
                            fit: BoxFit.fill,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallText(
                                  text: listLanguague[index].nameTxt,
                                  size: 14,
                                  color: Colors.black),
                              const SizedBox(height: 5),
                              SmallText(
                                  text: listLanguague[index].nameTxt,
                                  size: 12,
                                  color: AppColors.redColor),
                            ],
                          ),
                          trailing: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                shape: CircleBorder(),
                                value: listLanguague[index].isSelect,
                                activeColor: AppColors.greenColor,
                                onChanged: (bool? value) {
                                  setState(() {
                                    for (var element in listLanguague) {
                                      element.isSelect = false;
                                    }
                                    listLanguague[index].isSelect = value!;
                                    // updateLanguage(listLanguague[index].local);
                                  });
                                },
                              )),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
