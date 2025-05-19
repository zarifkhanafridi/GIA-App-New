// ignore_for_file: close_sinks

import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/OnlineTest/info_test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:academy/View/studentDashboard/OnlineTest/online_cources_page.dart';
import 'package:academy/View/studentDashboard/OnlineTest/quizScreen/quiz_screen.dart';
import 'package:academy/ViewModel/controllers/test_controller.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';

class GetCoursesTestPage extends StatefulWidget {
  GetCoursesTestPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GetCoursesTestPage> createState() => _GetCoursesTestPageState();
}

class _GetCoursesTestPageState extends State<GetCoursesTestPage> {
  final ScrollController _scrollController = ScrollController();
  String? id;
  // OnlineClassController onlineClassController =

  TestController testController = Get.find<TestController>();

  @override
  void initState() {
    super.initState();
    // currentGradeId = Hive.box('box').get('current_g_id');

    id = Get.arguments[0];
    testController.getCourseTestsApi(id: id!);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('All Available Test '),
          foregroundColor: Colors.black,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() => testController.appStatusGetAllCoursesTestList.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : testController.appStatusGetAllCoursesTestList.value ==
                    AppStatus.COMPLETED
                ? testController.getAllCoursesTestList.isEmpty
                    ? Center(
                        child: Text('No Test added'),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 22.h),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 13.h,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: testController
                                      .getAllCoursesTestList.length,
                                  itemBuilder: (context, index) {
                                    var testList = testController
                                        .getAllCoursesTestList[index];

                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration: const Duration(),
                                      columnCount: 2,
                                      child: SlideAnimation(
                                        verticalOffset: 44.0,
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {
                                              log(testList.testGroupId
                                                  .toString());
                                              Get.dialog(InfoTestPage(
                                                id: testList.testGroupId
                                                    .toString(),
                                              ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0)
                                                  .copyWith(
                                                      left: 0.w, right: 0.w),
                                              child: Container(
                                                padding: EdgeInsets.all(5.sp),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          AppColors.kDarkBlue,

                                                          AppColors.kLightBlue,
                                                          // LightColors.kLightYellow,

                                                          // Colors.redAccent[200],
                                                          // Colors.greenAccent[300],
                                                        ]),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 2.w)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                                  5.0)
                                                              .copyWith(
                                                                  bottom: 2.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Test Code:' +
                                                                " " +
                                                                testList
                                                                    .testCode
                                                                    .toString(),
                                                            style: CustomStyle
                                                                .textSemiBold15
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .whiteColor),
                                                          ),
                                                          SizedBox(
                                                            height: 4.h,
                                                          ),
                                                          Text(
                                                            "Title:" +
                                                                "  " +
                                                                testList
                                                                    .testTitle
                                                                    .toString(),
                                                            style: CustomStyle
                                                                .textSemiBold15
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .whiteColor),
                                                          ),
                                                          SizedBox(
                                                            height: 4.h,
                                                          ),
                                                          Text(
                                                            'Test Date:' +
                                                                "   " +
                                                                testList
                                                                    .testStart
                                                                    .toString(),
                                                            style: CustomStyle
                                                                .textSemiBold15
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .whiteColor),
                                                          ),
                                                          SizedBox(
                                                            height: 4.h,
                                                          ),
                                                          Text(
                                                            'Test Type:' +
                                                                "   " +
                                                                testList
                                                                    .testType
                                                                    .toString(),
                                                            style: CustomStyle
                                                                .textSemiBold15
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .kRed),
                                                          ),
                                                          SizedBox(
                                                            height: 12.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      )
                : SizedBox()),
      ),
    );
  }
}
