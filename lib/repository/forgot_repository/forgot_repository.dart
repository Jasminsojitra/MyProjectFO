import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/utils/app_url.dart';

class ForgotRepository{

  final apiService = NetworkApiServices();

  Future<dynamic> forgotApi(var data) async{
    final respone = await apiService.postApi(data, AppUrl.forgotPasswordUrl);
    return respone;
  }
}