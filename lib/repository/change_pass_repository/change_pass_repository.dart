import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/utils/app_url.dart';

class ChangePassRepository{

  final apiService = NetworkApiServices();

  Future<dynamic> changePassApi(var data) async{
    final response = await apiService.postApi(data, AppUrl.chnagePasswordUrl);
    return response;
  }
}