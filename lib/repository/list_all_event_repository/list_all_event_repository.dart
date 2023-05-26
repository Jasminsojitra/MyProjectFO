import 'dart:convert';

import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/model/list_all_event/ListAllEventModel.dart';
import 'package:festum_evento/utils/app_url.dart';

class ListAllEventRepository{

  final _apiSevice = NetworkApiServices();

  Future<ListAllEventModel?> listAllEventRepo(dynamic data) async{
    final response = await _apiSevice.postApiWithToken(data, AppUrl.listAllEvent);
    return ListAllEventModel.fromJson(response.toJson());
  }
}