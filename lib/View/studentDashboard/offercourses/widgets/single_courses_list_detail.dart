import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/offercourses/widgets/course_details_widget.dart';
import 'package:academy/data/Model/offerCourses/offer_courses_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleCoursesListDetailPage extends StatefulWidget {
  SingleCoursesListDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleCoursesListDetailPage> createState() =>
      _SingleCoursesListDetailPageState();
}

class _SingleCoursesListDetailPageState
    extends State<SingleCoursesListDetailPage> {
  CourseList? courseList;

  @override
  void initState() {
    super.initState();
    courseList = Get.arguments?[0];
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Course Details'),
        ),
        body: CourseWidget(course: courseList!),
      ),
    );
  }
}
