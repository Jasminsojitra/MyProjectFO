import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/model/event_times/EventTimeModel.dart';
import 'package:festum_evento/utils/app_url.dart';
import 'package:get/get.dart';

class EventTimeRepository{

  final _api = NetworkApiServices();

  Future<dynamic> eventTimeRepo(var data) async{
    var response = await _api.postApiWithToken(data, AppUrl.eventTimeEvent);
    return EventTimeModel.fromJson(response.toJson());
  }

  var ids = Get.arguments;

  Future<EventTimeModel> getEventTimeRepo() async{
    var response = await _api.getApiWithToken(AppUrl.eventTimeEvent+"?eventid="+ids);
    return EventTimeModel.fromJson(response.toJson());
  }
}