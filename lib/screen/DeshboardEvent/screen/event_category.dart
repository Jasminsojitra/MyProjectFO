import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:festum_evento/view_models/controller/event_categories_list/event_categories_list_controller.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../LoadingComponent.dart';

class EventCategoryScreen extends StatefulWidget {
  const EventCategoryScreen({Key? key}) : super(key: key);

  @override
  State<EventCategoryScreen> createState() => _EventCategoryScreenState();
}

class _EventCategoryScreenState extends State<EventCategoryScreen> {
  final eventCategoryList = Get.put(EventCategoriesListController());

  final eventKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      eventCategoryList.categoriesListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
        backgroundColor: AppColors.edtBgColor,
        bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
            backgroundColor: AppColors.redColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          onPressed: () {
            Utils.onLoading(context);
            if (eventKey.currentState!.validate()) {
              if (eventCategoryList.eventLists == null) {
                eventCategoryList.addEventApi();
                Navigator.pop(context);
              } else {
                eventCategoryList.editEventApi();
                Navigator.pop(context);
              }
            }
          },
          child: SmallText(
              text: 'submit'.tr.toUpperCase(), size: 18, color: Colors.white),
        ),
        body: Column(
          children: [
            ToolbarWidget(
                text: 'add_event'.tr,
                tapCallback: () {
                  Get.back();
                  eventCategoryList.ids = null;
                }),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Form(
                      key: eventKey,
                      child: EditTextWidget(
                          line: 1,
                          isCompulsoryText: false,
                          text: 'what_event_name'.tr,
                          textEditingController: eventCategoryList.nameController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_event_name'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white)),
                  const SizedBox(height: 20),
                  SmallText(
                      text: 'what_event_type'.tr,
                      size: 14,
                      color: AppColors.txtgreyColor),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: <Widget>[
                              Radio<String>(
                                value: 'b2b',
                                activeColor: AppColors.greenColor,
                                groupValue: eventCategoryList.isSelectList,
                                onChanged: (value) {
                                  setState(() {
                                    eventCategoryList.isSelectList = value!;
                                  });
                                },
                              ),
                              const SizedBox(width: 5),
                              SmallText(
                                  text: 'b2b'.tr, size: 16, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: <Widget>[
                              Radio<String>(
                                value: 'public_party',
                                activeColor: AppColors.greenColor,
                                groupValue: eventCategoryList.isSelectList,
                                onChanged: (value) {
                                  setState(() {
                                    eventCategoryList.isSelectList = value!;
                                  });
                                },
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: SmallText(
                                    text: 'public_party'.tr,
                                    size: 16,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<EventCategoriesListController>(
                      builder: (eventCategoryList) {
                    return eventCategoryList.isSelectList == "b2b"
                        ? eventCategoryList.categoriesList != null
                            ? GridView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: (2 / 0.5),
                                        crossAxisCount: 2),
                                itemCount:
                                    eventCategoryList.categoriesList!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        for (var element
                                            in eventCategoryList.categoriesList) {
                                          element.isSelected = false;
                                        }
                                        eventCategoryList.categoriesList[index]
                                            .isSelected = true;
                                        eventCategoryList.ids = eventCategoryList
                                            .categoriesList[index].sId;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: eventCategoryList
                                                    .categoriesList[index]
                                                    .isSelected ??
                                                false
                                            ? Border.all(
                                                color: AppColors.greenColor,
                                                width: 1)
                                            : Border.all(
                                                color: AppColors.boxLineColor,
                                                width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: SmallText(
                                            text: eventCategoryList
                                                .categoriesList[index]
                                                .categoryname!,
                                            size: 14,
                                            color: eventCategoryList
                                                        .categoriesList![index]
                                                        .isSelected ??
                                                    false
                                                ? AppColors.greenColor
                                                : AppColors.boxLineColor),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator())
                        : eventCategoryList.categoriesPPList != null
                            ? GridView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: (2 / 0.5),
                                        crossAxisCount: 2),
                                itemCount:
                                    eventCategoryList.categoriesPPList!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        for (var element in eventCategoryList
                                            .categoriesPPList) {
                                          element.isSelected = false;
                                        }
                                        eventCategoryList.categoriesPPList[index]
                                            .isSelected = true;
                                        eventCategoryList.ids = eventCategoryList
                                            .categoriesPPList[index].sId;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: eventCategoryList
                                                    .categoriesPPList![index]
                                                    .isSelected ??
                                                false
                                            ? Border.all(
                                                color: AppColors.greenColor,
                                                width: 1)
                                            : Border.all(
                                                color: AppColors.boxLineColor,
                                                width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: SmallText(
                                            text: eventCategoryList
                                                .categoriesPPList![index]
                                                .categoryname!,
                                            size: 14,
                                            color: eventCategoryList
                                                        .categoriesPPList![index]
                                                        .isSelected ??
                                                    false
                                                ? AppColors.greenColor
                                                : AppColors.boxLineColor),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : CircularProgressIndicator();
                  }),
                  const SizedBox(height: 20),
                  EditTextWidget(
                    text: 'other'.tr,
                    isCompulsoryText: false,
                    textEditingController: eventCategoryList.otherController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_other'.tr;
                      }
                      return null;
                    },
                    bgColor: Colors.white,
                    line: 1,
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
