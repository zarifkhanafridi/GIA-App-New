import 'package:academy/View/commonPage/splash_screen.dart';
import 'package:academy/View/studentDashboard/Wallet/DB/db_helper.dart';
import 'package:academy/ViewModel/controllers/auth_controller.dart';
import 'package:academy/routers/routers.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:flutter_prevent_screenshot/disablescreenshot.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kDebugMode) {
    print("Screenshot protection ON (globally from main)");
    final _preventScreenshot = FlutterPreventScreenshot.instance;
    // Prevent screenshots globally
    await _preventScreenshot.screenshotOff();
  }
  if (kDebugMode) {
    print("Screenshot protection OFF (globally from main)");
  }
  await PersistentShoppingCart().init();
  await Hive.initFlutter();
  await Hive.openBox('box');
  await Hive.openBox('userBox');

  await DBHelper.internal();
  final String languageCode = Hive.box('box').get('lang_code') ?? '';
  final String local = Hive.box('box').get('local') ?? '';

  runApp(MyApp(
    languageCode: languageCode,
    local: local,
  ));
}

class MyApp extends StatelessWidget {
  final String? languageCode, local;

  const MyApp({
    super.key,
    this.languageCode,
    this.local,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent: true);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GIA',
            locale: languageCode == '' && local == ''
                ? Locale('en', 'US')
                : Locale(local!, languageCode),
            theme: ThemeData(
              dialogBackgroundColor: AppColors.whiteColor,
              dialogTheme: DialogTheme(
                backgroundColor: AppColors.whiteColor,
                surfaceTintColor: AppColors.whiteColor,
              ),
              appBarTheme: AppBarTheme(surfaceTintColor: AppColors.whiteColor),
              canvasColor: Colors.transparent,
              datePickerTheme: DatePickerThemeData(
                backgroundColor: AppColors.whiteColor,
              ),
            ),
            getPages: AppRoutes.appRoute(),
            // initialBinding: InitialBinding(),
            home: SplashPage(), // Commented out for testing
            // // TEST: Use initialRoute to test video directly
            // initialRoute: RouteName.testVideoScreen,
          );
        });
  }
}
