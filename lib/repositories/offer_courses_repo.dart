import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class OfferCourseRepository {
  final _apiService = NetworkApiServices();
  Future<dynamic> coursesOfferMethod() async {
    try {
      String url = dashboardCoursesOfferApi;
      log(dashboardCoursesOfferApi);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error: Courses Offer side :' + e.toString());
    }
  }

  Future<dynamic> getCoursesListMethod({required var data}) async {
    try {
      String url = courseListApi;
      log(courseListApi);
      print(courseListApi);
      dynamic response = await _apiService.postApi(
          data: data, url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  Courses Offer side :' + e.toString());
    }
  }
}
