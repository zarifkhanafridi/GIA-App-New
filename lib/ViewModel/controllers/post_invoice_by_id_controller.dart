import 'dart:developer';

import 'package:academy/data/Model/InoviceModel/invoice_detail_Model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/repositories/post_invoice_by_id_repo.dart';
import 'package:get/get.dart';

class InvoiceByIdController extends GetxController {
  PostInvoiceByIdRepo postInvoiceByIdRepo = PostInvoiceByIdRepo();

  final Rx<InvoiceData> _invoiceData = Rx<InvoiceData>(InvoiceData());
  InvoiceData get invoiceData => _invoiceData.value;
  RxString errorInvoiceDataText = ''.obs;
  Rx<AppStatus> appStatusInvoiceData = AppStatus.LOADING.obs;
  void setInvoiceDataAppStatus(AppStatus _value) =>
      appStatusInvoiceData.value = _value;
  void setInvoiceDataError(String _errorValue) =>
      errorInvoiceDataText.value = _errorValue;
  void setInvoiceData(InvoiceData _value) => _invoiceData.value = _value;

///////////////////////////////////////////////////////////////////////////

  Future<void> postInvoiceById(Map<String, String> invoiceId) async {
    print('postInvoiceById() exec');
    try {
      print('try exec in PostInvoice() method');
      // setMyPaymentDetailAppStatus(AppStatus.LOADING);
      setInvoiceDataAppStatus(AppStatus.LOADING);

      await postInvoiceByIdRepo.postInvoiceMethod(invoiceId).then((value) {
        print(value);

        if (value['success'].toString() == 'true') {
          InvoiceDetailModel res = InvoiceDetailModel.fromJson(value);
          setInvoiceData(res.data!);
          setInvoiceDataAppStatus(AppStatus.COMPLETED);
        } else if (value['success'].toString() == 'false') {
          print(value['message']);
          setInvoiceDataError(value['message'].toString());
          setInvoiceDataAppStatus(AppStatus.ERROR);
        } else {
          print(value['message']);
          setInvoiceDataError(value['message'].toString());
          setInvoiceDataAppStatus(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        print(error);
        setInvoiceDataError(error.toString());
        setInvoiceDataAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setInvoiceDataError(e.toString());
      setInvoiceDataAppStatus(AppStatus.ERROR);
      print(e);
      log('get My Payment controller side error' + e.toString());
    }
  }
}
