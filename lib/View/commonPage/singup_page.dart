import 'dart:developer';
import 'package:academy/ViewModel/controllers/auth_controller.dart';
import 'package:academy/ViewModel/services/image_picker.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/components/primarytextfield.dart';
import 'package:academy/res/icons.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final fNameController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String iconPassword = AppIcons.eyeIcons;
  String iconCPassword = AppIcons.eyeIcons;
  bool obscurePassword = true;
  bool obscureCPassword = true;
  String countryCode = '965';
  String countryEmoji = '🇰🇼';
  final service = ImagePickerService();
  String _selectedGender = 'male';
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 24.h),
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
                          'Sign Up'.tr,
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
                        'User Name'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.darkGreyColor,
                        ),
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
                        controller: nameController,
                        hintText: 'enter your name'.tr,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.person,
                            color: AppColors.kDarkBlue,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          } else if (val.length > 30) {
                            return 'nameTooLong'.tr;
                          }
                          return null;
                        }),
                    FadeIn(
                      child: Text(
                        'Father Name'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.darkGreyColor,
                        ),
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
                        controller: fNameController,
                        hintText: 'enter your Father Name'.tr,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.person,
                            color: AppColors.kDarkBlue,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          } else if (val.length > 30) {
                            return 'nameTooLong'.tr;
                          }
                          return null;
                        }),
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
                        'Create a password'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.darkGreyColor,
                        ),
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
                            width: 12.w,
                            height: 12.h,
                            color: AppColors.kDarkBlue,
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
                              color: AppColors.darkGreyColor,
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
                    FadeIn(
                      child: Text(
                        'Confirm Password'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.darkGreyColor,
                        ),
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
                      controller: passwordConfirmController,
                      hintText: ' enter Confirm Password'.tr,
                      obscureText: obscureCPassword,
                      keyboardType: TextInputType.text,
                      prefixIcon: FadeIn(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            AppIcons.lockIcons,
                            width: 12.w,
                            height: 12.h,
                            color: AppColors.kDarkBlue,
                          ),
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureCPassword = !obscureCPassword;

                            if (obscureCPassword) {
                              iconCPassword = AppIcons.eyeIcons;
                            } else {
                              iconCPassword = AppIcons.eyeOpenIcon;
                            }
                          });
                        },
                        child: FadeIn(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              iconCPassword,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.darkGreyColor,
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
                    Text(
                      'Phone number',
                      style: CustomStyle.textMedium14.copyWith(
                        color: AppColors.darkGreyColor,
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
                        controller: phoneController,
                        hintText: 'enter your phone'.tr,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.phone,
                            color: AppColors.kDarkBlue,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          } else if (val.length > 30) {
                            return 'nameTooLong'.tr;
                          }
                          return null;
                        }),
                    Text(
                      'Gender',
                      style: CustomStyle.textMedium14.copyWith(
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: AppColors.primaryColor))),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        value: _selectedGender,
                        dropdownColor: AppColors.whiteColor,
                        isExpanded: true,
                        iconEnabledColor: AppColors.primaryColor,
                        iconDisabledColor: AppColors.primaryColor,
                        underline: Divider(
                          color: AppColors.primaryColor,
                          thickness: 4,
                          height: 2,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                        hint: Text('Gender'),
                        items: <String>['male', 'female', 'other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(() => FadeInUp(
                          from: 20,
                          duration: const Duration(milliseconds: 800),
                          child: PrimaryButton(
                            elevation: 0,
                            onTap: authController.isLoading.value
                                ? () {
                                    // authController.setIsLoading(false);
                                    log('message');
                                  }
                                : () async {
                                    authController.registerMethod(
                                      gender: _selectedGender,
                                      fName: fNameController.text.trim(),
                                      email: emailController.text
                                          .trim()
                                          .toString(),
                                      password: passwordController.text
                                          .trim()
                                          .toString(),
                                      confirmPassword: passwordConfirmController
                                          .text
                                          .trim()
                                          .toString(),
                                      name:
                                          nameController.text.trim().toString(),
                                      phoneNumber: phoneController.text
                                          .trim()
                                          .toString(),
                                    );
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
                                                AppColors.whiteColor),
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Create an Account',
                                    style: CustomStyle.textSemiBold12.copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            bgColor: AppColors.kDarkBlue,
                            borderRadius: 8.r,
                            height: 50.h,
                            width: 327.w,
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0)
                    .copyWith(top: 0, left: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/forgot-password.png',
                      width: 25.w,
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0)
                          .copyWith(top: 34.h, right: 8.w),
                      child: InkWell(
                        onTap: () {
                          Get.offNamed(RouteName.loginPage);
                        },
                        child: Text(
                          'Already account?',
                          style: CustomStyle.textRegular15
                              .copyWith(color: AppColors.kDarkBlue),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
