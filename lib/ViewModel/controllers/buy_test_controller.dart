import 'dart:developer';

import 'package:academy/data/Model/BuyTestModel/buy_test_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/buy_test_repo.dart';
import 'package:get/get.dart';

class GetBuyTestController extends GetxController {
  BuyTestRepository buyTestRepository = BuyTestRepository();

  final Rx<List<GetBuyTestList>> _getBuyTestList = Rx<List<GetBuyTestList>>([]);
  List<GetBuyTestList> get getBuyTestList => _getBuyTestList.value;
  RxString errorGetBuyTestText = ''.obs;
  Rx<AppStatus> appStatusGetBuyTest = AppStatus.LOADING.obs;
  void setGetBuyTestAppStatus(AppStatus _value) =>
      appStatusGetBuyTest.value = _value;
  void setErrorGetBuyTest(String _errorValue) =>
      errorGetBuyTestText.value = _errorValue;
  void setGetBuyTestList(List<GetBuyTestList> _value) =>
      _getBuyTestList.value = _value;

  //----------------------------------------------------------------------
  Future<void> getAllBuyTestList() async {
    try {
      setGetBuyTestAppStatus(AppStatus.LOADING);

      await buyTestRepository.getBuyTestApiMethod().then((value) {
        if (value['success'].toString() == 'true') {
          BuyTestModel res = BuyTestModel.fromJson(value);
          log(value['success'].toString());
          setGetBuyTestList(res.data!);

          setGetBuyTestAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setErrorGetBuyTest(value['message'].toString());
          setGetBuyTestAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setErrorGetBuyTest(value['message'].toString());
          setGetBuyTestAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setErrorGetBuyTest(error.toString());
        setGetBuyTestAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('get My courses controller side error' + e.toString());
    }
  }
}
