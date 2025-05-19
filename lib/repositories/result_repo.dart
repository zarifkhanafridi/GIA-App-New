import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class ResultRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> myResultsCourses() async {
    try {
      String url = myResultsCourseApi;
      log(myResultsCourseApi);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  result repo side :' + e.toString());
    }
  }

  Future<dynamic> myResultsTests({required var data}) async {
    try {
      String url = myResultsTestsApi;
      log(url);
      log(data.toString());
      dynamic response = await _apiService.postApi(
          url: url, isHeaderRequired: true, data: data);
      return response;
    } catch (e) {
      log('error:  result repo side :' + e.toString());
    }
  }

  Future<dynamic> myFinalResults({required var data}) async {
    try {
      String url = myFinalResultsApi;
      log(url);
      log(data.toString());
      dynamic response = await _apiService.postApi(
          url: url, isHeaderRequired: true, data: data);
      return response;
    } catch (e) {
      log('error:  result repo side :' + e.toString());
    }
  }
}
