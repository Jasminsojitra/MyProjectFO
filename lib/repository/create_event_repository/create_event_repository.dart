import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/utils/app_url.dart';

class CreateEventRepository{

  final _api = NetworkApiServices();

  Future<dynamic> createEventApi(var data) async{
    final response = await _api.postApiWithToken(data, AppUrl.eventCreateList);
    return response;
  }

  Future<dynamic> addEventApi(var data) async{
    final response = await _api.postApiWithToken(data, AppUrl.eventCreateList);
    return response;
  }
}