import 'package:festum_evento/utils/utils.dart';
import 'package:get/get.dart';
import '../../../model/arrangement_item_model/MediaModel.dart';
import '../../../repository/arrangement_item_repository/gallary_Repository.dart';
import '../../../res/routes/routes_name.dart';

class GallaryController extends GetxController {
  final apiService = GallaryRepository();
  String? posterImage;
  List<Photo> imageFileList = [];
  List<Video> videolList = [];

  removeVideo(index){
    videolList!.remove(
        videolList![
        index]);
    update();
  }

  removeImage(index){
    imageFileList!.remove(
        imageFileList![
        index]);
    update();
  }


  Future<dynamic> getDataApi() async{
    Utils().showLoading();
    await apiService.getMediaItemRepo(Get.arguments).then((value) {
      if(value.status==200) {
        posterImage = value.data!.banner;
        imageFileList = value.data!.photos!;
        videolList = value.data!.videos!;
      }
    });
    update();
    Utils().hideLoading();

  }

  Future<dynamic> addPosterImageApi(data) async{
    print(data);
    Utils().showLoading();
    var postPoster= await apiService.postPosterImageRepo(data);
      if(postPoster == null){
        print("Data not add");
      }else{
        Utils.toastMessage("Data add");
        //Get.toNamed(RouteName.eventGalleryScreen, arguments: Get.arguments);
      }
    Utils().hideLoading();
      return postPoster;

  }

  Future<dynamic> addImageApi(data) async{
    print(data);
    var postImage= apiService.postImageRepo(data);
    if(postImage == null){
      print("Data not add");
    }else{
      Utils.toastMessage("Data add");
       //Get.toNamed(RouteName.eventGalleryScreen, arguments: Get.arguments);
    }
    return postImage;

  }

  Future<dynamic> addVideoApi(data) async{
    print(data);
    var postVideo= apiService.postVideoRepo(data);
    if(postVideo == null){
      print("Data not add");
    }else{
      Utils.toastMessage("Data add");
      //Get.toNamed(RouteName.eventGalleryScreen, arguments: Get.arguments);
    }
    return postVideo;
  }

  Future<dynamic> addDataApi(data) async{
      try{
        await apiService.postDataRepo(data).then((value){
          if(value == null){
            Utils().hideLoading();
            Utils().errorMessage("Please try again");
          }else{
            Utils().hideLoading();
            Get.toNamed(RouteName.eventPermissionLetterScreen, arguments: Get.arguments);
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
