import 'dart:developer';
import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

class PostInvoiceRepo {
  final _apiService = NetworkApiServices();
  Future<dynamic> postInvoiceMethod(Map<String, String> invoiceDetail) async {
    try {
      String url = postInvoiceApi;
      dynamic response = await _apiService.postApi(
        data: invoiceDetail,
        url: url,
        isHeaderRequired: true,
        // isContentType: true,
      );

      return response;
    } catch (e) {
      log('error:  payment repo side :' + e.toString());
    }
  }
}
