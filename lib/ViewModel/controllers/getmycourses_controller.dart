import 'dart:developer';

import 'package:academy/data/Model/Courses/course_albums.dart';
import 'package:academy/data/Model/Courses/courses_videos.dart';
import 'package:academy/data/Model/Courses/feedback_model.dart';
import 'package:academy/data/Model/Courses/getmycourses_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/getmycourses_repo.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:academy/util/utils.dart';
import 'package:get/get.dart';

class GetMyCoursesController extends GetxController {
  GetMyCoursesRepository getMyCoursesRepo = GetMyCoursesRepository();

  final Rx<List<GetMyCoursesList>> _getMyCoursesList =
      Rx<List<GetMyCoursesList>>([]);
  List<GetMyCoursesList> get getMyCoursesList => _getMyCoursesList.value;
  RxString errorGetMyCoursesText = ''.obs;
  Rx<AppStatus> appStatusGetMyCourses = AppStatus.LOADING.obs;
  void setGetMyCoursesAppStatus(AppStatus _value) =>
      appStatusGetMyCourses.value = _value;
  void setErrorGetMyCourses(String _errorValue) =>
      errorGetMyCoursesText.value = _errorValue;
  void setGetMyCoursesList(List<GetMyCoursesList> _value) =>
      _getMyCoursesList.value = _value;

//'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''\\
  final Rx<List<AlbumList>> _getAlbumList = Rx<List<AlbumList>>([]);
  List<AlbumList> get getAlbumList => _getAlbumList.value;
  RxString errorAlbumText = ''.obs;
  Rx<AppStatus> appStatusAlbum = AppStatus.LOADING.obs;
  void setAlbumAppStatus(AppStatus _value) => appStatusAlbum.value = _value;
  void setErrorAlbum(String _errorValue) => errorAlbumText.value = _errorValue;
  void setAlbumList(List<AlbumList> _value) => _getAlbumList.value = _value;

// --------------------------------------------------------------------------------\\
  final Rx<List<CoursesVideoList>> _getCoursesVideoList =
      Rx<List<CoursesVideoList>>([]);
  List<CoursesVideoList> get coursesVideoList => _getCoursesVideoList.value;
  RxString errorVideoText = ''.obs;
  Rx<AppStatus> appStatusVideos = AppStatus.LOADING.obs;
  void setVideoAppStatus(AppStatus _value) => appStatusVideos.value = _value;
  void setErrorVideo(String _errorValue) => errorVideoText.value = _errorValue;
  void setVideosList(List<CoursesVideoList> _value) =>
      _getCoursesVideoList.value = _value;

  ///------------------------------------------------------------------------

  final Rx<List<FeedBackList>?> _getFeedBackList = Rx<List<FeedBackList>?>([]);
  List<FeedBackList>? get getFeedBackModel => _getFeedBackList.value;
  RxString errorFeedBackText = ''.obs;
  Rx<AppStatus> appStatusFeedBack = AppStatus.LOADING.obs;
  void setGetFeedBackListAppStatus(AppStatus _value) =>
      appStatusFeedBack.value = _value;
  void setErrorGetFeedBackList(String _errorValue) =>
      errorFeedBackText.value = _errorValue;
  void setFeedBackList(List<FeedBackList> _value) =>
      _getFeedBackList.value = _value;

  ///------------------------------------------------------------------------
  RxBool isFeedBackLoading = false.obs;
  RxString isFeedBackError = ''.obs;

  //----------------------------------------------------------------------
  Future<void> getAllMyCoursesList() async {
    try {
      setGetMyCoursesAppStatus(AppStatus.LOADING);

      await getMyCoursesRepo.getMyCoursesListMethod().then((value) {
        if (value['success'].toString() == 'true') {
          GetMyCoursesModel res = GetMyCoursesModel.fromJson(value);
          log(value['success'].toString());
          setGetMyCoursesList(res.data!);

          setGetMyCoursesAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorGetMyCourses(value['message'].toString());
          setGetMyCoursesAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorGetMyCourses(value['message'].toString());
          setGetMyCoursesAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorGetMyCourses(error.toString());
        setGetMyCoursesAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('get My courses controller side error' + e.toString());
    }
  }

  Future<void> getCourseAlbumsApi({required String course_id}) async {
    try {
      var data = {"course_id": course_id};
      setAlbumAppStatus(AppStatus.LOADING);
      print("there");
      await getMyCoursesRepo.getCourseAlbumsMethod(data: data).then((value) {
        if (value['success'].toString() == 'true') {
          CourseAlbumsModel res = CourseAlbumsModel.fromJson(value);
          log(value['success'].toString());
          setAlbumList(res.data!);

          setAlbumAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorAlbum(value['message'].toString());
          setAlbumAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorAlbum(value['message'].toString());
          setAlbumAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorAlbum(error.toString());
        setAlbumAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setAlbumAppStatus(AppStatus.ERROR);
      log('get My courses controller side error' + e.toString());
    }
  }

  Future<void> getCourseVideosApi({required String album_id}) async {
    try {
      var data = {"album_id": album_id};
      setVideoAppStatus(AppStatus.LOADING);
      log(data.toString());
      await getMyCoursesRepo.getCourseVideosMethod(data: data).then((value) {
        if (value['success'].toString() == 'true') {
          CourseVideosModel res = CourseVideosModel.fromJson(value);
          log(value['success'].toString());
          setVideosList(res.data!);

          setVideoAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorVideo(value['message'].toString());
          setVideoAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorVideo(value['message'].toString());
          setVideoAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorVideo(error.toString());
        setVideoAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setVideoAppStatus(AppStatus.ERROR);
      log('get My courses controller side error' + e.toString());
    }
  }

  Future<void> getStudentFeedBackApi({required String courseId}) async {
    try {
      setGetFeedBackListAppStatus(AppStatus.LOADING);

      await getMyCoursesRepo.getFeedbackMethod(id: courseId).then((value) {
        if (value['success'].toString() == 'true') {
          FeedBackCoursesModel res = FeedBackCoursesModel.fromJson(value);
          log(value['success'].toString());
          setFeedBackList(res.data!);

          setGetFeedBackListAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorGetFeedBackList(value['message'].toString());
          setGetFeedBackListAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorGetFeedBackList(value['message'].toString());
          setGetFeedBackListAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorGetFeedBackList(error.toString());
        setGetFeedBackListAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setGetFeedBackListAppStatus(AppStatus.ERROR);
      log('get My courses controller side error' + e.toString());
    }
  }

  Future<void> postFeedBackApi(
      {required String course_id,
      required String rating,
      required String comments}) async {
    try {
      isFeedBackLoading.value = true;
      var data = {
        'course_id': course_id,
        'rating': rating,
        'comments': comments
      };
      await getMyCoursesRepo.postFeedbackMethod(data: data).then((value) {
        isFeedBackLoading.value = false;
        fluttersToast(
            msg: value['message'].toString(),
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        Get.close(1);
      }).onError((error, stackTrace) {
        isFeedBackLoading.value = false;
        isFeedBackError.value = error.toString();
      });
    } catch (e) {
      isFeedBackError.value = e.toString();
      isFeedBackLoading.value = false;
      log(' get My courses controller  side error' + e.toString());
    }
  }
}
