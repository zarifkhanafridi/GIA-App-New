import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/forgot_password_controller.dart';
import 'package:academy/ViewModel/services/api_service.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/components/primarytextfield.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/util/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  final verifyCode code;

  ResetPassword({required this.code});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ForgotPasswordController _forgotPasswordController =
      Get.put(ForgotPasswordController());

  // Function to handle reset password logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Forgot Password",
                      style: CustomStyle.textBold24,
                    ),
                  ),
                  SizedBox(height: 45.h),
                  FadeIn(
                    child: Text(
                      'New Password'.tr,
                      style: CustomStyle.textMedium14.copyWith(
                        color: AppColors.kDarkBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => PrimaryTextField(
                      hintColor: Colors.blueGrey,
                      enabledBorder: AppColors.kPalePink,
                      focusedBorder: AppColors.kDarkBlue,
                      textInputAction: TextInputAction.next,
                      controller: passwordController,
                      styleColor: AppColors.blackColor,
                      hintText: 'Enter new password'.tr,
                      obscureText:
                          !_forgotPasswordController.isPasswordVisible.value,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _forgotPasswordController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.darkGreyColor,
                        ),
                        onPressed:
                            _forgotPasswordController.togglePasswordVisibility,
                      ),
                      prefixIcon: FadeIn(
                        child: Icon(
                          CupertinoIcons.lock,
                          color: AppColors.darkGreyColor,
                          size: 20.sp,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Password is required';
                        } else if (val.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  FadeIn(
                    child: Text(
                      'Confirm Password'.tr,
                      style: CustomStyle.textMedium14.copyWith(
                        color: AppColors.kDarkBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => PrimaryTextField(
                      hintColor: Colors.blueGrey,
                      enabledBorder: AppColors.kPalePink,
                      focusedBorder: AppColors.kDarkBlue,
                      textInputAction: TextInputAction.done,
                      controller: confirmPasswordController,
                      styleColor: AppColors.blackColor,
                      hintText: 'Enter confirm password'.tr,
                      obscureText: !_forgotPasswordController
                          .isConfirmPasswordVisible.value,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _forgotPasswordController
                                  .isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.darkGreyColor,
                        ),
                        onPressed: _forgotPasswordController
                            .toggleConfirmPasswordVisibility,
                      ),
                      prefixIcon: FadeIn(
                        child: Icon(
                          CupertinoIcons.lock,
                          color: AppColors.darkGreyColor,
                          size: 20.sp,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Confirm password is required';
                        } else if (val.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(() => FadeInUp(
                        from: 12,
                        duration: const Duration(milliseconds: 800),
                        child: PrimaryButton(
                          elevation: 0,
                          onTap: _forgotPasswordController.isLoading.value
                              ? () {
                                  log('message');
                                }
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    String password = passwordController.text;
                                    String confirmPassword =
                                        confirmPasswordController.text;

                                    // Check if both passwords match
                                    if (password != confirmPassword) {
                                      fluttersToast(
                                          msg: "Password do not matched ",
                                          bgColor: AppColors.kRed,
                                          textColor: AppColors.whiteColor);
                                    } else {
                                      await _forgotPasswordController
                                          .resetPassword(
                                              password.toString(),
                                              confirmPassword.toString(),
                                              widget.code.code);
                                    }
                                    return;
                                  }
                                },
                          childWidget: _forgotPasswordController.isLoading.value
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.transparent,
                                      strokeWidth:
                                          2.0, // Adjust the thickness of the indicator

                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  'Reset'.tr,
                                  style: CustomStyle.textMedium14.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          bgColor: AppColors.kDarkBlue,
                          borderRadius: 8.r,
                          height: 48.h,
                        ),
                      )),
                  SizedBox(height: 46.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
