// ignore_for_file: close_sinks

import 'dart:developer';
import 'dart:ui';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/result_controller.dart';
import 'package:academy/data/Model/result/my_results_tests.dart';
import 'package:academy/data/Model/result/myresult_courses.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/colors/light_colors.dart';

class MyTestResultPage extends StatefulWidget {
  @override
  State<MyTestResultPage> createState() => _MyTestResultPageState();
}

class _MyTestResultPageState extends State<MyTestResultPage> {
  ResultController myTestResultC = Get.find<ResultController>();
  String? coursesId;
  @override
  void initState() {
    super.initState();
    coursesId = Get.arguments[0];
    myTestResultC.myResultsTestListApi(courseId: coursesId!);
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'My Test Results',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Obx(() => myTestResultC.appStatusMyResultTestModelList.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : myTestResultC.appStatusMyResultTestModelList.value ==
                    AppStatus.COMPLETED
                ? myTestResultC.myResultTestModelList.isEmpty
                    ? Center(
                        child: Text('No Test Result List added'),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 40.h),
                        itemCount: myTestResultC.myResultTestModelList.length,
                        itemBuilder: (context, index) {
                          MyResultTestModelList res =
                              myTestResultC.myResultTestModelList[index];
                          return InkWell(
                            onTap: () {
                              log(res.groupTestId.toString() + " testGroup id");
                              Get.toNamed(RouteName.finalTestReportPage,
                                  arguments: [
                                    res.groupTestId.toString(),
                                    false
                                  ]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(6.sp),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.kDarkBlue,
                                          AppColors.kLightBlue
                                          // LightColors.kLightYellow,

                                          // Colors.redAccent[200],
                                          // Colors.greenAccent[300],
                                        ]),
                                    border: Border.all(
                                        color: Colors.white, width: 1.w)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        res.testCode.toString(),
                                        style: CustomStyle.textSemiBold15,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8.0),
                                          Text(
                                            'Test Title: ${res.testTitle}',
                                            style: CustomStyle.textRegular15,
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            'Test Date: ${res.testStart.toString()}',
                                            style: CustomStyle.textRegular15,
                                          ),
                                          SizedBox(height: 4.0),
                                          // Text(
                                          //   'Group Type: ${res.groupType}',
                                          //   style: CustomStyle.textRegular15,
                                          // ),
                                        ],
                                      ),
                                    ),

                                    // Generate a horizontal list of courses
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                : Center(
                    child: Text('error'),
                  )),
      ),
    );
  }
}
