abstract class BaseApiServices{

  Future<dynamic> getApiWithToken(String url);

  Future<dynamic> postApi(dynamic data,String url);

  Future<dynamic> postApiWithToken(dynamic data,String url);
}