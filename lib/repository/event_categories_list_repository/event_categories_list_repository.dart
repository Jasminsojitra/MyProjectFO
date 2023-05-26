import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/screen/DeshboardEvent/Model/CategoriesListModel.dart';
import 'package:festum_evento/utils/app_url.dart';
import 'package:get/get.dart';

class EventCategoriesListRepository{

  final _api = NetworkApiServices();

  Future<CategoriesListModel> categoriesListApi(var data) async{
    final response = await _api.postApiWithToken(data, AppUrl.eventCategoriesList);
    return CategoriesListModel.fromJson(response.toJson());
  }

  Future<dynamic> createEventApi(var data) async{
    final response = await _api.postApiWithToken(data, AppUrl.eventCreateList);
    return response;
  }

  var ids = Get.arguments;

  Future<dynamic> editEventRepo(var data) async{
    final response = await _api.postApiWithToken(data,AppUrl.editEventCreate);
    return response;
  }
}