import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class GetMyCoursesRepository {
  final _apiService = NetworkApiServices();
  Future<dynamic> getMyCoursesListMethod() async {
    try {
      String url = getMyCourseApi;
      log(getMyCourseApi);
      print(getMyCourseApi);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  getMyCourses side :' + e.toString());
    }
  }

  Future<dynamic> getCourseByIdMethod({required var data}) async {
    try {
      String url = getCourseByIdApi;
      log(getCourseByIdApi);
      dynamic response = await _apiService.postApi(
          url: url, isHeaderRequired: true, data: data);
      return response;
    } catch (e) {
      log('error:  getMyCourses side :' + e.toString());
    }
  }

  Future<dynamic> getCourseAlbumsMethod({required var data}) async {
    try {
      String url = getCourseAlbumsApi;
      log(getCourseAlbumsApi);
      print(getCourseAlbumsApi);
      dynamic response = await _apiService.postApi(
          url: url, isHeaderRequired: true, data: data);
      return response;
    } catch (e) {
      log('error:  getMyCourses side :' + e.toString());
    }
  }

  Future<dynamic> getCourseVideosMethod({required var data}) async {
    try {
      String url = getCourseVideosApi;
      log(url);
      dynamic response = await _apiService.postApi(
          url: url, isHeaderRequired: true, data: data);
      return response;
    } catch (e) {
      log('error:  getMyCourses side :' + e.toString());
    }
  }Future<dynamic> getFeedbackMethod({required String id}) async {
    try {
      String url = getFeedBackApi+"?course_id=$id";
      log(url);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  getMyCourses side :' + e.toString());
    }
  }
   Future<dynamic> postFeedbackMethod({required var data}) async {
    try {
      String url = getFeedBackPostApi;
      log(url);
      dynamic response = await _apiService.postApi(
          url: url, isHeaderRequired: true, data: data);
      return response;
    } catch (e) {
      log('error:  getMyCourses repo side :' + e.toString());
    }
  }
}
