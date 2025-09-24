// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:developer';
import 'package:academy/util/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/test_controller.dart';
import 'package:academy/components/primary_button.dart';
import 'package:academy/data/Model/TestModel/question_test_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/app_urls.dart';
import 'package:academy/res/images_urls.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:lottie/lottie.dart';

class QuizScreen extends StatefulWidget {
  String id;
  int time;
  QuizScreen({
    Key? key,
    required this.time,
    required this.id,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  PageController pageController = PageController();
  TestController testQuestionC = Get.find<TestController>();
  List<Map<String, dynamic>> answersList = [];
  List<Map<String, dynamic>> skipList = [];
  Map<String, dynamic> currentData = {};
  Map<int, int> selectedOptions = {};

  int questionN = 0;
  int timerDuration = 0;
  int currentIndex = 0;
  bool isLastQuestion = false;
  bool isLastQuestionPressed = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      testQuestionC.getAllTestQuestionsApi(questionId: widget.id);
      timerDuration = widget.time;
      log('time:' + timerDuration.toString());
      startTimer(timerDuration);
    });
  }

  bool isTimerActive = false;
  QuestionModelList? testM;
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.kLandingBgColor),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child:
                    Icon(Icons.more_vert, color: AppColors.kGrayscaleDark100),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          title: Text(
            'Question',
            style:
                CustomStyle.textMedium14.copyWith(color: AppColors.kDarkBlue),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back<void>();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.kLandingBgColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                  child: Icon(Icons.arrow_back,
                      color: AppColors.kGrayscaleDark100),
                ),
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Obx(() => testQuestionC.appStatusQuestionModel.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : testQuestionC.appStatusQuestionModel.value == AppStatus.COMPLETED
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: testQuestionC.questionModelList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                // currentIndex = index;
                                pageController.jumpToPage(index);
                              });
                            },
                            itemBuilder: (context, index) {
                              testM = testQuestionC.questionModelList[index];
                              questionN =
                                  int.parse(testM!.questionNo.toString());

                              log(' NAME: ${testM!.questionName.toString()}');
                              log(testM!.opt1.toString());
                              String testTile =
                                  ' <figure class="image"><img src="https://gislamian.pk/test/1707853626.PNG"></figure>' +
                                      "text tile and image both in one link";
                              return SingleChildScrollView(
                                padding: EdgeInsets.only(
                                  bottom: 34.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    Row(
                                      children: [
                                        Lottie.asset(ImagePath.clockIcon,
                                            width: 23.w, height: 24.h),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          'Time remaining: ${formatTime(timerDuration)}',
                                          style: CustomStyle.textRegular15
                                              .copyWith(
                                                  color: AppColors.kDarkBlue,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Question no  ' +
                                                  questionN.toString(),
                                              style: CustomStyle.textSemiBold20
                                                  .copyWith(
                                                      color:
                                                          AppColors.kDarkBlue)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    Html(data: testM!.questionName.toString()),
                                    SizedBox(
                                      height: 22.h,
                                    ),
                                    Text('Options',
                                        style: CustomStyle.textSemiBold15
                                            .copyWith(
                                                color: AppColors.kDarkBlue)),
                                    SizedBox(
                                      height: 22.h,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            // selectIndex = index;
                                            // widget.questionModel.userAnswer = currentItem;
                                            currentData = {
                                              "q_id": testM!.id.toString(),
                                              "given_answer": "opt_1",
                                              "corrected_answer": testM!
                                                  .correctAnswer
                                                  .toString(),
                                            };
                                            setState(() {
                                              selectedOptions[index] = 1;
                                            });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23.w,
                                                vertical: 8.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                border: Border.all(
                                                    color: selectedOptions[
                                                                index] ==
                                                            1
                                                        ? Colors.blue
                                                        : AppColors
                                                            .kGrayscaleDark80)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "(A) ",
                                                  style: CustomStyle
                                                      .textSemiBold15
                                                      .copyWith(
                                                          color: AppColors
                                                              .kDarkBlue),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Flexible(
                                                  child: Html(
                                                      data: testM!.opt1
                                                          .toString()),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            currentData = {
                                              "q_id": testM!.id.toString(),
                                              "given_answer": "opt_2",
                                              "corrected_answer": testM!
                                                  .correctAnswer
                                                  .toString(),
                                            };
                                            setState(() {
                                              selectedOptions[index] = 2;
                                            });
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 23.w,
                                                  vertical: 8.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  border: Border.all(
                                                      color: selectedOptions[
                                                                  index] ==
                                                              2
                                                          ? Colors.blue
                                                          : AppColors
                                                              .kGrayscaleDark80)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "(B) ",
                                                    style: CustomStyle
                                                        .textSemiBold15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue),
                                                  ),
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Flexible(
                                                    child: Html(
                                                        data: testM!.opt2
                                                            .toString()),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            currentData = {
                                              "q_id": testM!.id.toString(),
                                              "given_answer": "opt_3",
                                              "corrected_answer": testM!
                                                  .correctAnswer
                                                  .toString(),
                                            };
                                            setState(() {
                                              selectedOptions[index] = 3;
                                            });
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 23.w,
                                                  vertical: 8.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  border: Border.all(
                                                      color: selectedOptions[
                                                                  index] ==
                                                              3
                                                          ? Colors.blue
                                                          : AppColors
                                                              .kGrayscaleDark80)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "(C) ",
                                                    style: CustomStyle
                                                        .textSemiBold15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue),
                                                  ),
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Flexible(
                                                    child: Html(
                                                        data: testM!.opt3
                                                            .toString()),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            // selectIndex = index;
                                            // widget.questionModel.userAnswer = currentItem;
                                            currentData = {
                                              "q_id": testM!.id.toString(),
                                              "given_answer": "opt_4",
                                              "corrected_answer": testM!
                                                  .correctAnswer
                                                  .toString(),
                                            };

                                            setState(() {
                                              selectedOptions[index] = 4;
                                            });
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 23.w,
                                                  vertical: 8.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  border: Border.all(
                                                      color: selectedOptions[
                                                                  index] ==
                                                              4
                                                          ? Colors.blue
                                                          : AppColors
                                                              .kGrayscaleDark80)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "(D) ",
                                                    style: CustomStyle
                                                        .textSemiBold15
                                                        .copyWith(
                                                            color: AppColors
                                                                .kDarkBlue),
                                                  ),
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Flexible(
                                                    child: Html(
                                                        data: testM!.opt4
                                                            .toString()),
                                                  ),
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0)
                              .copyWith(top: 0.h, bottom: 12.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: PrimaryButton(
                                  width: 60.w,
                                  height: 45.h,
                                  onTap: () {
                                    if (currentIndex > 0) {
                                      // If currentIndex is greater than 0, move back one page
                                      pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.easeOut,
                                      );
                                      // Update the currentIndex
                                      setState(() {
                                        currentIndex--;
                                      });
                                    } else {
                                      // If currentIndex is already 0, handle as needed (e.g., navigate back)
                                      // Get.back();
                                    }
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
                                width: 30.w,
                              ),
                              Obx(() => Flexible(
                                    child: PrimaryButton(
                                        width: 63.w,
                                        height: 45.h,
                                        onTap: isLastQuestion
                                            ? () async {
                                                if (isLastQuestionPressed) {
                                                  fluttersToast(
                                                      msg:
                                                          'answers is posting please wait..',
                                                      bgColor: Colors.white,
                                                      textColor:
                                                          Colors.black12);
                                                } else {
                                                  await testQuestionC
                                                      .postAllAnswersApi(
                                                          data: answersList,
                                                          testId: widget.id)
                                                      .then((value) async {
                                                    answersList.clear();
                                                  });
                                                }
                                                setState(() {
                                                  isLastQuestionPressed = true;
                                                });
                                              }
                                            : () async {
                                                if (currentData.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: 'Select any option');
                                                } else {
                                                  answersList.add(currentData);
                                                  log(answersList.length
                                                      .toString());

                                                  if (currentIndex ==
                                                      testQuestionC
                                                              .questionModelList
                                                              .length -
                                                          1) {
                                                    // Perform the action for the last question

                                                    // Disable the "Next" button
                                                    setState(() {
                                                      isLastQuestion = true;
                                                    });
                                                  } else {
                                                    // currentData.clear();
                                                    // Move to the next page
                                                    pageController.nextPage(
                                                      duration: const Duration(
                                                          milliseconds: 100),
                                                      curve: Curves.easeIn,
                                                    );

                                                    // Update the currentIndex
                                                    setState(() {
                                                      currentIndex++;
                                                    });
                                                  }
                                                  currentData = {};
                                                  log(answersList.length
                                                      .toString());
                                                }
                                              },
                                        childWidget: testQuestionC
                                                    .isAnswersPost.value ==
                                                true
                                            ? SizedBox(
                                                height: 24.h,
                                                width: 24.w,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    strokeWidth: 2.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.white),
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                isLastQuestion
                                                    ? 'Finished'
                                                    : 'Next',
                                                style: CustomStyle.textMedium14
                                                    .copyWith(
                                                  color: AppColors.whiteColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                        bgColor: AppColors.kDarkBlue),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: Text('error'))));
  }

  String parseString(String inputString) {
    RegExp imageTagRegExp = RegExp(r'<img src="([^"]+)"');
    var imageMatch = imageTagRegExp.firstMatch(inputString);

    if (imageMatch != null) {
      // If the regex finds an <img> tag, return the URL.
      return imageMatch.group(1)!;
    } else {
      // Otherwise, treat as HTML containing text and extract the text content.
      var document = parse(inputString);
      return document.body!.text
          .trim(); // Extracts and returns text, removing HTML tags.
    }
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer(int minutes) {
    int seconds = minutes * 60; // Convert minutes to seconds

    if (!isTimerActive) {
      isTimerActive = true;
      timerDuration = seconds; // Set timer duration in seconds

      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        if (timerDuration > 0) {
          if (mounted) {
            setState(() {
              timerDuration--;
            });
          }
        } else {
          t.cancel();
          isTimerActive = false;
          // Handle what happens when the timer reaches 0
        }
      });
    }
  }
}
