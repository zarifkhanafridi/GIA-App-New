// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:academy/View/studentDashboard/student_dashbaord.dart';
import 'package:academy/ViewModel/controllers/auth_controller.dart';
import 'package:academy/ViewModel/controllers/offercourse_controller.dart';
import 'package:academy/components/logout_dialog.dart';
import 'package:academy/res/icons.dart';
import 'package:academy/res/images_urls.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NavDrawer extends StatefulWidget {
  String image, sid, uName;
  NavDrawer(
      {Key? key, required this.uName, required this.sid, required this.image})
      : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final OfferCourseController offerC = Get.find<OfferCourseController>();
  final AuthController auth = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.kDarkBlue,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.kDarkBlue.withOpacity(0.5),
              AppColors.kDarkBlue.withOpacity(0.5),
              AppColors.kLightYellow,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(0).copyWith(top: 12.h),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.kDarkBlue.withOpacity(0.5),
                    AppColors.kDarkBlue.withOpacity(0.5),
                  ],
                ),
              ),
              padding: EdgeInsets.all(12).copyWith(bottom: 1.h),
              child: ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 12.w,
                      ),
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      widget.uName,
                      style: TextStyle(color: AppColors.kTextColor),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),

                  Hive.box('userBox').get('reg_no') == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            "Reg#: " +
                                Hive.box('userBox').get('reg_no').toString(),
                            style: TextStyle(color: AppColors.kTextColor),
                          ),
                        ),
                  SizedBox(
                    height: 3.h,
                  ),
                  // Reuasble(title: '', value: widget.sid, isSection: false),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset(
                ImagePath.dashboardIcon,
                width: 35,
                height: 35,
                color: AppColors.whiteColor,
              ),

              // leading: Icon(Icons.input, color: iconColor,),
              title: Text(
                'Home',
                style: TextStyle(color: AppColors.kTextColor, fontSize: 15),
              ),
              onTap: () => {offerC.getAllCoursesOfferList(), Get.back()},
            ),
            ListTile(
              leading: Image.asset(
                ImagePath.courses,
                width: 35,
                height: 35,
              ),
              title: Text(
                'My Courses',
                style: TextStyle(color: AppColors.kTextColor, fontSize: 15),
              ),
              onTap: () => {
                Get.toNamed(RouteName.coursesPage),
              },
            ),
            ListTile(
              leading: Image.asset(
                ImagePath.bookIcon,
                width: 35,
                height: 35,
              ),
              title: Text(
                'Books',
                style: TextStyle(color: AppColors.kTextColor, fontSize: 15),
              ),
              onTap: () => {
                Get.toNamed(RouteName.booksPage),
              },
            ),
            ListTile(
              leading: Image.asset(
                ImagePath.resultIcon,
                width: 35,
                height: 35,
              ),
              title: Text(
                'My Result',
                style: TextStyle(color: AppColors.kTextColor, fontSize: 15),
              ),
              onTap: () => {
                Get.toNamed(RouteName.resultPage),
              },
            ),
            ListTile(
              leading: Image.asset(
                ImagePath.testIcon,
                width: 35,
                height: 35,
              ),
              title: Text(
                'Test',
                style: TextStyle(color: AppColors.kTextColor, fontSize: 15),
              ),
              onTap: () => {
                // Get.toNamed(RouteName.onlineTestPage),
                Get.toNamed(RouteName.onlineTestPageCardView),
              },
            ),
            // ListTile(
            //   leading: Image.asset(
            //     ImagePath.cardIcon,
            //     width: 35,
            //     height: 35,
            //   ),
            //   title: Text(
            //     'Payment Details',
            //     style: TextStyle(color: AppColors.kTextColor, fontSize: 15),
            //   ),
            //   onTap: () => {
            //     Get.toNamed(RouteName.paymentPage),
            //   },
            // ),
            ListTile(
              leading: Image.asset(
                width: 35,
                height: 35,
                ImagePath.existIcon,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: AppColors.whiteColor, fontSize: 15),
              ),
              onTap: () => {Get.back(), Get.dialog(LogOutDialog())},
            ),
            Obx(() => ListTile(
                  leading: SvgPicture.asset(
                    width: 35,
                    height: 35,
                    AppIcons.versionApp,
                    color: AppColors.kTextColor,
                  ),
                  title: Text(
                    'App Version ${auth.appVersion.value.toString()}',
                    style: TextStyle(color: AppColors.kTextColor, fontSize: 15),
                  ),
                  onTap: () {},
                ))
          ],
        ),
      ),
    );
  }
}

class Reuasble extends StatelessWidget {
  final String title;
  final String value;
  final String? value2;
  final bool isSection;
  const Reuasble({
    Key? key,
    required this.title,
    required this.value,
    this.value2,
    required this.isSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSection
        ? Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Text(
                '$value ($value2)',
                style: TextStyle(color: AppColors.kTextColor),
              ))
            ],
          )
        : Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(color: AppColors.kTextColor),
              )
            ],
          );
  }
}
