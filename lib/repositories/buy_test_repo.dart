// import 'dart:convert';
import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class BuyTestRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> getBuyTestApiMethod() async {
    try {
      String url = getBuyTestApi;
      log(url);
      dynamic response = await _apiService.postApi(
        url: url,
        isHeaderRequired: true,
      );
      print('response in  getBuyTestApiMethod() ');
      print(response);
      return response;
    } catch (e) {
      log('error: buy  test repo side :' + e.toString());
    }
  }
}
