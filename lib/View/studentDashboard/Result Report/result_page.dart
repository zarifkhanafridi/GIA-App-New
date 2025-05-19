// ignore_for_file: close_sinks

import 'dart:ui';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/result_controller.dart';
import 'package:academy/data/Model/result/myresult_courses.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/colors/light_colors.dart';

class ResultPage extends StatefulWidget {
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ResultController resultC = Get.find<ResultController>();
  @override
  void initState() {
    super.initState();
    resultC.myResultsCoursesList();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
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
            'Result',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Obx(() => resultC.appStatusMyResultCoursesList.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : resultC.appStatusMyResultCoursesList.value == AppStatus.COMPLETED
                ? resultC.myResultCoursesList.isEmpty
                    ? Center(
                        child: Text('No Result List added'),
                      )
                    : ListView.builder(
                        itemCount: resultC.myResultCoursesList.length,
                        padding: EdgeInsets.only(top: 40.h),
                        itemBuilder: (context, index) {
                          MyResultCoursesList res =
                              resultC.myResultCoursesList[index];
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              Get.toNamed(RouteName.myTestResultPage,
                                  arguments: [res.id.toString()]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.kDarkBlue,
                                          AppColors.kLightBlue,

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
                                        res.name.toString(),
                                        style: CustomStyle.textSemiBold15,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4.0.h),
                                          Text(
                                            '${res.groupCode} / ${res.catName}',
                                            style: CustomStyle.textRegular15,
                                          ),
                                          SizedBox(height: 4.0.h),
                                          Text(
                                            'Group Type: ${res.groupType}',
                                            style: CustomStyle.textRegular15,
                                          ),
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
                    child: Text('errors'),
                  )),
      ),
    );
  }
}
