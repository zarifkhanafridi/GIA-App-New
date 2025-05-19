import 'package:html/parser.dart';

String baseUrl = 'https://gislamian.pk/api/';
String versionApi = 'v1/';
String loginApi = baseUrl + versionApi + "login";
String registerApi = baseUrl + versionApi + "register";
String forgotPasswordApi = baseUrl + versionApi + "forgot-password";
String resetPasswordApi = baseUrl + versionApi + "reset-password";
String resendCodeApi = baseUrl + versionApi + "resend-code";
String logoutApi = baseUrl + versionApi + "logout";
String ProfileUpdateApi = baseUrl + versionApi + "profile/update";
String ProfileUpdatePasswordApi =
    baseUrl + versionApi + "profile/update-password";
String getAllRestaurantsApi = baseUrl + versionApi + "restaurants";
String detailApi = getAllRestaurantsApi + '/';
String getSearchApi = baseUrl + versionApi + "restaurants/search";
String whishListsApi = baseUrl + versionApi + "whishlists";
String whishListsToggleApi = baseUrl + versionApi + "whishlist";
String getAllReservations = baseUrl + versionApi + "reservations";
String pastApprovedReservationsApi = baseUrl + versionApi + "past-reservations";
String pastCancelledReservationsApi =
    baseUrl + versionApi + 'past-cancelled-reservations';
String bookReservationApi = baseUrl + versionApi + 'book-reservation';
String socialApi = baseUrl + versionApi + 'social-login';
String dashboardCoursesOfferApi = baseUrl + versionApi + 'dashboard';
String courseListApi = baseUrl + versionApi + 'courseList';
String getMyCourseApi = baseUrl + versionApi + 'student/myCourses';
String getMyBookApi = baseUrl + versionApi + 'student/getBooks';
String getFeedBackApi = baseUrl + versionApi + 'student/getCourseRate';
String getFeedBackPostApi = baseUrl + versionApi + 'student/courseRate';
String getCourseByIdApi = baseUrl + versionApi + 'student/getCourseById';
String getCourseAlbumsApi = baseUrl + versionApi + 'student/getCourseAlbums';
String getCourseVideosApi = baseUrl + versionApi + 'student/getCourseVideos';
String getAllTestApi = baseUrl + versionApi + 'student/getGroups';
String getBuyTestApi = baseUrl + versionApi + 'student/getTestFee';
String getCourseTestsApi = baseUrl + versionApi + 'student/getCourseTests';
String testInfoApi = baseUrl + versionApi + 'student/testInfo';
String startTestApi = baseUrl + versionApi + 'student/startTest';
String getAllTestQuestionsApi =
    baseUrl + versionApi + 'student/getTestAllQuestions';
String postAnswersApi = baseUrl + versionApi + 'student/postAnswers';
String myResultsCourseApi = baseUrl + versionApi + 'student/myResultsCourses';
String myResultsTestsApi = baseUrl + versionApi + 'student/myResultsTests';
String myFinalResultsApi = baseUrl + versionApi + 'student/myFinalResults';
String htmlParses({required String value}) {
  var document = parse(value);
  return document.body!.text;
}

String myPaymentsApi = baseUrl + versionApi + 'student/myPayments';
String postInvoiceApi = baseUrl + versionApi + 'student/createInvoice';
String postgetInvoiceById = baseUrl + versionApi + 'student/getInvoiceById';
String myWalletApi = baseUrl + versionApi + 'student/myWallet';
