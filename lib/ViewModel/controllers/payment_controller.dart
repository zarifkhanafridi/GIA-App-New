import 'dart:developer';

import 'package:academy/data/Model/myPayment/my_payments_model.dart';
import 'package:academy/data/Model/myPayment/my_wallet.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/payment_repo.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  PaymentRepository paymentRepository = PaymentRepository();
  final Rx<List<MyPaymentDetail>> _myPaymentDetailList =
      Rx<List<MyPaymentDetail>>([]);
  List<MyPaymentDetail> get myPaymentDetailList => _myPaymentDetailList.value;
  RxString errorMyPaymentDetailText = ''.obs;
  Rx<AppStatus> appStatusMyPaymentDetail = AppStatus.LOADING.obs;
  void setMyPaymentDetailAppStatus(AppStatus _value) =>
      appStatusMyPaymentDetail.value = _value;
  void setMyPaymentDetailError(String _errorValue) =>
      errorMyPaymentDetailText.value = _errorValue;
  void setMyPaymentDetail(List<MyPaymentDetail> _value) =>
      _myPaymentDetailList.value = _value;

///////////////////////////////////////////////////////////////////////////
  final Rx<UserBalance?> _walletModel = Rx<UserBalance?>(null);
  UserBalance? get walletModel => _walletModel.value;
  RxString errorWalletModelText = ''.obs;
  Rx<AppStatus> appStatusWalletModel = AppStatus.LOADING.obs;
  void setWalletModelAppStatus(AppStatus _value) =>
      appStatusWalletModel.value = _value;
  void setWalletModelError(String _errorValue) =>
      errorWalletModelText.value = _errorValue;
  void setWalletModel(UserBalance _value) => _walletModel.value = _value;

  Future<void> getMyPayment() async {
    try {
      setMyPaymentDetailAppStatus(AppStatus.LOADING);

      await paymentRepository.getPaymentMethod().then((value) {
        if (value['success'].toString() == 'true') {
          MyPaymentsModel res = MyPaymentsModel.fromJson(value);
          log(value['success'].toString());
          setMyPaymentDetail(res.data!);

          setMyPaymentDetailAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setMyPaymentDetailError(value['message'].toString());
          setMyPaymentDetailAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setMyPaymentDetailError(value['message'].toString());
          setMyPaymentDetailAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setMyPaymentDetailError(error.toString());
        setMyPaymentDetailAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('get My Payment controller side error' + e.toString());
    }
  }

  Future<void> getCurrentUserBalance() async {
    try {
      setWalletModelAppStatus(AppStatus.LOADING);

      await paymentRepository.userCurrentBalanceApi().then((value) {
        if (value['success'].toString() == 'true') {
          myWalletModel res = myWalletModel.fromJson(value);
          log(value['success'].toString());
          setWalletModel(res.data!);

          setWalletModelAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setWalletModelError(value['message'].toString());
          setWalletModelAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setWalletModelError(value['message'].toString());
          setWalletModelAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setWalletModelError(error.toString());
        setWalletModelAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setWalletModelError(e.toString());
      setWalletModelAppStatus(AppStatus.ERROR);
      log('get My Payment controller side error' + e.toString());
    }
  }
}
