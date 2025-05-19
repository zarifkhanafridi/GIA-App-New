import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/getmycourses_controller.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeedbackUI extends StatefulWidget {
  final String course_id;

  const FeedbackUI({super.key, required this.course_id});
  @override
  _FeedbackUIState createState() => _FeedbackUIState();
}

class _FeedbackUIState extends State<FeedbackUI> {
  double _rating = 0.0;
  final TextEditingController _feedbackController = TextEditingController();
  GetMyCoursesController getMyCoursesController =
      Get.find<GetMyCoursesController>();
  @override
  void initState() {
    super.initState();

    getMyCoursesController.getStudentFeedBackApi(courseId: widget.course_id);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('FeedBack View '),
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Obx(() => getMyCoursesController.appStatusFeedBack.value ==
                  AppStatus.LOADING
              ? Padding(
                  padding: const EdgeInsets.all(200)
                      .copyWith(left: 22.w, right: 22.w),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: AppColors.kDarkBlue,
                    ),
                  ),
                )
              : getMyCoursesController.appStatusFeedBack.value ==
                      AppStatus.COMPLETED
                  ? getMyCoursesController.getFeedBackModel!.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 12.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 45.h,
                              ),
                              Text('Rate your experience:'),
                              RatingBar.builder(
                                initialRating: _rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: _feedbackController,
                                decoration: InputDecoration(
                                  hintText: "Leave your feedback here",
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 5,
                              ),
                              SizedBox(height: 20),
                              Obx(() => OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                      foregroundColor:
                                          Color.fromRGBO(255, 255, 255, 1),
                                      minimumSize: Size(200.w, 40.h),
                                      maximumSize: Size(200.w, 40.h),
                                    ),
                                    onPressed: () async {
                                      // getMyCoursesController.isFeedBackLoading.value=false;
                                      await getMyCoursesController
                                          .postFeedBackApi(
                                        course_id: widget.course_id,
                                        rating: _rating.toString(),
                                        comments:
                                            _feedbackController.text.trim() ??
                                                'empty',
                                      );
                                    },
                                    child: getMyCoursesController
                                            .isFeedBackLoading.value
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          ))
                                        : Text(
                                            'Submit Your FeedBack',
                                            style: CustomStyle.textSemiBold15
                                                .copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.blackColor),
                                          ),
                                  )),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(200.0)
                              .copyWith(left: 20.w, right: 20.w),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Text(
                                        "Feedback: " +
                                            "${getMyCoursesController.getFeedBackModel!.first.comments.toString()}",
                                        style: CustomStyle.textSemiBold15
                                            .copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.kDarkBlue),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    RatingBar.builder(
                                      initialRating: double.parse(
                                          getMyCoursesController
                                              .getFeedBackModel!.first.rating
                                              .toString()),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.zero,
                                      itemBuilder: (context, _) => Padding(
                                        padding: const EdgeInsets.all(10)
                                            .copyWith(left: 0, right: 0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 17.sp,
                                        ),
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                  : Center(
                      child: Text(
                        getMyCoursesController.errorFeedBackText.value
                            .toString(),
                        style: TextStyle(color: AppColors.blackColor),
                      ),
                    )),
        ),
      ),
    );
  }
}
