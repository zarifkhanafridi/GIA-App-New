import 'dart:developer';

import 'package:academy/View/studentDashboard/student_dashbaord.dart';
import 'package:academy/ViewModel/controllers/getmycourses_controller.dart';
import 'package:academy/ViewModel/controllers/offercourse_controller.dart';
import 'package:academy/ViewModel/controllers/payment_controller.dart';
import 'package:academy/ViewModel/controllers/result_controller.dart';
import 'package:academy/ViewModel/controllers/test_controller.dart';
import 'package:academy/ViewModel/services/auth_services.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/auth_repo.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:academy/util/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthController extends GetxController {
  Rx<AppStatus> appStatus = AppStatus.LOADING.obs;
  AuthServices _authServices = AuthServices();
  RxBool isLoading = false.obs;
  RxString errorText = ''.obs;
  void setIsLoading(bool _value) => isLoading.value = _value;
  void setAppStatus(AppStatus _value) => appStatus.value = _value;
  void setError(String _errorValue) => errorText.value = _errorValue;
  final _authRepo = AuthRepository();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  RxString appVersion = ''.obs;
  RxString imeiNo = ''.obs;
  String isLogin = '';
  @override
  void onInit() {
    super.onInit();
    isLogin = Hive.box('userBox').get('token') ?? '';
    gettingIMEIData();

    checkAppVer();
  }

  checkAppVer() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appver = packageInfo.version;

    log(appver); // Log the app version
    appVersion.value =
        appver; // Update the reactive value (if using GetX or similar)

    // Store app version in Hive
    Hive.box('userBox').put('appVersion', appver);
    final storedAppVersion = Hive.box('userBox').get('appVersion');
    log("Stored app version is $storedAppVersion");
  }

  gettingIMEIData() async {
    androidInfo = await deviceInfo.androidInfo;
    imeiNo.value = androidInfo!.id.toString();
    Hive.box('userBox').put('imei', imeiNo.value.toString());
    final Imei = Hive.box('userBox').get(
      'imei',
    );
    print("imei no is $Imei");

    print(imeiNo.value.toString());
  }

  void initControllers() {
    Get.put(OfferCourseController(), permanent: true);
    Get.put(GetMyCoursesController(), permanent: true);
    Get.put(TestController(), permanent: true);
    Get.put(ResultController(), permanent: true);
    Get.put(PaymentController(), permanent: true);
  }

  Future<void> loginMethod(
      {required String email, required String password}) async {
    try {
      setIsLoading(true);
      final mapData = {
        "email": email,
        "password": password,
        "device_imei": imeiNo.value.toString()
      };
      await _authRepo.signInMethod(data: mapData).then((value) {
        log(value['success'].toString() + " success");
        log("sdsasdas");

//UP1A.231005.007
        if (value['success'].toString() == 'true') {
          setIsLoading(false);

          Hive.box('userBox').put('token', value['message']['token']);
          Hive.box('userBox').put('reg_no', value['message']['reg_no']);
          isLogin = Hive.box('userBox').get('token').toString();
          update();
          log(isLogin.toString() + " islogin");
          _authServices.logDataSave(responseData: value['message']);
          initControllers();
          fluttersToast(
              msg: 'User successfully SignIn',
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          Get.to(() => HomePage());
          // Get.back();
        } else if (value['success'].toString() == 'false') {
          setIsLoading(false);
          log(value['message']);
          if (value['is_log_out'] == 1) {
            fluttersToast(
                msg: value['message'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);

            setIsLoading(false);
          }
          if (value['data']['email'].toString().contains('email') == true) {
            fluttersToast(
                msg: value['data']['email'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          } else if (value['data']['password']
                  .toString()
                  .contains('password') ==
              true) {
            fluttersToast(
                msg: value['data']['password'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          } else {
            fluttersToast(
                msg: value['message'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);

            setIsLoading(false);
          }
        } else {
          fluttersToast(
              msg: value['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);

          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from loginMethod :" + e.toString());
    }
  }

  Future<void> registerMethod(
      {required String email,
      required String password,
      required String confirmPassword,
      required String name,
      required String phoneNumber,
      required String gender,
      required String fName}) async {
    try {
      setIsLoading(true);
      final mapData = {
        "name": name,
        "contact_no": phoneNumber,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "gender": gender,
        "fname": fName,
      };
      await _authRepo.signUpMethod(data: mapData).then((value) {
        if (value['success'].toString() == 'true') {
          setIsLoading(false);
          log(value.toString() + " mydata");
          Hive.box('userBox').put('token', value['data']['token'].toString());

          isLogin = Hive.box('userBox').get('token').toString();

          update();
          _authServices.registerDataSave(responseData: value['data']);

          fluttersToast(
              msg: value['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          initControllers();
          Get.back();
          Get.back();
        } else {
          log('else ' + value.toString());
          if (value['is_log_out'] == 1) {
            fluttersToast(
                msg: value['message'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);

            setIsLoading(false);
          }
          log(value['message'].toString());
          if (value['message']['name'].toString().contains('name') == true) {
            fluttersToast(
                msg: value['message']['name'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          } else if (value['message']['email'].toString().contains('email') ==
              true) {
            fluttersToast(
                msg: value['message']['email'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          } else if (value['message']['password']
                  .toString()
                  .contains('password') ==
              true) {
            fluttersToast(
                msg: value['message']['password'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          } else if (value['message']['contact']
                  .toString()
                  .contains('contact') ==
              true) {
            fluttersToast(
                msg: value['message']['contact'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          } else {
            fluttersToast(
                msg: 'All fields is required',
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          }

          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from register Method :" + e.toString());
    }
  }

  Future<void> forgotMethod({
    required String email,
  }) async {
    try {
      setIsLoading(true);
      final mapData = {
        "email": email,
      };
      await _authRepo.forgetMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          _authServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);

          // Get.toNamed(RouteName.sendEmailCodeView, arguments: [
          //   email,
          // ]);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from forgot Method :" + e.toString());
    }
  }

  Future<void> resendCodeMethod({
    required String resetCodeToken,
  }) async {
    try {
      setIsLoading(true);
      final mapData = {
        "reset_code_token": resetCodeToken,
      };
      await _authRepo.resendCodeMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          _authServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from resend code Method :" + e.toString());
    }
  }

  Future<void> resetPasswordMethod(
      {required String resetCodeToken,
      required String resetCode,
      required String password,
      required String passwordConfirmation}) async {
    try {
      setIsLoading(true);
      final mapData = {
        "reset_code": resetCode,
        "reset_code_token": resetCodeToken,
        "password": password,
        "password_confirmation": passwordConfirmation
      };
      await _authRepo.resetPasswordMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          // AuthServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else if (value['statusCode'].toString() == '404') {
          setIsLoading(false);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from resend code Method :" + e.toString());
    }
  }

  Future<void> updatePassword(
      {required String password, required String passwordConfirmation}) async {
    try {
      setIsLoading(true);
      final mapData = {
        "password": password,
        "password_confirmation": passwordConfirmation
      };
      await _authRepo.updatePasswordMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          // AuthServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else if (value['statusCode'].toString() == '404') {
          setIsLoading(false);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from resend code Method :" + e.toString());
    }
  }

  Future<void> logoutMethod() async {
    try {
      setIsLoading(true);

      await _authRepo.logout().then((value) async {
        if (value['success'].toString() == 'true') {
          setIsLoading(false);

          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          _authServices.logoutUserData();
          // await _googleSignIn.signOut();
          Get.delete<GetMyCoursesController>(force: true);
          Get.delete<OfferCourseController>(force: true);
          Get.delete<TestController>(force: true);
          Get.delete<ResultController>(force: true);
          Get.delete<PaymentController>(force: true);
          isLogin = '';
          update();

          update();
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          Get.back<void>();
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from logout Method :" + e.toString());
    }
  }
}
