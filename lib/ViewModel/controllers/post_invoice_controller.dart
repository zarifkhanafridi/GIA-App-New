import 'dart:developer';

import 'package:academy/data/Model/InoviceModel/invoice_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/post_invoice_repo.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  PostInvoiceRepo postInvoiceRepo = PostInvoiceRepo();
  final Rx<List<InvoiceDetail>> _InvoiceDetailList =
      Rx<List<InvoiceDetail>>([]);
  List<InvoiceDetail> get InvoiceDetailList => _InvoiceDetailList.value;
  RxString errorInvoiceDetailText = ''.obs;
  Rx<AppStatus> appStatusInvoiceDetail = AppStatus.LOADING.obs;
  void setInvoiceDetailAppStatus(AppStatus _value) =>
      appStatusInvoiceDetail.value = _value;
  void setInvoiceDetailError(String _errorValue) =>
      errorInvoiceDetailText.value = _errorValue;
  void setInvoiceDetail(List<InvoiceDetail> _value) =>
      _InvoiceDetailList.value = _value;

///////////////////////////////////////////////////////////////////////////

  Future<void> postInvoice(Map<String, String> invoiceDetail) async {
    print('postInvoice() exec');
    try {
      print('try exec in PostInvoice() method');
      // setMyPaymentDetailAppStatus(AppStatus.LOADING);
      setInvoiceDetailAppStatus(AppStatus.LOADING);

      await postInvoiceRepo.postInvoiceMethod(invoiceDetail).then((value) {
        print(value);
        if (value['success'].toString() == 'true') {
          InvoiceModel res = InvoiceModel.fromJson(value);
          log(value['success'].toString());

          setInvoiceDetail(res.data!);
          setInvoiceDetailAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          setInvoiceDetailError(value['message'].toString());
          setInvoiceDetailAppStatus(AppStatus.ERROR);
        } else {
          log(value['message'].toString());
          setInvoiceDetailError(value['message'].toString());
          setInvoiceDetailAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        print(error);
        setInvoiceDetailError(error.toString());
        setInvoiceDetailAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('get My Payment controller side error' + e.toString());
    }
  }
}
