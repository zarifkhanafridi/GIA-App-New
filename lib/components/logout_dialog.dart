// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:academy/ViewModel/controllers/auth_controller.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/res/icons.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LogOutDialog extends StatelessWidget {
  LogOutDialog({
    Key? key,
  }) : super(key: key);
  AuthController ac = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      titlePadding: EdgeInsets.zero,
      backgroundColor: AppColors.whiteColor,
      content: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.logout,
                  size: 45.sp,
                )),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Want to Logout?'.tr,
              textAlign: TextAlign.center,
              style: CustomStyle.textSemiBold20
                  .copyWith(color: AppColors.kDarkBlue),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Click On The Logout Button If You Really Want to Logout?'.tr,
              textAlign: TextAlign.center,
              style: CustomStyle.textRegular12
                  .copyWith(color: AppColors.kDarkBlue),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() => PrimaryButton(
                  onTap: () async {
                    await ac.logoutMethod().then((value) async {
                      Get.back();
                      Get.back();
                    });
                  },
                  childWidget: ac.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: AppColors.whiteColor,
                          ),
                        )
                      : Text(
                          'Logout'.tr,
                          style: CustomStyle.textSemiBold12.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  bgColor: AppColors.kDarkBlue,
                  borderRadius: 67.r,
                  height: 62.h,
                  elevation: 0,
                ))
          ],
        ),
      ),
    );
  }
}
