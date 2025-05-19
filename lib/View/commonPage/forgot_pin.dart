// import 'package:academy/View/commonPage/background.dart';
// import 'package:academy/View/commonPage/reset_password.dart';
// import 'package:academy/components/primary_button.dart';
// import 'package:academy/res/typography.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:academy/theme/colors/light_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';
//
//
//
// class ForgotPin extends StatefulWidget {
//   const ForgotPin({super.key});
//
//   @override
//   State<ForgotPin> createState() => _ForgotPinState();
// }
//
// class _ForgotPinState extends State<ForgotPin> {
//   final formKey = GlobalKey<FormState>();
//   String? key;
//   final _pinController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Background(
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 22.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text("Check your email and put code  below",style: TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.w700
//                     ),),
//                   ),
//                   SizedBox(height: 90,),
//                   Center(
//                     child: Pinput(
//                       controller: _pinController,  // Controller to manage PIN input
//                       length: 4,  // Number of fields for the PIN input
//                       onChanged: (pin) {
//                         print('Entered PIN: $pin'); // Handle PIN change
//                       },
//                       onCompleted: (pin) {
//                         print('Completed PIN: $pin'); // Handle PIN completion
//                       },
//                       defaultPinTheme: PinTheme(
//                         width: 50,
//                         height: 50,
//                         textStyle: TextStyle(fontSize: 20, color: Colors.black),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.black),
//                         ),
//                         margin: EdgeInsets.symmetric(horizontal: 8)
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 34.h,
//                   ),
//                   FadeInUp(
//                     from: 20,
//                     duration: const Duration(milliseconds: 800),
//                     child: PrimaryButton(
//                       elevation: 0,
//                       onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
//                       },
//                       childWidget: Text(
//                         'Continue'.tr,
//                         style: CustomStyle.textMedium14.copyWith(
//                           color: AppColors.whiteColor,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       bgColor: AppColors.kDarkBlue,
//                       borderRadius: 8.r,
//                       height: 48.h,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 46.h,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/commonPage/reset_password.dart';
import 'package:academy/ViewModel/controllers/forgot_password_controller.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/res/typography.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ForgotPin extends StatefulWidget {
  const ForgotPin({super.key});

  @override
  State<ForgotPin> createState() => _ForgotPinState();
}

class _ForgotPinState extends State<ForgotPin> {
  final formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();

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
                    alignment: Alignment.center,
                    child: Text(
                      "Check your email and put code below",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 90.h),
                  Center(
                    child: Pinput(
                      controller:
                          _pinController, // Controller to manage PIN input
                      length: 4, // Number of fields for the PIN input
                      onChanged: (pin) {
                        print('Entered PIN: $pin'); // Handle PIN change
                      },
                      onCompleted: (pin) {
                        print('Completed PIN: $pin'); // Handle PIN completion
                      },
                      validator: (pin) {
                        // Validate the PIN (must be 4 digits)
                        if (pin == null || pin.isEmpty) {
                          return 'Please enter the PIN'.tr;
                        } else if (pin.length < 4) {
                          return 'PIN must be 4 digits'.tr;
                        } else if (pin.length > 4) {
                          return 'PIN must be exactly 4 digits'.tr;
                        }
                        return null;
                      },
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                  SizedBox(height: 34.h),
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
                                        .verifyResetCode(
                                            _pinController.text.trim());
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
