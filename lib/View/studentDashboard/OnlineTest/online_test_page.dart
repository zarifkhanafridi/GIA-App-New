// ignore_for_file: close_sinks

import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/OnlineTest/getcourses_test_page.dart';
import 'package:academy/View/studentDashboard/OnlineTest/quizScreen/quiz_screen.dart';
import 'package:academy/ViewModel/controllers/test_controller.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:academy/View/studentDashboard/OnlineTest/online_cources_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class OnlineTestPage extends StatefulWidget {
  @override
  State<OnlineTestPage> createState() => _OnlineTestPageState();
}

class _OnlineTestPageState extends State<OnlineTestPage> {
  final ScrollController _scrollController = ScrollController();
  dynamic argumentData = Get.arguments;
  // OnlineClassController onlineClassController =
  //     Get.put(OnlineClassController());
  List<OnlineClassModel> onlineClassList = [
    OnlineClassModel(subId: '1', subName: 'English'),
    OnlineClassModel(subId: '2', subName: 'Urdu '),
    OnlineClassModel(subId: '3', subName: 'Math  '),
    OnlineClassModel(subId: '4', subName: 'Pak Study  '),
    OnlineClassModel(subId: '5', subName: 'Science  '),
    OnlineClassModel(subId: '6', subName: 'Islamist '),
    // Add more items as needed
  ];
  TestController testController = Get.find<TestController>();
  var currentGradeId;
  @override
  void initState() {
    super.initState();
    print(argumentData[0]['index']);
    final index = argumentData[0]['index'];
    print('index : $index');
    // currentGradeId = Hive.box('box').get('current_g_id');
    print(currentGradeId);
    testController.getAllMyCoursesList(index);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text('All Test '),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            OutlinedButton.icon(
              onPressed: () {
                Get.toNamed(RouteName.buyTestPage);
              },
              icon: Icon(
                Icons.shopping_bag,
                color: AppColors.kDarkBlue,
              ),
              label: Text(
                'Buy Test',
                style: TextStyle(color: AppColors.kDarkBlue),
              ),
            ),
            SizedBox(width: 8.0),
          ],
        ),
        body: Obx(() => testController.appStatusGetAllTestList.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : testController.appStatusGetAllTestList.value ==
                    AppStatus.COMPLETED
                ? testController.getAllTestList.isEmpty
                    ? Center(
                        child: Text('No Test added'),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 22.h),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 16.h,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount:
                                      testController.getAllTestList.length,
                                  itemBuilder: (context, index) {
                                    var testList =
                                        testController.getAllTestList[index];

                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      child: SlideAnimation(
                                        verticalOffset: 44.0,
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {
                                              // Get.toNamed(
                                              //     RouteName.coursesAlbumsPage,
                                              //     arguments: [
                                              //       testList.courseId
                                              //           .toString()
                                              //     ]);
                                              Get.toNamed(
                                                RouteName.getCoursesTestPage,
                                                arguments: [
                                                  testList.id.toString()
                                                ],
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0)
                                                  .copyWith(
                                                      left: 0.w, right: 0.w),
                                              child: Container(
                                                padding: EdgeInsets.all(12.sp),
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
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .all(
                                                                        5.0)
                                                                    .copyWith(
                                                                        bottom:
                                                                            10.h),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Group Code:' +
                                                                      " " +
                                                                      testList
                                                                          .groupCode
                                                                          .toString(),
                                                                  style: CustomStyle.textSemiBold15.copyWith(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .whiteColor),
                                                                ),
                                                                SizedBox(
                                                                  height: 12.h,
                                                                ),
                                                                Text(
                                                                  'Group Name:' +
                                                                      "   " +
                                                                      testList
                                                                          .name
                                                                          .toString(),
                                                                  style: CustomStyle.textSemiBold15.copyWith(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .whiteColor),
                                                                ),
                                                                SizedBox(
                                                                  height: 12.h,
                                                                ),
                                                                Text(
                                                                  "Group Type:" +
                                                                      "  " +
                                                                      testList
                                                                          .groupType
                                                                          .toString(),
                                                                  style: CustomStyle.textSemiBold15.copyWith(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColors
                                                                          .whiteColor),
                                                                ),
                                                                SizedBox(
                                                                  height: 12.h,
                                                                ),
                                                                Text(
                                                                  "Payment:" +
                                                                      "  " +
                                                                      testList
                                                                          .paymentType
                                                                          .toString(),
                                                                  style: CustomStyle.textSemiBold15.copyWith(
                                                                      fontSize:
                                                                      12.sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: AppColors
                                                                          .kRed),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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

class OnlineClassModel {
  String subId;
  String subName;

  OnlineClassModel({required this.subId, required this.subName});
}
