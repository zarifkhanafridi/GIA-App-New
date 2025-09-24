import 'package:academy/View/commonPage/Login/login_screen.dart';
import 'package:academy/View/commonPage/forgot_pin.dart';
import 'package:academy/View/commonPage/reset_password.dart';
import 'package:academy/repositories/forgot_password.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:academy/util/utils.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordRepository _repository = ForgotPasswordRepository();

  var isLoading = false.obs; // Observable to track loading state
  var errorMessage = ''.obs; // Observable to track error messages
  var successMessage = ''.obs; // Observable to track success messages

  // Method to send reset email
  Future<void> sendResetEmail(String email) async {
    try {
      isLoading.value = true; // Start loading
      errorMessage.value = ''; // Reset previous errors
      successMessage.value = ''; // Reset previous success message

      final response = await _repository.sendResetEmail(email);
      if (response['success'] == true) {
        successMessage.value = response['message'];
        fluttersToast(
            msg: successMessage.value,
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        Get.to(() => ForgotPin()); // Navigate to ForgotPin screen
      } else {
        errorMessage.value = response['message'];
        fluttersToast(
            msg: errorMessage.value,
            bgColor: AppColors.kRed,
            textColor: AppColors.whiteColor);
      }
    } catch (error) {
      errorMessage.value =
          "Failed to send reset email."; // Generic error message
      fluttersToast(
          msg: errorMessage.value,
          bgColor: AppColors.kRed,
          textColor: AppColors.whiteColor);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Method to verify reset code
  Future<void> verifyResetCode(String code) async {
    try {
      isLoading.value = true; // Start loading
      errorMessage.value = ''; // Reset previous errors
      successMessage.value = ''; // Reset previous success message

      final response = await _repository.verifyResetCode(code);
      if (response['success'] == true) {
        successMessage.value = response['message'];
        fluttersToast(
            msg: "Otp is successfully submitted",
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        Get.to(() => ResetPassword(
            code: verifyCode(code: code))); // Navigate to ResetPassword screen
      } else {
        errorMessage.value = response['message'];
        fluttersToast(
            msg: errorMessage.value,
            bgColor: AppColors.kRed,
            textColor: AppColors.whiteColor);
      }
    } catch (error) {
      errorMessage.value =
          "Failed to verify reset code."; // Generic error message
      fluttersToast(
          msg: errorMessage.value,
          bgColor: AppColors.kRed,
          textColor: AppColors.whiteColor);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  /// obsecure icon in reset password screen
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Method to reset the password
  Future<void> resetPassword(
      String password, String newPassword, String code) async {
    try {
      isLoading.value = true; // Start loading
      errorMessage.value = ''; // Reset previous errors
      successMessage.value = ''; // Reset previous success message

      final response =
          await _repository.resetPassword(password, newPassword, code);
      if (response['success'] == true) {
        successMessage.value = response['message'].isEmpty
            ? 'Password has been successfully reset.' // Fallback message
            : response['message'];
        fluttersToast(
            msg: successMessage.value,
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        Get.to(() =>
            LoginPage()); // Navigate to LoginPage after successful password reset
      } else {
        errorMessage.value = response['message'] ??
            'An error occurred'; // Handle API error message
        fluttersToast(
            msg: errorMessage.value,
            bgColor: AppColors.kRed,
            textColor: AppColors.whiteColor);
      }
    } catch (error) {
      errorMessage.value = "Failed to reset password."; // Generic error message
      fluttersToast(
          msg: errorMessage.value,
          bgColor: AppColors.kRed,
          textColor: AppColors.whiteColor);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}

class verifyCode {
  final String code;

  verifyCode({required this.code});
}
