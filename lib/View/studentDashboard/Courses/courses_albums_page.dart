// ignore_for_file: close_sinks

import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/getmycourses_controller.dart';
import 'package:academy/data/Model/Courses/course_albums.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../theme/colors/light_colors.dart';

class CoursesAlbumsPage extends StatefulWidget {
  @override
  State<CoursesAlbumsPage> createState() => _CoursesAlbumsPageState();
}

class _CoursesAlbumsPageState extends State<CoursesAlbumsPage> {
  GetMyCoursesController albumCoursesController =
      Get.find<GetMyCoursesController>();
  @override
  void initState() {
    super.initState();
    String id = Get.arguments[0].toString();
    log('id : $id');
    print('id : $id');
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
    albumCoursesController.getCourseAlbumsApi(course_id: id);
  }

  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Course Albums'),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() => albumCoursesController.appStatusAlbum.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : albumCoursesController.appStatusAlbum.value == AppStatus.COMPLETED
                ? albumCoursesController.getAlbumList.isEmpty
                    ? Center(
                        child: Text('No Albums added'),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: 23.h, left: 15.h, right: 15.h, bottom: 0.h),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemCount: albumCoursesController.getAlbumList.length,
                          itemBuilder: (BuildContext context, int index) {
                            AlbumList albumModel =
                                albumCoursesController.getAlbumList[index];

                            return Padding(
                              padding: const EdgeInsets.all(5.0)
                                  .copyWith(left: 0.w, right: 0.w),
                              child: AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(),
                                child: SlideAnimation(
                                  verticalOffset: 44.0,
                                  child: FadeInAnimation(
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(RouteName.coursesVideosPage,
                                            arguments: [
                                              albumModel.id.toString()
                                            ]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12.sp),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  AppColors.kDarkBlue,

                                                  AppColors.kLightBlue,
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
                                                    padding: const EdgeInsets
                                                            .all(8.0)
                                                        .copyWith(bottom: 10.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          albumModel.albamCode
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
                                                        Text(
                                                          albumModel
                                                              .albumTitle
                                                              .toString(),
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          maxLines: 2,
                                                          style: CustomStyle
                                                              .textSemiBold15
                                                              .copyWith(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: AppColors
                                                                .whiteColor,
                                                          ),
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
                          },
                        ),
                      )
                : SizedBox()),
      ),
    );
  }
}
