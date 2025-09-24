import 'package:academy/data/network/network_api_services.dart';

class ForgotPasswordRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  // API endpoints
  final String _sendEmailUrl = "https://gislamian.pk/api/v1/password/email";
  final String _verifyCodeUrl =
      "https://gislamian.pk/api/v1/password/code/check";
  final String _resetPasswordUrl = "https://gislamian.pk/api/v1/password/reset";

  /// Method to send email to receive reset code
  Future<dynamic> sendResetEmail(String email) async {
    try {
      final data = {
        "email": email,
      };
      final response = await _apiServices.postApi(
        url: _sendEmailUrl,
        data: data,
        isHeaderRequired: false,
      );
      return response;
    } catch (error) {
      rethrow; // Propagate errors to the caller
    }
  }

  /// Method to verify the reset code
  Future<dynamic> verifyResetCode(String code) async {
    try {
      final data = {
        "code": code,
      };
      final response = await _apiServices.postApi(
        url: _verifyCodeUrl,
        data: data,
        isHeaderRequired: false,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  /// Method to reset the password
  Future<dynamic> resetPassword(
      String password, String newPassword, String code) async {
    try {
      final data = {
        "password": password,
        "code": code,
        "password_confirmation": newPassword,
      };
      final response = await _apiServices.postApi(
        url: _resetPasswordUrl,
        data: data,
        isHeaderRequired: false,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
