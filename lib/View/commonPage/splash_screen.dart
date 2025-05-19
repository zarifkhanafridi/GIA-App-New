import 'package:academy/View/commonPage/authwrapper.dart';
import 'package:academy/View/commonPage/background.dart';
import 'package:academy/res/images_urls.dart';
import 'package:academy/res/typography.dart';
import 'package:academy/theme/colors/light_colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLogin = false;

  @override
  void initState() {
    checkLog();

    super.initState();
  }

  checkLog() {
    Future.delayed(Duration(seconds: 4), () async {
      Get.offAll(() => AuthWrapper());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 34.h),
              AnimatedContainer(
                  decoration: BoxDecoration(),
                  duration: Duration(seconds: 1),
                  height: 250.h,
                  width: 300.w,
                  child: Image.asset(
                    ImagePath.logoImage,
                    fit: BoxFit.contain,
                    width: 45.w,
                    height: 45.h,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.transparent,
                      strokeWidth: 2.0, // Adjust the thickness of the indicator

                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.kDarkBlue),
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Divider(),
                  SizedBox(height: 34.h),
                  Text(
                    'Academes & Colleges',
                    style: CustomStyle.textSemiBold15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
