import 'dart:developer';

import 'package:academy/ViewModel/controllers/auth_controller.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/components/primarytextfield.dart';
import 'package:academy/res/icons.dart';
import 'package:academy/res/images_urls.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:academy/View/commonPage/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:academy/theme/colors/light_colors.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<Body> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  String iconPassword = AppIcons.eyeIcons;
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Background(
      isAuth: false,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 12.h),
              Image.asset(
                ImagePath.logoImage,
                height: 240.h,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 71.w,
                        top: 10.h,
                      ),
                      child: FadeInDown(
                        child: Text(
                          'Login'.tr,
                          style: CustomStyle.textBold36.copyWith(
                            color: AppColors.kDarkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    FadeIn(
                      child: Text(
                        'Email'.tr,
                        style: CustomStyle.textMedium14
                            .copyWith(color: AppColors.kDarkBlue),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(
                        styleColor: Colors.blueGrey,
                        hintColor: Colors.black12,
                        enabledBorder: AppColors.kPalePink,
                        focusedBorder: AppColors.kDarkBlue,
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        hintText: 'enter email'.tr,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FadeIn(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              AppIcons.emailIcon,
                              color: AppColors.kDarkBlue,
                              width: 12.w,
                              height: 12.h,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          }
                          //  else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                          //     .hasMatch(val)) {
                          //   return 'validEmail'.tr;
                          // }
                          return null;
                        }),
                    FadeIn(
                      child: Text(
                        'password'.tr,
                        style: CustomStyle.textMedium14
                            .copyWith(color: AppColors.kDarkBlue),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(
                      hintColor: Colors.black12,
                      enabledBorder: AppColors.kPalePink,
                      focusedBorder: AppColors.kDarkBlue,
                      textInputAction: TextInputAction.next,
                      styleColor: Colors.blueGrey,
                      controller: passwordController,
                      hintText: 'enter password'.tr,
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.text,
                      prefixIcon: FadeIn(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            AppIcons.lockIcons,
                            color: AppColors.kDarkBlue,
                            width: 12.w,
                            height: 12.h,
                          ),
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscurePassword = !obscurePassword;

                            if (obscurePassword) {
                              iconPassword = AppIcons.eyeIcons;
                            } else {
                              iconPassword = AppIcons.eyeOpenIcon;
                            }
                          });
                        },
                        child: FadeIn(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              iconPassword,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.kDarkBlue,
                            ),
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'validatorText'.tr;
                        }
                        if (val.length < 8) {
                          return 'charactersPassHintText'.tr;
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.all(8.0).copyWith(top: 0, left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/forgot-password.png',
                            width: 24.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouteName.forgetPage);
                            },
                            child: Text(
                              'Forget Password?',
                              style: CustomStyle.textSemiBold12
                                  .copyWith(color: AppColors.kDarkBlue),
                            ),
                          )
                        ],
                      ),
                    ),
                    Obx(() => FadeInUp(
                          from: 12,
                          duration: const Duration(milliseconds: 800),
                          child: PrimaryButton(
                            elevation: 0,
                            onTap: authController.isLoading.value
                                ? () {
                                    log('message');

                                  }
                                : () async {
                                    await authController.loginMethod(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                                  },
                            childWidget: authController.isLoading.value
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Center(
                                      child: CircularProgressIndicator.adaptive(
                                        backgroundColor: Colors.transparent,
                                        strokeWidth:
                                            2.0, // Adjust the thickness of the indicator

                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Login'.tr,
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
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteName.signUpPage);
                },
                child: Text(
                  "don't have Account? SignUp",
                  style: CustomStyle.textSemiBold12
                      .copyWith(color: AppColors.kDarkBlue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
