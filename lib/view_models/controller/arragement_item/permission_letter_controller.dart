import 'package:festum_evento/utils/utils.dart';
import 'package:get/get.dart';
import '../../../model/arrangement_item_model/MediaModel.dart';
import '../../../repository/arrangement_item_repository/PermissionFileRepository.dart';
import '../../../res/routes/routes_name.dart';

class PermissionLetterController extends GetxController {
  final apiService = PermissionFileRepository();
  String? permissionLatter;
  bool isSelect = false;
  String? fileName = "";

  Future<dynamic> getDataApi() async{
    try{
      Utils().showLoading();
      var data=await apiService.getMediaItemRepo(Get.arguments);
      if(data.status==200) {
        permissionLatter = data.data!.permissionLetter;
        isSelect = data.data!.acceptBooking!;
        fileName= permissionLatter!.split('/').last;
        update();
      }

      Utils().hideLoading();
    }catch(ex){
      Utils().hideLoading();
    }

  }

  Future<dynamic> addPermissionLatterApi(data) async{
    print(data);
    Utils().showLoading();
    var postPoster= await apiService.postPermissionLetterRepo(data);
    if(postPoster == null){
      print("Data not add");
    }else{
      Utils.toastMessage("Data add");
      //Get.toNamed(RouteName.eventGalleryScreen, arguments: Get.arguments);
    }
    Utils().hideLoading();
    return postPoster;

  }

  Future<dynamic> addDataApi() async{
    try{
      var data={
        "eventid":Get.arguments,
        "permission_letter":permissionLatter,
        "accept_booking": isSelect
      };
      await apiService.postPermissionLatterDataRepo(data).then((value){
        if(value == null){
          Utils().hideLoading();
          Utils().errorMessage("Please try again");
        }else{
          Utils().hideLoading();
          Get.toNamed(RouteName.eventPersonalDetailsScreen, arguments: Get.arguments);
          //Get.toNamed(RouteName.eventGalleryScreen, arguments: Get.arguments);
        }
      });
    }
    catch(ex){
      Utils().hideLoading();
      Utils().errorMessage("Please try again");
    }

  }
}
