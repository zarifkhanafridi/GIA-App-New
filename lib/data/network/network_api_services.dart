import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:academy/data/app_exceptions.dart';
import 'package:academy/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(
      {required String url, required bool isHeaderRequired}) async {
    if (kDebugMode) {
      print(url);
    }

    try {
      dynamic responseJson;
      if (isHeaderRequired == true) {
        String token = Hive.box('userBox').get('token').toString();
        final String Imei = Hive.box('userBox').get('imei') ?? '';
        final String AppVersion = Hive.box('userBox').get('appVersion') ?? '';

        log("imei is ....$Imei");
        log("AppVersion is ....$AppVersion");
        // creating header for post api
        final headerMap = {
          "Accept": "application/json",
          "Authorization": 'Bearer $token',
          "device_imei": '$Imei',
          "version": '$AppVersion',
        };
        log(token);

        final response = await http
            .get(Uri.parse(url), headers: headerMap)
            .timeout(const Duration(seconds: 30));
        responseJson = returnResponse(response);
        print("responseJson:  " + responseJson.toString());
        return responseJson;
      } else {
        final String Imei = Hive.box('userBox').get('imei') ?? '';
        final String AppVersion = Hive.box('userBox').get('appVersion') ?? '';
        final headerMap = {
          "Accept": "application/json",
          "device_imei": '$Imei',
          "version": '$AppVersion',
        };

        final response = await http
            .get(Uri.parse(url), headers: headerMap)
            .timeout(const Duration(seconds: 30));
        responseJson = returnResponse(response);

        return responseJson;
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
  }

  @override
  Future<dynamic> postApi(
      {var data,
      required String url,
      required bool isHeaderRequired,
      bool? isContentType}) async {
    dynamic responseJson;
    final String Imei = Hive.box('userBox').get('imei') ?? '';
    final String AppVersion = Hive.box('userBox').get('appVersion') ?? '';

    log("imei is ....$Imei");
    log("AppVersion is ....$AppVersion");

    try {
      if (isHeaderRequired) {
        String token = Hive.box('userBox').get('token').toString();

        // creating header for post api
        if (isContentType == true) {
          final headerMap = {
            "content-type": "application/json",
            "Authorization": 'Bearer $token',
            "device_imei": '$Imei',
            "version": '$AppVersion',
          };
          // log(headerMap.length.toString());
          log(token);
          var myData = jsonEncode(data);
          log(myData);
          print(myData.length);
          // log(url.toString());
          final response = await http
              .post(
                Uri.parse(url),
                body: myData,
                headers: headerMap,
              )
              .timeout(const Duration(seconds: 10));

          responseJson = returnResponse(response);
        } else {
          final headerMap = {
            "Accept": "application/json",
            "Authorization": 'Bearer $token',
            "device_imei": "$Imei",
            "version": '$AppVersion',
          };
          log(token);

          // log(url.toString());
          print(data);
          final response = await http
              .post(
                Uri.parse(url),
                body: data,
                headers: headerMap,
              )
              .timeout(const Duration(seconds: 10));
          print('*********************** Response Start *********************');
          print(response.body);
          print('*********************** Response End *********************');

          responseJson = returnResponse(response);
        }
      } else {
        log(data.toString());
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "device_imei": "$Imei",
            "version": '$AppVersion',
          },
        ).timeout(const Duration(seconds: 10));
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future putApi(
      {required data,
      required String url,
      required bool isHeaderRequired}) async {
    dynamic responseJson;

    try {
      if (isHeaderRequired) {
        String token = Hive.box('userBox').get('token').toString();

        // creating header for post api
        final headerMap = {
          "Accept": "application/json",
          "Authorization": 'Bearer $token'
        };
        log(token);
        // log(data.toString());
        // log(url.toString());
        final response = await http
            .put(
              Uri.parse(url),
              body: data,
              headers: headerMap,
            )
            .timeout(const Duration(seconds: 10));

        responseJson = returnResponse(response);
      } else {
        log(data.toString());
        final response = await http.put(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ).timeout(const Duration(seconds: 10));
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 422:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server ${response.statusCode}   ${jsonDecode(response.body)}');
    }
  }
}
