import 'package:festum_evento/repository/event_categories_list_repository/event_categories_list_repository.dart';
import 'package:festum_evento/res/routes/routes_name.dart';
import 'package:festum_evento/screen/DeshboardEvent/Model/CategoriesListModel.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/list_all_event/ListAllEventModel.dart' as listallEvent;

class EventCategoriesListController extends GetxController {
  final apis = EventCategoriesListRepository();

  var isSelectList = "b2b";
  RxBool isLoading = false.obs;
  String? ids;
  String? helloIds;
  Map? data;

  List<Data> categoriesList = <Data>[].obs;
  List<Data> categoriesPPList = <Data>[].obs;

  listallEvent.Doc? eventLists;

  final nameController = TextEditingController();
  final otherController = TextEditingController();

  Future<void> categoriesListApi() async {
    Utils().showLoading();
    isLoading.value = true;
    eventLists = Get.arguments;
    isSelectList = eventLists != null ? (eventLists!.eventType) : "b2b";
    data = {
      'event_type': 'b2b',
    };

    await apis.categoriesListApi(data).then((value) {
      if (value == null) {
        print(value.status);
        isLoading.value = false;
      } else {
        categoriesList = value.data!;
        nameController.text = eventLists != null ? eventLists!.name : "";
        otherController.text = eventLists != null ? eventLists!.other : "";

        if (eventLists != null) {
          for (var i = 0; i < categoriesList.length; i++) {
            if (categoriesList[i].categoryname! ==
                (eventLists!.eventCategory != null
                    ? eventLists!.eventCategory!.categoryname
                    : "")) {
              categoriesList[i].isSelected = true;
              print("Id====${categoriesList[i].sId}");
              ids = categoriesList[i].sId;
            }
          }
        }

        isLoading.value = false;
      }
      categoriesPPListApi();
    }).onError((error, stackTrace) {
      print(error.toString());
      isLoading.value = false;
      Utils().hideLoading();
    });
  }

  Future<void> categoriesPPListApi() async {

    data = {
      'event_type': 'public_party',
    };

    await apis.categoriesListApi(data).then((value) {
      if (value == null) {
        print(value.status);
      } else {
        categoriesPPList = value.data!;
        nameController.text = eventLists != null ? eventLists!.name : "";
        otherController.text = eventLists != null ? eventLists!.other : "";

        if (eventLists != null) {
          for (var i = 0; i < categoriesPPList.length; i++) {
            if (categoriesPPList[i].categoryname! == (eventLists!.eventCategory != null
                    ? eventLists!.eventCategory!.categoryname
                    : "")) {
              categoriesPPList[i].isSelected = true;
              print("Id====${categoriesPPList[i].sId}");
              ids = categoriesPPList[i].sId;
            }
          }
        }
      }
      Utils().hideLoading();
      update();

    }).onError((error, stackTrace) {
      print(error.toString());
      Utils().hideLoading();
    });
  }

  void addEventApi() {
    isLoading.value = true;
    if (ids != null || otherController.text != "") {
      data = {
        'name': nameController.value.text,
        'event_type': isSelectList == "b2b" ? 'b2b' : 'public_party',
        'event_category': ids != null ? ids.toString() : "",
        'other': otherController.text != null
            ? otherController.text
            : otherController.text = ""
      };
    } else {
      Utils.toastMessage("Event Category is required!");
    }

    apis.createEventApi(data).then((value) {
      //String ids = value.data['_id'];
      print("id......"+"${value.data}");
      if (value.data['_id'] != null) {
        Get.toNamed(RouteName.eventTimeScreen, arguments: value.data['_id']);
      }
      isLoading.value = false;
      update();

    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> editEventApi() async {
    isLoading.value = true;

    Map datas = {
      'eventid': eventLists!.id,
      'name': nameController.value.text,
      'event_type': isSelectList == "b2b" ? 'b2b' : 'public_party',
      'event_category': ids != null ? ids.toString() : "",
      'other': otherController.text != null
          ? otherController.text
          : otherController.text = ""
    };

    await apis.editEventRepo(datas).then((value) {
      if (value == null) {
        Utils.toastMessage("Data not update!!");
      } else {
        Get.toNamed(RouteName.eventTimeScreen, arguments: eventLists!.id);
        isLoading.value = true;
        update();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
