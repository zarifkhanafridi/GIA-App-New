import 'dart:developer';

import 'package:academy/View/commonPage/forgot_pin.dart';
import 'package:academy/ViewModel/controllers/forgot_password_controller.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/components/primarytextfield.dart';
import 'package:academy/res/typography.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'background.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({super.key});

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final formKey = GlobalKey<FormState>();
  String? key;
  final nameController = TextEditingController();

  // Initialize the ForgotPasswordController
  final ForgotPasswordController _forgotPasswordController =
      Get.put(ForgotPasswordController());

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
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Forgot Password",
                      style: CustomStyle.textBold24,
                    ),
                  ),
                  SizedBox(height: 56.h),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/reset-password.png",
                      height: 150.h,
                    ),
                  ),
                  SizedBox(height: 45.h),
                  FadeIn(
                    child: Text(
                      'Email'.tr,
                      style: CustomStyle.textMedium14.copyWith(
                        color: AppColors.kDarkBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  PrimaryTextField(
                    hintColor: Colors.blueGrey,
                    enabledBorder: AppColors.kPalePink,
                    focusedBorder: AppColors.kDarkBlue,
                    textInputAction: TextInputAction.next,
                    controller: nameController,
                    styleColor: AppColors.blackColor,
                    hintText: 'enter your email'.tr,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    prefixIcon: FadeIn(
                      child: Icon(
                        CupertinoIcons.person,
                        color: AppColors.darkGreyColor,
                        size: 20.sp,
                      ),
                    ),
                    validator: (val) {
                      final trimmedVal = val?.trim() ?? '';
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      if (trimmedVal.isEmpty) {
                        return 'Field is empty'.tr;
                      } else if (!emailRegex.hasMatch(trimmedVal)) {
                        // This should be '!' to check for invalid email format
                        return 'Invalid email format'.tr;
                      } else if (trimmedVal.length > 30) {
                        return 'nameTooLong'.tr;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
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
                                    await _forgotPasswordController
                                        .sendResetEmail(
                                            nameController.text.trim());
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
                                  'Submit'.tr,
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
                  SizedBox(height: 66.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
