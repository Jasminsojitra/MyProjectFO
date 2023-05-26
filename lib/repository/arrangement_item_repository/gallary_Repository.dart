
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:festum_evento/data/network/network_api_services.dart';
import 'package:festum_evento/model/arrangement_item_model/ArrangementItemModel.dart';
import 'package:festum_evento/utils/app_url.dart';
import '../../model/arrangement_item_model/GetarrangementlistModel.dart';
import 'package:dio/dio.dart' as d;

import '../../model/arrangement_item_model/MediaModel.dart';

class GallaryRepository {
  final api = NetworkApiServices();

  // Get Select Category List api
  Future<MediaRespoModel> getMediaItemRepo(id) async {
    var response = await api.getApiWithToken(AppUrl.getMedia+id);
    return MediaRespoModel.fromJson(response.toJson());
  }

  Future<dynamic> postDataRepo(data) async {
    var response = await api.postApiWithToken(data,AppUrl.postMedia);
    return response;
  }

  //Add Arrangment
  Future<dynamic> postPosterImageRepo(File imageFile) async {
    // var result = await FlutterImageCompress.compressAndGetFile(
    //   imageFile.path, imageFile.path,
    //   quality: 100,
    // );

    String fileName = imageFile!.path.split('/').last;
    d.FormData formData = d.FormData.fromMap({
      "file":await d.MultipartFile.fromFile(imageFile!.path, filename:fileName,contentType: MediaType("image","jpeg")),
      "type": "image/jpeg"
    });
    final response = await api.postImageApiWithToken(formData, AppUrl.postBannerImage);
    return response;
  }

  Future<dynamic> postImageRepo(File imageFile) async {
    // var result = await FlutterImageCompress.compressAndGetFile(
    //   imageFile.path, imageFile.path,
    //   quality: 100,
    // );

    String fileName = imageFile!.path.split('/').last;
    d.FormData formData = d.FormData.fromMap({
      "file":await d.MultipartFile.fromFile(imageFile!.path, filename:fileName,contentType: MediaType("image","jpeg")),
      "type": "image/jpeg"
    });
    final response = await api.postImageApiWithToken(formData, AppUrl.postImage);
    return response;
  }

  Future<dynamic> postVideoRepo(File videoFile) async {
    // var result = await FlutterImageCompress.compressAndGetFile(
    //   imageFile.path, imageFile.path,
    //   quality: 100,
    // );

    String fileName = videoFile!.path.split('/').last;
    d.FormData formData = d.FormData.fromMap({
      "file":await d.MultipartFile.fromFile(videoFile!.path, filename:fileName,contentType: MediaType("video","mp4")),
      "type": "video/mp4"
    });
    final response = await api.postImageApiWithToken(formData, AppUrl.postVideo);
    return response;
  }
}