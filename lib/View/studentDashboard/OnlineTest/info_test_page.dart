import 'dart:developer';

import 'package:academy/ViewModel/controllers/test_controller.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/icons.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InfoTestPage extends StatefulWidget {
  final String id;
  const InfoTestPage({super.key, required this.id});

  @override
  State<InfoTestPage> createState() => _InfoTestPageState();
}

class _InfoTestPageState extends State<InfoTestPage> {
  TestController testInfoController = Get.find<TestController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('getTestInoApi calling');
    testInfoController.getTestInoApi(id: widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 0,
        titlePadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Obx(() => testInfoController.appStatusTestInfo.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : testInfoController.appStatusTestInfo.value == AppStatus.COMPLETED
                ? Container(
                    padding: EdgeInsets.all(12.sp),
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: AppColors.kLandingBgColor,
                        borderRadius: BorderRadius.circular(24.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Text(
                            'Test Info',
                            textAlign: TextAlign.center,
                            style: CustomStyle.textSemiBold20
                                .copyWith(color: AppColors.blackColor),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        InfoRowWidget(
                            title: 'Test Code',
                            value: testInfoController.testInfoModel!.testCode
                                .toString()),
                        SizedBox(
                          height: 15.h,
                        ),
                        InfoRowWidget(
                            title: 'Test Name',
                            value: testInfoController.testInfoModel!.testTitle
                                .toString()),
                        SizedBox(
                          height: 15.h,
                        ),
                        InfoRowWidget(
                            title: 'Total Time',
                            value: testInfoController.testInfoModel!.totalTime
                                    .toString() +
                                " min"),
                        SizedBox(
                          height: 15.h,
                        ),
                        InfoRowWidget(
                            title: 'Test Start Date',
                            value: testInfoController.testInfoModel!.testStart
                                .toString()),
                        SizedBox(
                          height: 15.h,
                        ),
                        InfoRowWidget(
                            title: 'Total Question',
                            value: testInfoController
                                .testInfoModel!.totalQuestion
                                .toString()),
                        SizedBox(
                          height: 15.h,
                        ),
                        InfoRowWidget(
                            title: 'Fee',
                            value: testInfoController.testInfoModel!.fee
                                .toString()),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: PrimaryButton(
                                width: 45.w,
                                height: 45.h,
                                onTap: () {
                                  Get.back();
                                },
                                childWidget: Text(
                                  'Back',
                                  style: CustomStyle.textMedium14.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                bgColor: AppColors.kDarkBlue,
                              ),
                            ),
                            SizedBox(
                              width: 23.w,
                            ),
                            Flexible(
                              child: PrimaryButton(
                                width: 45.w,
                                height: 45.h,
                                onTap: () async {
                                  await testInfoController.testStartApi(
                                      id: widget.id);
                                },
                                childWidget: testInfoController.isStart.value
                                    ? SizedBox(
                                        height: 24.h,
                                        width: 24.w,
                                        child: Center(
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            backgroundColor: Colors.transparent,
                                            strokeWidth: 2.0,
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Start',
                                        style:
                                            CustomStyle.textMedium14.copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                bgColor: AppColors.kDarkBlue,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(34.sp),
                    decoration: BoxDecoration(
                        color: AppColors.kLandingBgColor,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                              AppIcons.balanceIcon,
                              width: 67.w,
                              height: 67.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          'Insufficient Balance'.tr,
                          textAlign: TextAlign.center,
                          style: CustomStyle.textSemiBold20
                              .copyWith(color: AppColors.kDarkBlue),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          'Please Pay Test Fee'.tr,
                          textAlign: TextAlign.center,
                          style: CustomStyle.textRegular12
                              .copyWith(color: AppColors.kDarkBlue),
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        PrimaryButton(
                          width: 50.w,
                          height: 50.h,
                          onTap: () {
                            Get.back();
                          },
                          childWidget: Text(
                            'Back',
                            style: CustomStyle.textMedium14.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          bgColor: AppColors.kDarkBlue,
                        ),
                      ],
                    ),
                  )));
  }
}

class InfoRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const InfoRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: CustomStyle.textBold36.copyWith(
                color: AppColors.kDarkBlue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: CustomStyle.textBold36.copyWith(
                color: AppColors.kDarkBlue,
                fontSize: 10.sp,
                fontWeight: mediumFontWeight),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
