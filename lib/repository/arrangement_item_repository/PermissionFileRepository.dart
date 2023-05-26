
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/utils/app_url.dart';
import 'package:dio/dio.dart' as d;
import '../../model/arrangement_item_model/PermissionLatterRespo.dart';

class PermissionFileRepository {
  final api = NetworkApiServices();

  // Get Select Category List api
  Future<PermissionLatterRespo> getMediaItemRepo(id) async {
    var response = await api.getApiWithToken(AppUrl.getPermissionLatter+id);
    return PermissionLatterRespo.fromJson(response.toJson());
  }

  Future<dynamic> postPermissionLatterDataRepo(data) async {
    var response = await api.postApiWithToken(data,AppUrl.postPermissionLatter);
    return response;
  }

  //Add Arrangment
  Future<dynamic> postPermissionLetterRepo(File imageFile) async {

    String fileName = imageFile!.path.split('/').last;
    d.FormData formData = d.FormData.fromMap({
      "file":await d.MultipartFile.fromFile(imageFile!.path, filename:fileName,contentType: MediaType("application","pdf")),
      "type": "application/pdf"
    });
    final response = await api.postImageApiWithToken(formData, AppUrl.postPermissionMedia);
    return response;
  }

}