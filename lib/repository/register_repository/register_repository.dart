import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/utils/app_url.dart';

class RegisterRepository{

  final apiService = NetworkApiServices();

  Future<dynamic> registerApi(var data) async{
    final response = await apiService.postApi(data, AppUrl.registerUrl);
    return response;
  }

}