import 'package:academy/components/reuasable_widget.dart';
import 'package:academy/data/Model/offerCourses/offer_courses_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/colors/light_colors.dart';

class CourseDetailsWidget extends StatelessWidget {
  final ResultDetails courseData;

  CourseDetailsWidget({required this.courseData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.creamyColor.withOpacity(0.5),

              AppColors.kLightYellow2.withOpacity(0.5),
              // LightColors.kLightYellow,

              // Colors.redAccent[200],
              // Colors.greenAccent[300],
            ]),
      ),
      padding: EdgeInsets.all(34.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${courseData.courseTitle}   ${courseData.classTime}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Instructor: ${courseData.firstName}',
          ),
          Text(
            'Price: ${courseData.price}',
          ),
        ],
      ),
    );
  }
}

class CourseWidget extends StatelessWidget {
  final CourseList course;

  CourseWidget({required this.course});
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableWidget(value: course.id ?? 'empty', title: 'Id  '),
            SizedBox(height: 10.h),
            ReusableWidget(
                value: course.groupType ?? 'empty', title: 'Group Type  '),
            SizedBox(height: 10.h),
            ReusableWidget(
                value: course.catName ?? 'empty', title: 'Test Name  '),
            SizedBox(height: 10.h),
            ReusableWidget(
                value: course.description ?? 'empty', title: 'Description  '),
            SizedBox(height: 10.h),
            ReusableWidget(
                value: course.expireOn ?? 'empty', title: 'Expire On  '),
            SizedBox(height: 10.h),
            ReusableWidget(
                value: course.groupCode ?? 'empty', title: 'Group C ode  '),
            SizedBox(height: 10.h),
            ReusableWidget(
                value: course.isActive ?? 'empty', title: 'isActive  '),
            SizedBox(height: 10.h),
            ReusableWidget(
                value: course.totalSeat ?? 'empty', title: 'Total Seat  '),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: course.courses!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CourseDetailsWidget(
                              courseData: course.courses![index]),
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
