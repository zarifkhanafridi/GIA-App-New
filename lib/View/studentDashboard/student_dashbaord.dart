import 'dart:developer';

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/offercourse_controller.dart';
import 'package:academy/data/Model/offerCourses/courses_offer_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/images_urls.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'nav_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color decoration = Colors.black.withAlpha(100);
  String? currentSection, image, currentCampus, stdId, uName;
  @override
  void initState() {
    super.initState();

    fetchStudent();
    print('Student DashBoard');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      offerC.getAllCoursesOfferList();
    });
  }

  fetchStudent() {
    // currentSection = Hive.box('box').get('current_section');
    // currentCampus = Hive.box('box').get('current_campus');
    stdId = Hive.box('userBox').get('stId');
    image = Hive.box('userBox').get('sEmail');
    uName = Hive.box('userBox').get('sName');
  }

  final OfferCourseController offerC = Get.find<OfferCourseController>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: AppColors.kDarkBlue,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Offered Courses',
            style:
                CustomStyle.textSemiBold15.copyWith(color: AppColors.kDarkBlue),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.myWalletPage);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  ImagePath.cardIcon,
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       Icons.shopping_bag,
            //       size: 30.sp,
            //       color: AppColors.kLightBlue,
            //     ))
          ],
        ),
        drawer: NavDrawer(
          // currentCampus: currentCampus!,
          // currentClass: currentClass!,
          // currentSection: currentSection!,
          // image: image!,
          // uName: uName!,
          sid: "id: " + stdId.toString(),

          image:
              'https://www.westonloangroup.com/wp-content/uploads/2015/09/Headshot-Man.jpg',
          uName: uName.toString(),
        ),
        body: Obx(() => offerC.appStatusCoursesOffer.value == AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10).copyWith(top: 44.h),
                child: AnimationLimiter(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: offerC.coursesOfferList.length,
                      itemBuilder: (context, index) {
                        Category categoryModel = offerC.coursesOfferList[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(),
                            child: SlideAnimation(
                              verticalOffset: 44.0,
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    log(
                                      "categoryModel id" +
                                          categoryModel.mscatId.toString(),
                                    );
                                    offerC.getCurrentCoursesList(
                                      categoryId:
                                          categoryModel.mscatId.toString(),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              AppColors.kDarkBlue,
                                              AppColors.kDarkBlue,
                                              AppColors.kLightBlue
                                              // LightColors.kLightYellow,

                                              // Colors.redAccent[200],
                                              // Colors.greenAccent[300],
                                            ]),
                                        border: Border.all(
                                            color: Colors.white, width: 1.w)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0)
                                                    .copyWith(bottom: 10.h),
                                                child: Text(
                                                  categoryModel.catName
                                                      .toString(),
                                                  style: CustomStyle
                                                      .textRegular15
                                                      .copyWith(
                                                          color: AppColors
                                                              .whiteColor),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0)
                                                        .copyWith(top: 6.h),
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 250, 250, 250),
                                                    foregroundColor:
                                                        const Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                  ),
                                                  onPressed: () {
                                                    offerC
                                                        .getCurrentCoursesList(
                                                      categoryId: categoryModel
                                                          .mscatId
                                                          .toString(),
                                                    );
                                                    Get.toNamed(
                                                      RouteName
                                                          .offerCoursesListPage,
                                                    );
                                                  },
                                                  child: Text(
                                                    'View Course',
                                                    style: CustomStyle
                                                        .textSemiBold15
                                                        .copyWith(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .blackColor),
                                                  ),
                                                ),
                                              ),
                                            )
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
                ),
              )),
      ),
    );
  }
}
