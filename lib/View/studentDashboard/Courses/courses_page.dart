// ignore_for_file: close_sinks

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/Courses/feedback_view.dart';
import 'package:academy/ViewModel/controllers/getmycourses_controller.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../theme/colors/light_colors.dart';

class CoursesPage extends StatefulWidget {
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  GetMyCoursesController getMyCoursesController =
      Get.find<GetMyCoursesController>();
  @override
  void initState() {
    super.initState();

    getMyCoursesController.getAllMyCoursesList();
  }

  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('My Courses '),
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Obx(() => getMyCoursesController.appStatusGetMyCourses.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : getMyCoursesController.appStatusGetMyCourses.value ==
                    AppStatus.COMPLETED
                ? getMyCoursesController.getMyCoursesList.isEmpty
                    ? Center(
                        child: Text('No Courses added'),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: getMyCoursesController
                                      .getMyCoursesList.length,
                                  itemBuilder: (context, index) {
                                    var coursesModel = getMyCoursesController
                                        .getMyCoursesList[index];

                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(),
                                      child: SlideAnimation(
                                        verticalOffset: 44.0,
                                        child: FadeInAnimation(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0)
                                                .copyWith(
                                                    left: 0.w, right: 0.w),
                                            child: Container(
                                              padding: EdgeInsets.all(12.sp),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .all(5.0)
                                                                  .copyWith(
                                                                      bottom:
                                                                          3.h),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                coursesModel
                                                                        .courseCode
                                                                        .toString() +
                                                                    "/" +
                                                                    coursesModel
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
                                                                coursesModel
                                                                    .courseTitle
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
                                                                coursesModel
                                                                    .firstName
                                                                    .toString(),
                                                                style: CustomStyle.textSemiBold15.copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .whiteColor),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 6.w),
                                                        child: Text(
                                                          'Total Reviews (${coursesModel.feedbackCount.toString()})',
                                                          style: CustomStyle
                                                              .textSemiBold15
                                                              .copyWith(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .whiteColor),
                                                        ),
                                                      ),
                                                      RatingBar.builder(
                                                        initialRating: double
                                                            .parse(coursesModel
                                                                .feedback
                                                                .toString()),
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding:
                                                            EdgeInsets.zero,
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .all(10)
                                                                  .copyWith(
                                                                      left: 0,
                                                                      right: 0),
                                                          child: Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: 17.sp,
                                                          ),
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(5.0)
                                                                .copyWith(
                                                                    top: 6.h),
                                                        child: OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    250,
                                                                    250,
                                                                    250),
                                                            foregroundColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                          ),
                                                          onPressed: () {
                                                            Get.toNamed(
                                                                RouteName
                                                                    .coursesAlbumsPage,
                                                                arguments: [
                                                                  coursesModel
                                                                      .courseId
                                                                      .toString()
                                                                ]);
                                                          },
                                                          child: Text(
                                                            'View Course',
                                                            style: CustomStyle
                                                                .textSemiBold15
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .blackColor),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(5.0)
                                                                .copyWith(
                                                                    top: 6.h),
                                                        child: OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    250,
                                                                    250,
                                                                    250),
                                                            foregroundColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                          ),
                                                          onPressed: () {
                                                            Get.to(() =>
                                                                FeedbackUI(
                                                                  course_id: coursesModel
                                                                      .courseId
                                                                      .toString(),
                                                                ));
                                                          },
                                                          child: Text(
                                                            'FeedBack View',
                                                            style: CustomStyle
                                                                .textSemiBold15
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .blackColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
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
                : Center(
                    child: SizedBox(
                      child: Text(getMyCoursesController
                          .errorGetMyCoursesText.value
                          .toString()),
                    ),
                  )),
      ),
    );
  }
}

class AttendanceModel {
  final String? day;
  final String? date;
  final String? presentStatus;

  AttendanceModel({this.day, this.date, this.presentStatus});
}
