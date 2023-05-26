import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/model/arrangement_item_model/ArrangementItemModel.dart';
import 'package:festum_evento/utils/app_url.dart';

import '../../model/ArrangementListModel.dart';
import '../../model/arrangement_item_model/GetarrangementlistModel.dart';

class ArrangementItemRepository {
  final api = NetworkApiServices();

  // Get Select Category List api
  Future<ArrangementItemModel> getArrangementItemRepo() async {
    var response = await api.getApiWithToken(AppUrl.eventArrangementItemEvent);
    return ArrangementItemModel.fromJson(response.toJson());
  }

  Future<GetarrangementlistModel> getArrangementItemListRepo(id) async {
    var response = await api.getApiWithToken(AppUrl.getArrangementItemList+id);
    return GetarrangementlistModel.fromJson(response.toJson());
  }

  //Add Arrangment
  Future<dynamic> postArrangmentRepo(var data) async {
    final response = await api.postApiWithToken(data, AppUrl.eventArrangementEvent);
    return response;
  }
}