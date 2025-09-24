// ignore_for_file: close_sinks

import 'dart:developer';
import 'dart:ui';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/result_controller.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/data/Model/result/my_final_results.dart';
import 'package:academy/data/Model/result/myresult_courses.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/images_urls.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/colors/light_colors.dart';

class FinalTestReportPage extends StatefulWidget {
  @override
  State<FinalTestReportPage> createState() => _FinalTestReportPageState();
}

class _FinalTestReportPageState extends State<FinalTestReportPage> {
  ResultController resultC = Get.find<ResultController>();
  String? testId;
  @override
  void initState() {
    super.initState();
    testId = Get.arguments[0];
    isQuizSide = Get.arguments[1];
    log('isQuizSide: ${isQuizSide.toString()}');
    resultC.myFinalResultApi(test_id: testId!);
  }

  bool isQuizSide = false;
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (isQuizSide) {
          Get.close(2);
        } else {
          Get.back();
        }
        return false;
      },
      child: Background(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                isQuizSide == true ? Get.close(3) : Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Test Report',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Obx(() => resultC.appStatusFinalTestDetailModel.value ==
                  AppStatus.LOADING
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: AppColors.kDarkBlue,
                  ),
                )
              : resultC.appStatusFinalTestDetailModel.value ==
                      AppStatus.COMPLETED
                  ? resultC.finalTestDetailModel == null
                      ? Center(
                          child: Text('No Result List added'),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.all(8.0).copyWith(top: 56.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      resultC.finalTestDetailModel!
                                                  .testDetails ==
                                              null
                                          ? Center(
                                              child:
                                                  Text('No Test Result  added'),
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Test Code: ${resultC.finalTestDetailModel!.testDetails!.testCode.toString()}',
                                                    style: CustomStyle
                                                        .textRegular15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue)),
                                                Text(
                                                    'Title: ${resultC.finalTestDetailModel!.testDetails!.testTitle.toString()}',
                                                    style: CustomStyle
                                                        .textRegular15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue)),
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0)
                                      .copyWith(top: 12.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      resultC.finalTestDetailModel!
                                                  .resultSummerySubjectWise ==
                                              null
                                          ? SizedBox.shrink()
                                          : Text('Subject Summary ',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                      resultC.finalTestDetailModel!
                                                  .resultSummerySubjectWise ==
                                              null
                                          ? Center(
                                              child: Text(
                                                  'No Test Result Summary Subject Wise added'),
                                            )
                                          : SizedBox(
                                              height: 110.h,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding:
                                                      EdgeInsets.only(top: 6.h),
                                                  shrinkWrap: true,
                                                  itemCount: resultC
                                                      .finalTestDetailModel!
                                                      .resultSummerySubjectWise!
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    var subjectWise = resultC
                                                            .finalTestDetailModel!
                                                            .resultSummerySubjectWise![
                                                        index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .all(8.0)
                                                          .copyWith(right: 0),
                                                      child: Container(
                                                        width: 89.w,
                                                        padding: EdgeInsets.all(
                                                            10.r),
                                                        color:
                                                            AppColors.kDarkBlue,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              '${subjectWise.subject.toString()}',
                                                              style: CustomStyle
                                                                  .textRegular12
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .whiteColor),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              height: 6.w,
                                                            ),
                                                            Text(
                                                                'C: ${subjectWise.c!.toString()}',
                                                                style: CustomStyle
                                                                    .textRegular15
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .whiteColor)),
                                                            SizedBox(
                                                              height: 8.w,
                                                            ),
                                                            Text(
                                                                'W: ${subjectWise.w.toString()}',
                                                                style: CustomStyle
                                                                    .textRegular15
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .whiteColor)),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text('Result Summary ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      resultC.finalTestDetailModel!
                                                  .resultSummery ==
                                              null
                                          ? Center(
                                              child: Text(
                                                  'No Test Result Summary  added'),
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                Text(
                                                    'Total Questions: ${resultC.finalTestDetailModel!.resultSummery!.totalQuestions.toString()}',
                                                    style: CustomStyle
                                                        .textRegular15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue)),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    'Given Answers: ${resultC.finalTestDetailModel!.resultSummery!.givenAnswers.toString()}',
                                                    style: CustomStyle
                                                        .textRegular15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue)),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    'Corrected Answers: ${resultC.finalTestDetailModel!.resultSummery!.correctedAnswers.toString()}',
                                                    style: CustomStyle
                                                        .textRegular15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue)),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    'Wrong Answers: ${resultC.finalTestDetailModel!.resultSummery!.wrongAnswers.toString()}',
                                                    style: CustomStyle
                                                        .textRegular15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue)),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                              ],
                                            ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      resultC.finalTestDetailModel
                                                  ?.resultDetails !=
                                              null
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor:
                                                    AppColors.whiteColor,
                                                backgroundColor:
                                                    AppColors.kDarkBlue,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(),
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                    RouteName
                                                        .finalTestDetailPage,
                                                    arguments: [testId, false]);
                                              },
                                              child: Text('View Answers'))
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                  : Center(
                      child: Text('error'),
                    )),
        ),
      ),
    );
  }
}
