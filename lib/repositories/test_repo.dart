import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class TestRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> getAllTestApiMethod(String index) async {
    try {
      String url = getAllTestApi + "/$index";
      log(url);
      print(url);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  test repo side :' + e.toString());
    }
  }

  Future<dynamic> getCourseTestMethod({required String id}) async {
    try {
      var data = {'course_id': id};
      String url = getCourseTestsApi;
      log(url);
      log(data.toString());
      dynamic response = await _apiService.postApi(
          url: url, data: data, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  test Repo side :' + e.toString());
    }
  }

  Future<dynamic> getTestInfoMethod({required String id}) async {
    try {
      var data = {'group_test_id': id};
      String url = testInfoApi;
      log(url);
      log(data.toString());
      dynamic response = await _apiService.postApi(
          url: url, data: data, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  test Repo side :' + e.toString());
    }
  }

  Future<dynamic> getStartTestMethod({required String id}) async {
    try {
      var data = {'group_test_id': id};
      String url = startTestApi;
      log(url);
      log(data.toString());
      dynamic response = await _apiService.postApi(
          url: url, data: data, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  test Repo side :' + e.toString());
    }
  }

  Future<dynamic> getAllTestQuestionsMethod(
      {required String questionId}) async {
    try {
      var data = {'group_test_id': questionId};
      String url = getAllTestQuestionsApi;
      log(url);
      log(data.toString());
      dynamic response = await _apiService.postApi(
          url: url, data: data, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  test Repo side :' + e.toString());
    }
  }

  Future<dynamic> postAllAnswersMethod(
      {required var data, required String testId}) async {
    try {
      String url = postAnswersApi;
      log(url);
      log(data.toString());

      Map<String, dynamic> jsonData = {
        "group_test_id": testId,
        "result": data,
      };
      log((jsonData).toString());
      dynamic response = await _apiService.postApi(
          url: url,
          data: jsonData,
          isHeaderRequired: true,
          isContentType: true);
      return response;
    } catch (e) {
      log('error:  test Repo side :' + e.toString());
    }
  }
}
