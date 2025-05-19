import 'dart:developer';

import 'package:academy/data/network/network_api_services.dart';
import 'package:academy/res/app_urls.dart';

 
class AuthRepository {
  final _apiService = NetworkApiServices();
  Future<dynamic> signInMethod({required var data}) async {
    try {
      String url = loginApi;
      log(loginApi);
      dynamic response = await _apiService.postApi(
          data: data, url: url, isHeaderRequired: false);
      return response;
    } catch (e) {
      log('error: authRepo side :' + e.toString());
    }
  }

  Future<dynamic> signUpMethod({required var data}) async {
    try {
      String url = registerApi;
      log(registerApi);
      dynamic response = await _apiService.postApi(
          data: data, url: url, isHeaderRequired: false);
      return response;
    } catch (e) {
      log('error: authRepo side :' + e.toString());
    }
  }

  Future<dynamic> forgetMethod({required var data}) async {
    try {
      String url = forgotPasswordApi;
      log(forgotPasswordApi);
      dynamic response = await _apiService.postApi(
          data: data, url: url, isHeaderRequired: false);
      return response;
    } catch (e) {
      log('error: authRepo side :' + e.toString());
    }
  }

  Future<dynamic> resendCodeMethod({required var data}) async {
    try {
      String url = resendCodeApi;
      log(resendCodeApi);
      dynamic response = await _apiService.postApi(
          data: data, url: url, isHeaderRequired: false);
      return response;
    } catch (e) {
      log('error: authRepo side :' + e.toString());
    }
  }
   Future<dynamic> resetPasswordMethod({required var data}) async {
    try {
      String url = resetPasswordApi;
      log(resetPasswordApi);
      dynamic response = await _apiService.postApi(
          data: data, url: url, isHeaderRequired: false);
      return response;
    } catch (e) {
      log('error: authRepo side :' + e.toString());
    }
  }
  
   Future<dynamic> updatePasswordMethod({required var data}) async {
    try {
      String url = ProfileUpdatePasswordApi;
      log(ProfileUpdatePasswordApi);
      dynamic response = await _apiService.putApi(
          data: data, url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error: authRepo side :' + e.toString());
    }
  }
  Future<dynamic> logout( ) async {
    try {
      String url = logoutApi;
      log(logoutApi);
      dynamic response = await _apiService.postApi(
          url: url, isHeaderRequired: true);
      return response;
    } catch (e) {
      log('error: authRepo side :' + e.toString());
    }
  }
}
