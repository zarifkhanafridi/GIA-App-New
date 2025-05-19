import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class PaymentRepository {
  final _apiService = NetworkApiServices();
  Future<dynamic> getPaymentMethod() async {
    try {
      String url = myPaymentsApi;
      log(myPaymentsApi);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  payment repo side :' + e.toString());
    }
  }

  Future<dynamic> userCurrentBalanceApi() async {
    try {
      String url = myWalletApi;
      log(myWalletApi);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error:  payment repo side :' + e.toString());
    }
  }
}
