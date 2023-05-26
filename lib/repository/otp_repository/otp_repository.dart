import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/utils/app_url.dart';

class OtpRepository{

  final apiServices = NetworkApiServices();

  Future<dynamic> otpApi(var data) async{
    final response = await apiServices.postApi(data, AppUrl.verifyMobileUrl);
    return response;
  }
}