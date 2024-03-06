import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_track_live/.data/app_exceptions.dart';

import 'base_api_services.dart';
import 'package:http/http.dart' as http;
import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi(String url) async {
    /*if (kDebugMode) {
      print(" \n \n NetworkApiServices Print  Url :     $url \n \n ");
    }*/
    dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("   000 \n \n NetworkApiServices Print  Url :     $url \n ");
      print(" NetworkApiServices Print  Response:     ${jsonResponse['documents']} \n \n   111");
    }
    return jsonResponse;
  }

  @override
  Future postApi(dynamic data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic jsonResponse;
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data)).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlExceptions('');
      default:
        throw FetchDataExceptions("Error occurred while communicating with server${response.statusCode}");
    }
  }
}
