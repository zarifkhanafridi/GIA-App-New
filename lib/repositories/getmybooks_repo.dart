import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class GetMyBooksRepository {
  final _apiService = NetworkApiServices();
  Future<dynamic> getMyBooksMethod() async {
    try {
      String url = getMyBookApi;
      log(getMyCourseApi);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      log('GetMyBooksMethod() exec');
      print(response);
      return response;
    } catch (e) {
      log('error:  getMyBooks side :' + e.toString());
    }
  }
}
