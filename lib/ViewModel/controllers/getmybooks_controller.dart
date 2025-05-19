import 'dart:developer';

import 'package:academy/data/Model/Books/BooksModel.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/getmybooks_repo.dart';
import 'package:get/get.dart';

class GetMyBooksController extends GetxController {
  GetMyBooksRepository getMyBooksRepository = GetMyBooksRepository();

  final Rx<List<GetMyBooksList>> _getMyBooksList = Rx<List<GetMyBooksList>>([]);
  List<GetMyBooksList> get getMyBooksList => _getMyBooksList.value;
  RxString errorGetMyBooksText = ''.obs;
  Rx<AppStatus> appStatusGetMyBooks = AppStatus.LOADING.obs;
  void setGetMyBooksAppStatus(AppStatus _value) =>
      appStatusGetMyBooks.value = _value;
  void setErrorGetMyBooks(String _errorValue) =>
      errorGetMyBooksText.value = _errorValue;
  void setGetMyCoursesList(List<GetMyBooksList> _value) =>
      _getMyBooksList.value = _value;

  Future<void> getAllMyBooksList() async {
    try {
      setGetMyBooksAppStatus(AppStatus.LOADING);

      await getMyBooksRepository.getMyBooksMethod().then((value) {
        if (value['success'].toString() == 'true') {
          GetMyBooksModel res = GetMyBooksModel.fromJson(value);
          log(value['success'].toString());
          setGetMyCoursesList(res.data!);

          setGetMyBooksAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorGetMyBooks(value['message'].toString());
          setGetMyBooksAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorGetMyBooks(value['message'].toString());
          setGetMyBooksAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        print(error);

        setErrorGetMyBooks('No internet connection!');
        // setErrorGetMyBooks(error.toString());
        setGetMyBooksAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('get My courses controller side error' + e.toString());
    }
  }
}
