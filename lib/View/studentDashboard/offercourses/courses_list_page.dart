import 'dart:convert';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/Courses/video_screen3.dart';
import 'package:academy/View/studentDashboard/Courses/video_screen_page.dart';
import 'package:academy/View/studentDashboard/Cart/cart_view.dart';
import 'package:academy/ViewModel/controllers/offercourse_controller.dart';
import 'package:academy/data/Model/offerCourses/offer_courses_list_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/icons.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:academy/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class OfferCoursesListPage extends StatefulWidget {
  const OfferCoursesListPage({super.key});

  @override
  State<OfferCoursesListPage> createState() => _OfferCoursesListPageState();
}

class _OfferCoursesListPageState extends State<OfferCoursesListPage> {
  final OfferCourseController courseC = Get.find<OfferCourseController>();

  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Courses List'),
        backgroundColor: Colors.transparent,
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartView()),
                );
              },
              icon: Badge(
                label: Text(itemCount.toString()),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
        elevation: 0,
      ),
      body: Obx(
        () => courseC.appStatusCoursesList.value == AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : SingleChildScrollView(
                controller: controller,
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: AnimationLimiter(
                    child: Scrollbar(
                      thickness: 6,
                      radius: Radius.circular(3),
                      controller: controller,
                      child: ListView.builder(
                        controller: controller,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: courseC.coursesList.length,
                        itemBuilder: (context, index) {
                          CourseList courseModel = courseC.coursesList[index];
                          print('Course Model');
                          print(courseModel.groupPaymentType.toString());
                          // print(courseC.coursesList[index].groupPaymentType.toString());
                          List<ResultDetails>? courseList = courseModel.courses;
                          var map = {'resultDetails': courseList};
                          var myJson = json.encode(map);

                          print(
                              '********************* Course list ***********************');
                          print(courseList);
                          String course_id = 'null';
                          String courseID = "null";
                          if (courseList != null && courseList.isNotEmpty) {
                            course_id = '';
                            for (var course in courseList) {
                              course_id = course_id + '${course.id},';
                            }
                          }
                          if (courseList != null && courseList.isNotEmpty) {
                            courseID = "";
                            for (var course in courseList) {
                              courseID = course.id!;
                            }
                          }

                          print(course_id);
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              // Get.toNamed(RouteName.singleCoursesListDetailPage,
                              //     arguments: [courseModel]);
                            },
                            child: AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 44.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0)
                                        .copyWith(top: 12.h),
                                    child: Container(
                                      padding: EdgeInsets.all(14),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  courseModel.groupCode
                                                          .toString() +
                                                      "-" +
                                                      courseModel.name
                                                          .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              courseModel.registrationMethod!
                                                          .toLowerCase()
                                                          .toString() ==
                                                      'whole'
                                                  ? InkWell(
                                                      onTap: () async {
                                                        await PersistentShoppingCart()
                                                            .addToCart(
                                                                PersistentShoppingCartItem(
                                                          productId:
                                                              'C-${courseModel.id}',
                                                          productName:
                                                              '${courseModel.groupCode}-${courseModel.name} Course',
                                                          unitPrice: double
                                                              .parse(courseModel
                                                                  .total_price
                                                                  .toString()),
                                                          quantity: 1,
                                                          productDetails: {
                                                            'id': int.parse(
                                                                courseModel
                                                                    .id!),
                                                            'category_id':
                                                                courseList![index]
                                                                        .categoryId ??
                                                                    'null',
                                                            'course_id':
                                                                course_id,
                                                            'fee_type':
                                                                'course',
                                                            'group_id':
                                                                "${courseModel.id}",
                                                            'course_details':
                                                                myJson,
                                                          },
                                                        ));
                                                      },
                                                      child: SvgPicture.asset(
                                                        AppIcons.shoppingCard,
                                                        width: 45,
                                                        height: 45,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          // Generate a horizontal list of courses
                                          SingleChildScrollView(
                                            controller: controller,
                                            scrollDirection: Axis.vertical,
                                            child: ListView.builder(
                                              controller: controller,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: courseList!.length,
                                              itemBuilder: (context, index) {
                                                var courseDetail =
                                                    courseList[index];

                                                return AnimationConfiguration
                                                    .staggeredList(
                                                  position: index,
                                                  duration: const Duration(),
                                                  child: SlideAnimation(
                                                    verticalOffset: 44.0,
                                                    child: FadeInAnimation(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(14),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      AppColors
                                                                          .kLightBlue,
                                                                      AppColors
                                                                          .kLightBlue
                                                                      // LightColors.kLightYellow,

                                                                      // Colors.redAccent[200],
                                                                      // Colors.greenAccent[300],
                                                                    ]),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width:
                                                                        1.w)),
                                                        margin:
                                                            EdgeInsets.all(1),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ReUsableRow(
                                                                title: 'Price',
                                                                value: courseModel
                                                                            .groupPaymentType ==
                                                                        "Paid"
                                                                    ? courseDetail
                                                                        .price
                                                                        .toString()
                                                                    : "Free"),
                                                            SizedBox(
                                                              height: 7.h,
                                                            ),
                                                            ReUsableRow(
                                                                title: courseDetail
                                                                    .courseCode
                                                                    .toString(),
                                                                value: courseDetail
                                                                    .courseTitle
                                                                    .toString()),
                                                            SizedBox(
                                                              height: 7.h,
                                                            ),
                                                            ReUsableRow(
                                                                title: courseDetail
                                                                    .firstName
                                                                    .toString(),
                                                                value: courseDetail
                                                                    .classTime
                                                                    .toString()),
                                                            SizedBox(
                                                              height: 7.h,
                                                            ),
                                                            ReUsableIconRow(
                                                                onTab: () {
                                                                  if (courseDetail
                                                                          .courseOverviewUrl ==
                                                                      '') {
                                                                    fluttersToast(
                                                                        msg:
                                                                            'course Overview is Empty',
                                                                        bgColor:
                                                                            Colors
                                                                                .white,
                                                                        textColor:
                                                                            Colors.black);
                                                                  } else {
                                                                    Get.to(() =>
                                                                        NewVideoScreen(
                                                                          videoName: courseDetail
                                                                              .courseOverviewUrl
                                                                              .toString(),
                                                                        ));
                                                                  }
                                                                },
                                                                title:
                                                                    "Course OverView",
                                                                value: AppIcons
                                                                    .youTubePlay),
                                                            SizedBox(
                                                              height: 7.h,
                                                            ),
                                                            courseModel.groupPaymentType ==
                                                                    "Paid"
                                                                ? SizedBox()
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      5.0,
                                                                    ).copyWith(
                                                                      top: 6.h,
                                                                    ),
                                                                    child:
                                                                        OutlinedButton(
                                                                      style: OutlinedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.red,
                                                                        foregroundColor: const Color
                                                                            .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Get.toNamed(
                                                                            RouteName.coursesAlbumsPage,
                                                                            arguments: [
                                                                              courseID
                                                                            ]);
                                                                        // offerC
                                                                        //     .getCurrentCoursesList(
                                                                        //   categoryId: categoryModel
                                                                        //       .mscatId
                                                                        //       .toString(),
                                                                        // );
                                                                        // Get.toNamed(
                                                                        //   RouteName
                                                                        //       .offerCoursesListPage,
                                                                        // );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'View Free Course Videos',
                                                                        style: CustomStyle.textSemiBold15.copyWith(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: AppColors.whiteColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            courseModel.registrationMethod!
                                                                        .toLowerCase()
                                                                        .toString() ==
                                                                    'whole'
                                                                ? SizedBox()
                                                                : Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Flexible(
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          'Add to Cart',
                                                                          style: TextStyle(
                                                                              fontSize: 18.sp,
                                                                              color: AppColors.whiteColor,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            14.w,
                                                                      ),
                                                                      Container(
                                                                        color: Colors
                                                                            .red,
                                                                        child:
                                                                            Flexible(
                                                                          fit: FlexFit
                                                                              .tight,
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              await PersistentShoppingCart().addToCart(PersistentShoppingCartItem(
                                                                                productId: courseDetail.id!,
                                                                                productName: courseDetail.courseCode.toString() + "-" + courseDetail.courseTitle.toString(),
                                                                                unitPrice: double.parse(courseDetail.price.toString()),
                                                                                quantity: 1,
                                                                              ));
                                                                            },
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              AppIcons.shoppingCard,
                                                                              width: 45,
                                                                              height: 45,
                                                                              color: AppColors.whiteColor,
                                                                            ),
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
                                                );
                                              },
                                            ),
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
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  final String title, value;
  const ReUsableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: SizedBox(
            width: 100.w,
            height: 20.h,
            child: Text(
              title,
              style: CustomStyle.textBold36.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 12.sp,
                  fontWeight: mediumFontWeight),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(
          width: 14.w,
        ),
        Flexible(
          child: SizedBox(
            width: 120.w,
            child: Text(
              value,
              style: CustomStyle.textBold36.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 14.sp,
                  fontWeight: mediumFontWeight),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class ReUsableIconRow extends StatelessWidget {
  final String title, value;
  final VoidCallback onTab;
  const ReUsableIconRow({
    Key? key,
    required this.title,
    required this.onTab,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: SizedBox(
              width: 100.w,
              height: 20.h,
              child: Text(
                title,
                style: CustomStyle.textBold36.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 12.sp,
                    fontWeight: mediumFontWeight),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: 14.w,
          ),
          Flexible(
            child: SvgPicture.asset(
              value,
              width: 30.w,
              height: 30.h,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
