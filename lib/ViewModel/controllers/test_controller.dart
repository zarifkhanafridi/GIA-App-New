import 'dart:developer';

import 'package:academy/View/studentDashboard/OnlineTest/quizScreen/quiz_screen.dart';
import 'package:academy/ViewModel/controllers/result_controller.dart';
import 'package:academy/data/Model/TestModel/getcourse_test_model.dart';
import 'package:academy/data/Model/TestModel/question_test_model.dart';
import 'package:academy/data/Model/TestModel/test_info_model.dart';
import 'package:academy/data/Model/TestModel/test_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/test_repo.dart';
import 'package:academy/routers/routers_name.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:academy/util/utils.dart';
import 'package:get/get.dart';


class TestController extends GetxController {
  TestRepository testRepo = TestRepository();
  final Rx<List<GetAllTestList>> _getCoursesTestList =
      Rx<List<GetAllTestList>>([]);
  ResultController get resultController => Get.find<ResultController>();
  List<GetAllTestList> get getAllTestList => _getCoursesTestList.value;
  RxString errorGetAllTestText = ''.obs;
  Rx<AppStatus> appStatusGetAllTestList = AppStatus.LOADING.obs;
  void setGetAllTestListAppStatus(AppStatus _value) =>
      appStatusGetAllTestList.value = _value;
  void setErrorGetAllTestList(String _errorValue) =>
      errorGetAllTestText.value = _errorValue;
  void setGetAllTestList(List<GetAllTestList> _value) =>
      _getCoursesTestList.value = _value;
  RxBool isAnswersPost = false.obs;
////////////////////////////////////////////////////////////////
  final Rx<List<GetCoursesTextList>> _getAllCoursesTestList =
      Rx<List<GetCoursesTextList>>([]);
  List<GetCoursesTextList> get getAllCoursesTestList =>
      _getAllCoursesTestList.value;
  RxString errorGetCoursesTestText = ''.obs;
  Rx<AppStatus> appStatusGetAllCoursesTestList = AppStatus.LOADING.obs;
  void setCoursesTestAppStatus(AppStatus _value) =>
      appStatusGetAllCoursesTestList.value = _value;
  void setErrorCoursesTest(String _errorValue) =>
      errorGetCoursesTestText.value = _errorValue;
  void setCoursesTestList(List<GetCoursesTextList> _value) =>
      _getAllCoursesTestList.value = _value;

///////////////////////////////////////////////////////////////////////
  final Rx<TestInfo?> _testInfoModel = Rx<TestInfo?>(null);
  TestInfo? get testInfoModel => _testInfoModel.value;
  RxString errorTestInfoText = ''.obs;
  Rx<AppStatus> appStatusTestInfo = AppStatus.LOADING.obs;
  void setTestInfoAppStatus(AppStatus _value) =>
      appStatusTestInfo.value = _value;
  void setErrorTestInfoTest(String _errorValue) =>
      errorTestInfoText.value = _errorValue;
  void setTestInfoList(TestInfo _value) => _testInfoModel.value = _value;
///////////////////////////////////////////////////////////////////////
  final Rx<List<QuestionModelList>> _questionModel =
      Rx<List<QuestionModelList>>([]);
  List<QuestionModelList> get questionModelList => _questionModel.value;
  RxString errorQuestionModel = ''.obs;
  Rx<AppStatus> appStatusQuestionModel = AppStatus.LOADING.obs;
  void setQuestionModelAppStatus(AppStatus _value) =>
      appStatusQuestionModel.value = _value;
  void setErrorQuestionModel(String _errorValue) =>
      errorQuestionModel.value = _errorValue;
  void setQuestionModel(List<QuestionModelList> _value) =>
      _questionModel.value = _value;
  RxBool isStart = false.obs;

  Future<void> getAllMyCoursesList(String index) async {
    try {
      setGetAllTestListAppStatus(AppStatus.LOADING);

      await testRepo.getAllTestApiMethod(index).then((value) {
        if (value['success'].toString() == 'true') {
          TestModel res = TestModel.fromJson(value);
          log(value['success'].toString());
          setGetAllTestList(res.data!);

          setGetAllTestListAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorGetAllTestList(value['message'].toString());
          setGetAllTestListAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorGetAllTestList(value['message'].toString());
          setGetAllTestListAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorGetAllTestList(error.toString());
        setGetAllTestListAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setGetAllTestListAppStatus(AppStatus.ERROR);
      log('Test controller side error' + e.toString());
    }
  }

  Future<void> getCourseTestsApi({required String id}) async {
    try {
      setCoursesTestAppStatus(AppStatus.LOADING);

      await testRepo.getCourseTestMethod(id: id).then((value) {
        if (value['success'].toString() == 'true') {
          GetCourseTestsModel res = GetCourseTestsModel.fromJson(value);
          log(value['success'].toString());
          setCoursesTestList(res.data!);

          setCoursesTestAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorCoursesTest(value['message'].toString());
          setCoursesTestAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorCoursesTest(value['message'].toString());
          setCoursesTestAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorCoursesTest(error.toString());
        setCoursesTestAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setCoursesTestAppStatus(AppStatus.ERROR);
      log('Test controller side error' + e.toString());
    }
  }

  Future<void> getTestInoApi({required String id}) async {
    try {
      setTestInfoAppStatus(AppStatus.LOADING);

      await testRepo.getTestInfoMethod(id: id).then((value) {
        log(value.toString() + "mydata");
        if (value['success'] == true) {
          log('message');
          TestInfoModel res = TestInfoModel.fromJson(value);
          log(" data");
          setTestInfoList(res.data!);

          setTestInfoAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorTestInfoTest(value['message'].toString());
          setTestInfoAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorTestInfoTest(value['message'].toString());
          setTestInfoAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorTestInfoTest(error.toString());
        setTestInfoAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setTestInfoAppStatus(AppStatus.ERROR);
      log('Test controller side error' + e.toString());
    }
  }

  Future<void> testStartApi({required String id}) async {
    try {
      // setTestInfoAppStatus(AppStatus.LOADING);
      isStart.value = true;
      await testRepo.getStartTestMethod(id: id).then((value) {
        if (value['success'].toString() == 'true') {
          isStart.value = false;
          TestInfoModel res = TestInfoModel.fromJson(value);
          log(value['success'].toString());
          setTestInfoList(res.data!);
          Get.back();
          fluttersToast(
              msg: 'successfully Test Start',
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          // setTestInfoAppStatus(AppStatus.COMPLETED);
          Get.to(
            () => QuizScreen(
              id: testInfoModel!.testGroupId.toString(),
              time: int.parse(testInfoModel!.totalTime.toString()),
            ),
          );
        } else if (value['success'].toString() == 'false') {
          // setErrorTestInfoTest(value['message'].toString());
          // setTestInfoAppStatus(AppStatus.ERROR);
          fluttersToast(
              msg: value['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          isStart.value = false;
        } else {
          log(value['message'].toString());
          // setErrorTestInfoTest(value['message'].toString());
          // setTestInfoAppStatus(AppStatus.ERROR);
          isStart.value = false;
        }
      }).onError((error, stackTrace) {
        // setErrorTestInfoTest(error.toString());
        // setTestInfoAppStatus(AppStatus.ERROR);
        isStart.value = false;
      });
    } catch (e) {
      // setTestInfoAppStatus(AppStatus.ERROR);
      log('Test controller side error' + e.toString());
      isStart.value = false;
    }
  }

  Future<void> getAllTestQuestionsApi({required String questionId}) async {
    try {
      setQuestionModelAppStatus(AppStatus.LOADING);

      await testRepo
          .getAllTestQuestionsMethod(questionId: questionId)
          .then((value) {
        log(' before');
        if (value['success'].toString() == 'true') {
          QuestionTestModel res = QuestionTestModel.fromJson(value);

          setQuestionModel(res.data!);

          setQuestionModelAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorQuestionModel(value['message'].toString());
          setQuestionModelAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorQuestionModel(value['message'].toString());
          setQuestionModelAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorQuestionModel(error.toString());
        setQuestionModelAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setQuestionModelAppStatus(AppStatus.ERROR);
      log('Test controller side error' + e.toString());
    }
  }

  Future<void> postAllAnswersApi(
      {required var data, required String testId}) async {
    try {
      isAnswersPost.value = true;

      await testRepo
          .postAllAnswersMethod(data: data, testId: testId)
          .then((value) async {
        isAnswersPost.value = false;
        fluttersToast(
            msg: value['message'].toString(),
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        log(' before');
        Get.toNamed(RouteName.finalTestReportPage, arguments: [testId, true]);
      }).onError((error, stackTrace) {
        isAnswersPost.value = false;
      });
    } catch (e) {
      isAnswersPost.value = false;
      log('Test controller side error' + e.toString());
    }
  }
}
