import 'package:academy/View/commonPage/background.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class OnlineTestPageCardSection extends StatefulWidget {
  const OnlineTestPageCardSection({super.key});

  @override
  State<OnlineTestPageCardSection> createState() =>
      _OnlineTestPageCardSectionState();
}

class _OnlineTestPageCardSectionState extends State<OnlineTestPageCardSection> {
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 22.h),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.h,
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      // var testList = testController.getAllTestList[index];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 44.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  RouteName.onlineTestPage,
                                  arguments: [
                                    {"index": '$index'},
                                  ],
                                );
                                // Get.toNamed(
                                //     RouteName.coursesAlbumsPage,
                                //     arguments: [
                                //       testList.courseId
                                //           .toString()
                                //     ]);
                                // Get.toNamed(
                                //   RouteName.getCoursesTestPage,
                                //   arguments: [testList.id.toString()],
                                // );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0)
                                    .copyWith(left: 0.w, right: 0.w),
                                child: Container(
                                  padding: EdgeInsets.all(12.sp),
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
                                          color: Colors.white, width: 2.w)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0)
                                                      .copyWith(bottom: 10.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    index == 0
                                                        ? 'Group Wise Tests'
                                                        : "Preparation Tests",
                                                    style: CustomStyle
                                                        .textSemiBold15
                                                        .copyWith(
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .whiteColor),
                                                  ),
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
        ),
      ),
    );
  }
}
