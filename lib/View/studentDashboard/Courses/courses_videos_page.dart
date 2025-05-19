// ignore_for_file: close_sinks

import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/Courses/video_screen_page.dart';
import 'package:academy/ViewModel/controllers/getmycourses_controller.dart';
import 'package:academy/data/Model/Courses/courses_videos.dart';
import 'package:academy/data/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../theme/colors/light_colors.dart';

class CoursesVideosPage extends StatefulWidget {
  @override
  State<CoursesVideosPage> createState() => _CoursesVideosPageState();
}

class _CoursesVideosPageState extends State<CoursesVideosPage> {
  final ScrollController _scrollController = ScrollController();

  GetMyCoursesController videosCoursesController =
      Get.find<GetMyCoursesController>();
  @override
  void initState() {
    super.initState();
    String id = Get.arguments[0].toString();
    log('id : $id');
    videosCoursesController.getCourseVideosApi(album_id: id);
  }

  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Videos Lecture '),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() => videosCoursesController.appStatusVideos.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : videosCoursesController.appStatusVideos.value ==
                    AppStatus.COMPLETED
                ? videosCoursesController.coursesVideoList.isEmpty
                    ? Center(
                        child: Text('No Videos added'),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 12, left: 15, right: 15, bottom: 0),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount:
                              videosCoursesController.coursesVideoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            CoursesVideoList albumModel =
                                videosCoursesController.coursesVideoList[index];

                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(),
                              child: SlideAnimation(
                                verticalOffset: 44.0,
                                child: FadeInAnimation(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0)
                                          .copyWith(left: 0.w, right: 0.w),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => VideoScreen(
                                                videoName: albumModel.videoName
                                                    .toString(),
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.kDarkBlue,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Center(
                                                    child: Text(
                                                  albumModel.videoTitle
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.white),
                                                )),
                                                width: double.infinity,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(14.sp),
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .video_label_outlined,
                                                      color: Colors.white,
                                                      size: 30.sp,
                                                    ),
                                                    Text(
                                                      'Watch Video',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
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
