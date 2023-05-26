import 'dart:convert';

import 'package:festum_evento/model/ArrangementListModel.dart';
import 'package:festum_evento/model/arrangement_item_model/ArrangementItemModel.dart';
import 'package:festum_evento/repository/arrangement_item_repository/arrangement_item_repository.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:get/get.dart';

import '../../../model/arrangement_item_model/GetarrangementlistModel.dart';
import '../../../res/routes/routes_name.dart';

class ArrangementItemController extends GetxController {
  final apiService = ArrangementItemRepository();

  ArrangementItemModel? arrangeModel=ArrangementItemModel();
  RxBool loading = false.obs;
  //get category item
  Future<void> getArrangement() async {
    Utils().showLoading();
    try{
    loading.value = true;
    arrangeModel = await apiService.getArrangementItemRepo();
    loading.value = false;
    update();
    }catch(ex){
      Utils().hideLoading();
      print(ex);
    }
  }

  Future<void> getArrangementList() async {
    Utils().showLoading();
    try{
      loading.value = true;
      arrangements = await apiService.getArrangementItemListRepo(Get.arguments);
      loading.value = false;
      Utils().hideLoading();
      update();
    }catch(ex){
      Utils().hideLoading();
      print(ex);
    }
  }

  int total_number_of_seating_items=0;
  int total_per_seating_persons = 0;
  int total_persons=0;
  double per_seating_price=0;
  double per_person_price=0;
  double total_amount=0;
  String? title;

  List<Arrangements>? arrangements_Items = [];
  GetarrangementlistModel? arrangements=GetarrangementlistModel();

  void addArrangementEventApi() async{
    Utils().showLoading();

    try{
      ArrangementListModel arrangementListModel=ArrangementListModel(
          eventid: arrangements!.data!.sId,
          seatingArrangements: []
      );

      for (var seatingArrangements in arrangements!.data!.seatingArrangements!) {
        arrangementListModel.seatingArrangements!.add(SeatingArrangement(
            arrangements: seatingArrangements.arrangements!,
            seatingItem: seatingArrangements.seatingItem!.sId!,
            equipment: seatingArrangements.equipment,
            equipmentDescription: seatingArrangements.equipmentDescription,
            food: seatingArrangements.food,
            foodDescription: seatingArrangements.foodDescription,
            totalCalculations: seatingArrangements.totalCalculations!
        ));
      }

      ArrangementListModel ArrangementList=ArrangementListModel(
        eventid: arrangements!.data!.sId,
      );

      final jsondd = json.encode(arrangementListModel);
      final json1 = json.decode(jsondd);

      apiService.postArrangmentRepo(json1).then((value){
        if(value == null){
          Utils().hideLoading();
          Utils().errorMessage("Please try again");
        }else{
          Utils().hideLoading();
          Get.toNamed(RouteName.eventLocationScreen, arguments: arrangements!.data!.sId);
          //update();
        }
      });
    }catch(ex){
      Utils().hideLoading();
      Utils().errorMessage("Please try again");
    }


  }
}
