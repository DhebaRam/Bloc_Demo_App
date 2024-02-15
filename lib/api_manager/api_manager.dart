// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'api_model.dart';

enum Method { post, get, delete, put, patch }

class APIManager {
  static final APIManager apiManagerInstance = APIManager._internal();
  factory APIManager() => apiManagerInstance;
  APIManager._internal();


  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  Future<ApiResponseModel> request(
    String webUrl,
    Method method,
    Map<String, dynamic> param,
  ) async {
    log(webUrl);
    log("Api URL .. $webUrl");
    log("Api param .. $param");
    final bool connectionStatus = await _checkConnection();
    late ApiResponseModel apiResponseModel;
    late ErrorModel error;
    if (!connectionStatus) {
      error = ErrorModel(
        "No Internet",
        "No internet connection.",
        503,
      );
      Fluttertoast.showToast(
          msg: 'No internet connection.'
              .toString()
              .replaceFirst("HttpException: ", "")
              .replaceAll("\\", ''));
      return apiResponseModel = ApiResponseModel(null, error, false);
    }

    Dio dio = Dio();
    late Response response;
    Map<String, String> headers = {};
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    log(token.toString());
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) headers['Authorization'] = "Bearer $token";
    headers["Content-Type"] = "application/json";
    headers["Accept-Language"] = preferences.getString("lang") ?? "en";
    String? encodedData = json.encode(param);
    log('encodedData ---> $encodedData');
    log("header... $headers");
    log(method.toString());
    try {
      if (method == Method.get) {
        log("Get API Calling");
        response = await dio.get(webUrl,
            options: Options(
              headers: headers,
            ),
            queryParameters: param);
        log(response.toString());
      } else if (method == Method.post) {
        log('Post Method Calling----->');
        response = await dio.post(webUrl,
            options: Options(headers: headers), data: encodedData);
        log('response.... ${response.data}');
        log(response.toString());
      } else if (method == Method.put) {
        response = await dio.put(webUrl,
            options: Options(headers: headers), data: encodedData);
      } else if (method == Method.delete) {
        response =
            await dio.delete(webUrl, options: Options(headers: headers));
      } else if (method == Method.patch) {
        response = await dio.patch(webUrl,
            options: Options(headers: headers), data: encodedData);
      }

      final responseData = response.data;

      if (response.statusCode! >= 200 && response.statusCode! < 401) {
        if (response.data.isNotEmpty) {
          // if (responseData['statusCode'] == 200 ||
          //     responseData['status'] == 200 ||
          //     responseData['responsecode'] == 200 && responseData['status']) {
            apiResponseModel = ApiResponseModel(responseData, null, true);
          // } else {
          //   _error = ErrorModel(
          //     "Error",
          //     "${responseData['message']}",
          //     responseData['responsecode'],
          //   );
          //   apiResponseModel = ApiResponseModel(null, _error, false);
          // }
        }
      } else if (response.statusCode == 401) {
        // if (responseData['message'] == "jwt expired" ||
        //     responseData['message'] == "wt malformed") {
        //   _error = ErrorModel(
        //     "Unauthorized",
        //     "Token Expired, Please login again.",
        //     responseData['statusCode'],
        //   );
        //   apiResponseModel = ApiResponseModel(null, _error, false);
        // }
        error = ErrorModel(
          "Unauthorized",
          "Token Expired, Please login again.",
          responseData['statusCode'],
        );
        apiResponseModel = ApiResponseModel(null, error, false);
      } else if (response.statusCode == 500) {
        apiResponseModel = ApiResponseModel(
            null,
            ErrorModel(
              '',
              'Internal server error',
              responseData['statusCode'],
            ),
            false);
      } else {
        if (response.data.isNotEmpty) {
          error = ErrorModel(
            "",
            responseData['message'],
            responseData['responsecode'],
          );
          apiResponseModel = ApiResponseModel(null, error, false);
        } else {
          error = ErrorModel(
            "Something went wrong!",
            "Looks like there was an error in reaching our servers. Press Refresh to try again or come back after some time.",
            504,
          );
          apiResponseModel = ApiResponseModel(null, error, false);
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        // Handle server error response
        log('Server error...: $e');
        log('Server error...: ${e.response!.statusCode}');
        log('Server error: ${e.response!.statusMessage}');
        log('Error Model... ${e.response!.statusCode}');
        error = ErrorModel(
          "Something went wrong!",
          e.response!.data['message'],
          e.response!.statusCode!,
        );
        apiResponseModel = ApiResponseModel(null, error, false);
      } else {
        // log('Network error: ${e.message}');
        // log('Server error: ${e.response!.statusCode}');
        // log('Server error: ${e.response!.statusMessage}');
        // // Handle network error
        // log('Network error: ${e.message}');
        error = ErrorModel(
          "Something went wrong!",
          "Something went wrong. Please try again.",
          e.response?.statusCode ?? 400,
        );
        apiResponseModel = ApiResponseModel(null, error, false);
      }
    } catch (e) {
      log("asjdajshdfsj");
      log("$e");
      error = ErrorModel(
        "Something went wrong!",
        "Something went wrong. Please try again.",
        504,
      );
      apiResponseModel = ApiResponseModel(null, error, false);
    }
    log('Return Api Response.... ${apiResponseModel.data}');
    log('Return Api Response.... $apiResponseModel');
    return apiResponseModel;
  }

  Future<ApiResponseModel> multipartRequest(
      String webUrl,
      List<FileInfo> files,
      List<FileInfoInt>? filesInt,
      Method method,
      Map<String, dynamic> param,
      {bool byteData = false,
      List<int>? imageData,
      path,
      name}) async {
    var status = await _checkConnection();
    late ErrorModel error0;
    ApiResponseModel apiResponseModel;
    if (status != true) {
      var error =
          ErrorModel("No Internet", "Check Your Network Connection", 500);
      return ApiResponseModel("", error, false);
    }
    log(webUrl);
    Dio dio = Dio();
    late Response response;
    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({});
    MultipartFile multipartFile;
    if (byteData) {
      for (var item in filesInt!) {
        multipartFile = MultipartFile.fromBytes(
          item.file,
          filename: "${item.name}.${item.ext}",
          contentType: MediaType(
              "${lookupMimeType(item.path, headerBytes: item.file)}",
              "${lookupMimeType(item.path)}"),
        );
        formData.files.add(MapEntry(item.key, multipartFile));
      }
    } else {
      for (var item in files) {
        multipartFile = MultipartFile.fromBytes(
          byteData ? imageData! : File(item.file.path).readAsBytesSync(),
          filename: "${item.name}.${item.ext}",
          contentType: MediaType(
              "${lookupMimeType(item.file.path, headerBytes: item.file.readAsBytesSync())}",
              "${lookupMimeType(item.file.path)}"),
        );

        formData.files.add(MapEntry(item.key, multipartFile));
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) headers['Authorization'] = "Bearer $token";
    headers["Content-Type"] = "application/json";
    headers["Accept-Language"] = prefs.getString("lang") ?? "en";
    formData.fields
        .addAll(param.entries.map((e) => MapEntry(e.key, e.value.toString())));

    try {
      if (method == Method.post) {
        response = await dio.post(webUrl,
            options: Options(headers: headers), data: formData);
      } else if (method == Method.patch) {
        response = await dio.patch(webUrl,
            options: Options(headers: headers), data: formData);
      } else if (method == Method.put) {
        response = await dio.put(webUrl,
            options: Options(headers: headers), data: formData);
      }

      log(response.toString());
      log(response.data);
      log(response.statusCode.toString());
      log(response.statusMessage.toString());
      log(response.data);
      log("NAVagvdhg" 'message');
      final responseData = response.data;
      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        var data = response.data;
        log(data.toString());
        if ((data['statusCode'] == 200 && data['statusCode'] < 300) ||
            responseData['responsecode'] == 200) {
          return apiResponseModel = ApiResponseModel(data, null, true);
        } else {
          String error = data["message"];
          ErrorModel apiResponse = ErrorModel("", error, data['statusCode']);
          return apiResponseModel = ApiResponseModel(null, apiResponse, false);
        }
      } else if (response.statusCode == 500) {
        ErrorModel apiResponse = ErrorModel(
          "Something went wrong!",
          "Looks like there was an error in reaching our servers. Press Refresh to try again or come back after some time.",
          504,
        );
        return apiResponseModel = ApiResponseModel(null, apiResponse, false);
      } else {
        var errorData = json.decode(response.data);
        String error = errorData["message"];
        ErrorModel apiResponse = ErrorModel("", error, errorData['statusCode']);
        return apiResponseModel = ApiResponseModel(null, apiResponse, false);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        // Handle server error response
        log(e.response.toString());
        error0 = ErrorModel(
          "Something went wrong!",
          e.response?.data['message'] ?? "Something went wrong!",
          e.response!.statusCode!,
        );
        return apiResponseModel = ApiResponseModel(null, error0, false);
      } else {
        error0 = ErrorModel(
          "Something went wrong!",
          "Something went wrong. Please try again.",
          e.response!.statusCode!,
        );
        return apiResponseModel = ApiResponseModel(null, error0, false);
      }
    } catch (e) {
      log("asjdajshdfsj");
      log("$e");
      error0 = ErrorModel(
        "Something went wrong!",
        "Something went wrong. Please try again.",
        504,
      );
      return apiResponseModel = ApiResponseModel(null, error0, false);
    }
  }
}
