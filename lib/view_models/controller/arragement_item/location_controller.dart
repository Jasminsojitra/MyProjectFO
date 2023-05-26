import 'dart:convert';

import 'package:festum_evento/model/ArrangementListModel.dart';
import 'package:festum_evento/model/arrangement_item_model/ArrangementItemModel.dart';
import 'package:festum_evento/repository/arrangement_item_repository/arrangement_item_repository.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/arrangement_item_model/GetarrangementlistModel.dart';
import '../../../repository/arrangement_item_repository/location_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../screen/DeshboardEvent/Model/LocationModel.dart';

class LocationController extends GetxController {
  final apiService = LocationRepository();
  LatLng? currentLatLng;
  TextEditingController flatNoEditingController = TextEditingController();
  TextEditingController streetNameEditingController = TextEditingController();
  TextEditingController areaNameEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController stateEditingController = TextEditingController();
  TextEditingController pincodeEditingController = TextEditingController();
  TextEditingController locationEditingController = TextEditingController();
  bool isEdit=false;

  Future<int> getLocation() async {
    Utils().showLoading();
    try{
      LocationModel locationModel = await apiService.getLocationRepo(Get.arguments);
      flatNoEditingController.text=locationModel.data!.eventLocation!.flatNo!;
      streetNameEditingController.text=locationModel.data!.eventLocation!.streetName!;
      areaNameEditingController.text=locationModel.data!.eventLocation!.areaName!;
      cityEditingController.text=locationModel.data!.eventLocation!.city!;
      stateEditingController.text=locationModel.data!.eventLocation!.state!;
      pincodeEditingController.text=locationModel.data!.eventLocation!.pincode!;
      locationEditingController.text=locationModel.data!.eventLocation!.manualAddress!;
      currentLatLng=LatLng(locationModel.data!.eventLocation!.location!.coordinates![1],
          locationModel.data!.eventLocation!.location!.coordinates![0]);
      isEdit=true;
      Utils().hideLoading();
      //update();
      return 200;
    }catch(ex){
      isEdit=false;
      Utils().hideLoading();
      print(ex);
      return 0;
    }
  }


  void addArrangementEventApi() async{

    var data={
      "street_name": streetNameEditingController.text,
      "area_name": areaNameEditingController.text,
      "longitude": currentLatLng!.longitude,
      "latitude": currentLatLng!.latitude,
      "city": cityEditingController.text,
      "state": stateEditingController.text,
      "pincode": pincodeEditingController.text,
      "manual_address": locationEditingController.text,
      "eventid": Get.arguments,
      "flat_no": flatNoEditingController.text,
    };
    print(data);
    apiService.postLocationRepo(data).then((value){
      if(value == null){
        Utils().errorMessage("Please try again");
        print("Data not add");
      }else{
        //Utils.toastMessage("Data add");
        Get.toNamed(RouteName.eventGalleryScreen, arguments: Get.arguments);
      }
    });


  }
}
