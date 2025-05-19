import 'dart:developer';

import 'package:academy/data/Model/result/my_final_results.dart';
import 'package:academy/data/Model/result/my_results_tests.dart';
import 'package:academy/data/Model/result/myresult_courses.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/result_repo.dart';
import 'package:get/get.dart';

class ResultController extends GetxController {
  final resultRepo = ResultRepository();
  final Rx<List<MyResultCoursesList>> _myResultCoursesList =
      Rx<List<MyResultCoursesList>>([]);
  List<MyResultCoursesList> get myResultCoursesList =>
      _myResultCoursesList.value;
  RxString errorMyResultCoursesText = ''.obs;
  Rx<AppStatus> appStatusMyResultCoursesList = AppStatus.LOADING.obs;
  void setMyResultCoursesListAppStatus(AppStatus _value) =>
      appStatusMyResultCoursesList.value = _value;
  void setErrorMyResultCoursesList(String _errorValue) =>
      errorMyResultCoursesText.value = _errorValue;
  void setMyResultCoursesList(List<MyResultCoursesList> _value) =>
      _myResultCoursesList.value = _value;

  // ////////////////////////////////////////////////////////////////////////////////////////
  final Rx<List<MyResultTestModelList>> _myResultTestModelList =
      Rx<List<MyResultTestModelList>>([]);
  List<MyResultTestModelList> get myResultTestModelList =>
      _myResultTestModelList.value;
  RxString errorMyResultTestModelText = ''.obs;
  Rx<AppStatus> appStatusMyResultTestModelList = AppStatus.LOADING.obs;
  void setMyResultTestModelAppStatus(AppStatus _value) =>
      appStatusMyResultTestModelList.value = _value;
  void setErrorMyResultTestModel(String _errorValue) =>
      errorMyResultTestModelText.value = _errorValue;
  void setMyResultTestModelList(List<MyResultTestModelList> _value) =>
      _myResultTestModelList.value = _value;

///////////////////////////////////////////////////////////////////////////////////////////////
  final Rx<FinalTestDetail?> _finalTestDetailModel = Rx<FinalTestDetail?>(null);
  FinalTestDetail? get finalTestDetailModel => _finalTestDetailModel.value;
  RxString errorFinalTestDetailModelText = ''.obs;
  Rx<AppStatus> appStatusFinalTestDetailModel = AppStatus.LOADING.obs;
  void setFinalTestDetailModelAppStatus(AppStatus _value) =>
      appStatusFinalTestDetailModel.value = _value;
  void setErrorFinalTestDetailModel(String _errorValue) =>
      errorFinalTestDetailModelText.value = _errorValue;
  void setFinalTestDetailModel(FinalTestDetail _value) =>
      _finalTestDetailModel.value = _value;

  Future<void> myResultsCoursesList() async {
    try {
      setMyResultCoursesListAppStatus(AppStatus.LOADING);

      await resultRepo.myResultsCourses().then((value) {
        if (value['success'].toString() == 'true') {
          MyResultsCoursesModel res = MyResultsCoursesModel.fromJson(value);
          log(value['success'].toString());
          setMyResultCoursesList(res.data!);

          setMyResultCoursesListAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorMyResultCoursesList(value['message'].toString());
          setMyResultCoursesListAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorMyResultCoursesList(value['message'].toString());
          setMyResultCoursesListAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorMyResultCoursesList(error.toString());
        setMyResultCoursesListAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setMyResultCoursesListAppStatus(AppStatus.ERROR);
      log('Result controller side error' + e.toString());
    }
  }

  Future<void> myResultsTestListApi({required String courseId}) async {
    try {
      setMyResultTestModelAppStatus(AppStatus.LOADING);
      var data = {'course_id': courseId};
      await resultRepo.myResultsTests(data: data).then((value) {
        if (value['success'].toString() == 'true') {
          MyResultsTestsModel res = MyResultsTestsModel.fromJson(value);
          log(value['success'].toString());
          setMyResultTestModelList(res.data!);

          setMyResultTestModelAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorMyResultTestModel(value['message'].toString());
          setMyResultTestModelAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorMyResultTestModel(value['message'].toString());
          setMyResultTestModelAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorMyResultTestModel(error.toString());
        setMyResultTestModelAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setMyResultTestModelAppStatus(AppStatus.ERROR);
      log('Result controller side error' + e.toString());
    }
  }

  Future<void> myFinalResultApi({required String test_id}) async {
    try {
      setFinalTestDetailModelAppStatus(AppStatus.LOADING);
      var data = {'group_test_id': test_id};
      await resultRepo.myFinalResults(data: data).then((value) {
        if (value['success'].toString() == 'true') {
          MyFinalResultsModel res = MyFinalResultsModel.fromJson(value);
          log(value['success'].toString());
          setFinalTestDetailModel(res.data!);

          setFinalTestDetailModelAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorFinalTestDetailModel(value['message'].toString());
          setFinalTestDetailModelAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorFinalTestDetailModel(value['message'].toString());
          setFinalTestDetailModelAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorFinalTestDetailModel(error.toString());
        setFinalTestDetailModelAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setFinalTestDetailModelAppStatus(AppStatus.ERROR);
      log('Result controller side error' + e.toString());
    }
  }
}
