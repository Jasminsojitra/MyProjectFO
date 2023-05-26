import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/utils/app_url.dart';

class LoginRepository{

  final _apiservice = NetworkApiServices();
  Future<dynamic> loginApi(var data) async{
    final response = await _apiservice.postApi(data, AppUrl.loginUrl);
    return response;
  }
}