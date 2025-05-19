// ignore_for_file: close_sinks

import 'dart:developer';
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
import 'widgets/quiz_report_details.dart';

class FinalTestDetailPage extends StatefulWidget {
  @override
  State<FinalTestDetailPage> createState() => _FinalTestDetailPageState();
}

class _FinalTestDetailPageState extends State<FinalTestDetailPage> {
  ResultController detailResultC = Get.find<ResultController>();
  String? testId;
  @override
  void initState() {
    super.initState();
    testId = Get.arguments[0];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('test id:' + testId.toString());
      detailResultC.myFinalResultApi(test_id: testId!);
    });
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
            'Test Result',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Obx(() => detailResultC.appStatusFinalTestDetailModel.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : detailResultC.appStatusFinalTestDetailModel.value ==
                    AppStatus.COMPLETED
                ? detailResultC.finalTestDetailModel!.resultDetails!.isEmpty
                    ? Center(
                        child: Text('No Result List added'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListView.builder(
                          itemCount: detailResultC
                              .finalTestDetailModel!.resultDetails!.length,
                          itemBuilder: (context, index) {
                            var result = detailResultC
                                .finalTestDetailModel!.resultDetails![index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: QuizReportDetails(
                                resData: result!,
                              ),
                            );
                            ;
                          },
                        ),
                      )
                : Center(
                    child: Text('error'),
                  )),
      ),
    );
  }
}
