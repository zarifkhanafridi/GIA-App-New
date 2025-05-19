import 'package:academy/View/commonPage/Login/login_screen.dart';
import 'package:academy/View/commonPage/forget_password.dart';
import 'package:academy/View/commonPage/reset_password.dart';
import 'package:academy/View/commonPage/singup_page.dart';
import 'package:academy/View/commonPage/splash_screen.dart';
import 'package:academy/View/studentDashboard/Books/books.dart';
import 'package:academy/View/studentDashboard/BuyTest/buy_test_page.dart';
import 'package:academy/View/studentDashboard/Courses/courses_albums_page.dart';
import 'package:academy/View/studentDashboard/Courses/courses_page.dart';
import 'package:academy/View/studentDashboard/Courses/courses_videos_page.dart';
import 'package:academy/View/studentDashboard/OnlineTest/getcourses_test_page.dart';
import 'package:academy/View/studentDashboard/OnlineTest/online_test_page.dart';
import 'package:academy/View/studentDashboard/OnlineTest/online_test_page_card_section.dart';
import 'package:academy/View/studentDashboard/Result%20Report/final_test_page.dart';
import 'package:academy/View/studentDashboard/Result%20Report/finaltest_detail_page.dart';
import 'package:academy/View/studentDashboard/Result%20Report/my_test_result_page.dart';
import 'package:academy/View/studentDashboard/Result%20Report/result_page.dart';
import 'package:academy/View/studentDashboard/Wallet/mywallet_page.dart';
import 'package:academy/View/studentDashboard/Wallet/payment_page.dart';
import 'package:academy/View/studentDashboard/offercourses/courses_list_page.dart';
import 'package:academy/View/studentDashboard/offercourses/widgets/single_courses_list_detail.dart';
import 'package:academy/View/studentDashboard/student_dashbaord.dart';
import 'package:academy/ViewModel/controllers/forgot_password_controller.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static appRoute() => [
        GetPage(
          name: RouteName.splashPage,
          page: () => const SplashPage(),
        ),
        GetPage(
          name: RouteName.homePage,
          page: () => HomePage(),
        ),
        GetPage(
          name: RouteName.loginPage,
          page: () => LoginPage(),
        ),
        GetPage(
          name: RouteName.signUpPage,
          page: () => SignUpPage(),
        ),
        GetPage(
          name: RouteName.forgetPage,
          page: () => ForgetPage(),
        ),
    GetPage(
      name: RouteName.resetPassword,
      page: () {
        // You can pass the code dynamically when navigating
        final code = Get.parameters['code']!;
        return ResetPassword(code: verifyCode(code: code));
      },
    ),


    GetPage(
          name: RouteName.coursesPage,
          page: () => CoursesPage(),
        ),
        GetPage(
          name: RouteName.booksPage,
          page: () => BooksPage(),
        ),
        GetPage(
          name: RouteName.resultPage,
          page: () => ResultPage(),
        ),
        GetPage(
          name: RouteName.onlineTestPage,
          page: () => OnlineTestPage(),
        ),
        GetPage(
          name: RouteName.onlineTestPageCardView,
          page: () => OnlineTestPageCardSection(),
        ),
        GetPage(
          name: RouteName.paymentPage,
          page: () => PaymentPage(),
        ),
        GetPage(
          name: RouteName.offerCoursesListPage,
          page: () => OfferCoursesListPage(),
        ),
        GetPage(
          name: RouteName.singleCoursesListDetailPage,
          page: () => SingleCoursesListDetailPage(),
        ),
        GetPage(
          name: RouteName.coursesAlbumsPage,
          page: () => CoursesAlbumsPage(),
        ),
        GetPage(
          name: RouteName.coursesVideosPage,
          page: () => CoursesVideosPage(),
        ),
        GetPage(
          name: RouteName.getCoursesTestPage,
          page: () => GetCoursesTestPage(),
        ),
        GetPage(
          name: RouteName.myTestResultPage,
          page: () => MyTestResultPage(),
        ),
        GetPage(
          name: RouteName.finalTestReportPage,
          page: () => FinalTestReportPage(),
        ),
        GetPage(
          name: RouteName.finalTestDetailPage,
          page: () => FinalTestDetailPage(),
        ),
        GetPage(
          name: RouteName.buyTestPage,
          page: () => BuyTestPage(),
        ),
        GetPage(
          name: RouteName.myWalletPage,
          page: () => MyWalletPage(),
        ),
      ];
}
