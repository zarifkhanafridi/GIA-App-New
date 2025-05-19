import 'dart:developer';

import 'package:academy/data/Model/offerCourses/courses_offer_model.dart';
import 'package:academy/data/Model/offerCourses/offer_courses_list_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/offer_courses_repo.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:academy/util/utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class OfferCourseController extends GetxController {
  final offerRepo = OfferCourseRepository();
  final Rx<List<Category>> _coursesOfferList = Rx<List<Category>>([]);
  List<Category> get coursesOfferList => _coursesOfferList.value;

  @override
  void onInit() {
    super.onInit();
    getAllCoursesOfferList();
  }

  RxString errorCoursesOfferText = ''.obs;
  Rx<AppStatus> appStatusCoursesOffer = AppStatus.LOADING.obs;
  void setCoursesOfferAppStatus(AppStatus _value) =>
      appStatusCoursesOffer.value = _value;
  void setErrorCoursesOffer(String _errorValue) =>
      errorCoursesOfferText.value = _errorValue;
  void setCoursesOfferList(List<Category> _value) =>
      _coursesOfferList.value = _value;

  /// setting courses List Model
  final Rx<List<CourseList>> _coursesList = Rx<List<CourseList>>([]);
  List<CourseList> get coursesList => _coursesList.value;

  RxString errorCoursesListText = ''.obs;
  Rx<AppStatus> appStatusCoursesList = AppStatus.LOADING.obs;
  void setCoursesListAppStatus(AppStatus _value) =>
      appStatusCoursesList.value = _value;
  void setErrorCoursesList(String _errorValue) =>
      errorCoursesListText.value = _errorValue;
  void setCoursesList(List<CourseList> _value) => _coursesList.value = _value;

  Future<void> getAllCoursesOfferList() async {
    try {
      setCoursesOfferAppStatus(AppStatus.LOADING);

      await offerRepo.coursesOfferMethod().then((value) {
        if (value['success'].toString() == 'true') {
          coursesOfferModel res = coursesOfferModel.fromJson(value);
          log(value['success'].toString());
          print(value['success'].toString());
          setCoursesOfferList(res.data!.category!);

          setCoursesOfferAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          if (value["is_log_out"] == 1) {
            Hive.box('userBox').clear();
            Get.offNamed(RouteName.loginPage);
            fluttersToast(
                msg: value['message'].toString(),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.darkGreyColor);
          }
          setErrorCoursesOffer(value['message'].toString());
          setCoursesOfferAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorCoursesOffer(value['message'].toString());
          setCoursesOfferAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorCoursesOffer(error.toString());
        setCoursesOfferAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('coursesOffer  controller side error' + e.toString());
    }
  }

  Future<void> getCurrentCoursesList({required String categoryId}) async {
    try {
      setCoursesListAppStatus(AppStatus.LOADING);
      // log('message before');
      var data = {'category_id': categoryId};
      print(categoryId);
      await offerRepo.getCoursesListMethod(data: data).then((value) {
        if (value['success'].toString() == 'true') {
          OfferCoursesListModel res = OfferCoursesListModel.fromJson(value);

          setCoursesList(res.data!);
          log(res.data!.toString());
          Get.toNamed(
            RouteName.offerCoursesListPage,
          );
          setCoursesListAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          print("dddddddddddddddddddddddddd");
          setErrorCoursesList(value['message'].toString());
          setCoursesListAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorCoursesList(value['message'].toString());
          setCoursesListAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorCoursesList(error.toString());
        setCoursesListAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('courses list controller side error' + e.toString());
      setErrorCoursesList('something went wrong');
      setCoursesListAppStatus(AppStatus.ERROR);
    }
  }
}
