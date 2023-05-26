import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festum_evento/data/app_exception.dart';
import 'package:festum_evento/data/network/base_api_serices.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:festum_evento/view_models/user_preference/user_preference_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'outputHandler.dart';

//ERROR OUTPUTS
final List errorOutputs = [
  {"status": 400, "message": "Bad Request!"},
  {"status": 401, "message": "Unauthorized Request!"},
  {"status": 403, "message": "Forbidden Request!"},
  {"status": 404, "message": "Requested Url Not Found!"},
  {"status": 413, "message": "Payload Too Large!"},
  {"status": 503, "message": "Service Unavailable!"},
  {"status": 500, "message": "Internal Server Error!"},
  {"status": 504, "message": "Gateway Timeout!"}
];

//REQUEST WITH NO AUTH
final List noAuthRequest = ['login', 'register'];

class NetworkApiServices extends BaseApiServices {

  OutputHandler outputData = OutputHandler(
      message: "No Internet Found!",
      isSuccess: false,
      data: null,
      status: 0);

  @override
  Future getApiWithToken(String url) async {
    final dio = Dio();
    dynamic tokens = await UserPreference().getToken();

    Map<String, String> requestHeaders = {
      'Authorization': 'bearer ' + tokens
    };

    try {
      if (tokens != null) {
        var response = await dio.get(url, options: Options(headers: requestHeaders,));
        outputData = await responseHandler(response);
      } else {
        Utils.toastMessage("Token is Null");
      }
    }on DioError catch (e) {
      if (e.response != null &&
          Utils().isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['Data'];
        outputData.message = e.response!.data['Message'];
        outputData.isSuccess = e.response!.data['IsSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    } on RequestTimeOut {
      RequestTimeOut('');
    }
    return outputData;
  }


  @override
  Future postApi(data, String url) async {
    final dio = Dio();

    if (kDebugMode) {
      print(url);
      print(data);
    }

    try {
      var response = await dio.post(url,
          data: data);
      outputData =await responseHandler(response);
    } on DioError catch (e) {
      if (e.response != null &&
          Utils().isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['Data'];
        outputData.message = e.response!.data['Message'];
        outputData.isSuccess = e.response!.data['IsSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    } on RequestTimeOut {
      RequestTimeOut('');
    }
    if (kDebugMode) {
      print(outputData);
    }
    return outputData;
  }

  @override
  Future postApiWithToken(data, String url) async {

    final dio = Dio();

    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic tokens = await UserPreference().getToken();
    try {
      if (tokens != null) {

        var response = await dio.post(url,
            data: data, options: Options(headers: {
              'Content-Type' : 'application/json',
              'Authorization': 'bearer ' + tokens
            },));
        outputData =await responseHandler(response);
      } else {
        Utils.toastMessage("Token is Null");
      }
    }on DioError catch (e) {
      if (e.response != null &&
          Utils().isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['Data'];
        outputData.message = e.response!.data['Message'];
        outputData.isSuccess = e.response!.data['IsSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    } on RequestTimeOut {
      RequestTimeOut('');
    };
    return outputData;
  }

  @override
  Future postImageApiWithToken(data, String url) async {

    final dio = Dio();

    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic tokens = await UserPreference().getToken();
    try {
      if (tokens != null) {

        var response = await dio.post(url,
            data: data, options: Options(headers: {
              'content-type': 'multipart/form-data',
              'Authorization': 'bearer ' + tokens
            },));
        outputData =await responseHandler(response);
      } else {
        Utils.toastMessage("Token is Null");
      }
    }on DioError catch (e) {
      if (e.response != null &&
          Utils().isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['Data'];
        outputData.message = e.response!.data['Message'];
        outputData.isSuccess = e.response!.data['IsSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    } on RequestTimeOut {
      RequestTimeOut('');
    };
    return outputData;
  }

  Future<OutputHandler> responseHandler(Response response) async {
    debugPrint("Status Code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return OutputHandler(
        message: response.data['Message'],
        data: response.data['Data'],
        isSuccess: true,
        status: 200,
      );
    } else {
      int finder = errorOutputs
          .indexWhere((element) => element['Status'] == response.statusCode);
      if (finder == -1) {
        return OutputHandler(
          message: 'Unhandled, Internal Server Error!',
          data: 0,
          isSuccess: false,
          status: 500,
        );
      } else {
        var output = errorOutputs[finder];
        return OutputHandler(
          message: output["Message"],
          data: 0,
          isSuccess: false,
          status: output["Status"],
        );
      }
    }
  }

}
