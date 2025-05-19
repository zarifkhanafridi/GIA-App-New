import 'dart:developer';

import 'package:hive/hive.dart';

class AuthServices {
  logDataSave({required dynamic responseData}) async {
    log(responseData.toString() +
        "data" +
        " ${responseData['roles'][0]['id'].toString()}");

    Hive.box('userBox').put('stId', responseData['roles'][0]['id'].toString());
    Hive.box('userBox').put('sName', responseData['name'].toString());
    Hive.box('userBox').put('sEmail', responseData['email'].toString());
    Hive.box('userBox').put(
        'sPivotId', responseData['roles'][0]['pivot']['user_id'].toString());
    Hive.box('userBox').put(
        'sRolesId', responseData['roles'][0]['pivot']['role_id'].toString());

    log(Hive.box('userBox').get('token').toString() +
        "  " +
        " id " +
        Hive.box('userBox').get('stId').toString() +
        "  " +
        "email " +
        Hive.box('userBox').get('sEmail').toString());
  }

  registerDataSave({required dynamic responseData}) async {
    log(responseData.toString() +
        "data" +
        " ${responseData['roles'][0]['id'].toString()}");

    Hive.box('userBox').put('stId', responseData['roles'][0]['id'].toString());
    Hive.box('userBox').put('sName', responseData['name'].toString());
    Hive.box('userBox').put('sEmail', responseData['email'].toString());
    Hive.box('userBox').put(
        'sPivotId', responseData['roles'][0]['pivot']['user_id'].toString());
    Hive.box('userBox').put(
        'sRolesId', responseData['roles'][0]['pivot']['role_id'].toString());
    Hive.box('userBox').put('reg_no', responseData['reg_no'].toString());
    log(Hive.box('userBox').get('token').toString() +
        "  " +
        " id " +
        Hive.box('userBox').get('stId').toString() +
        "  " +
        "email " +
        Hive.box('userBox').get('sEmail').toString() +
        " " +
        " reg# " +
        Hive.box('userBox').get('reg_no').toString());
  }

  resetCodeTokenSave({required Map responseData}) {
    // log(responseData['customer'].toString());
    Hive.box('userBox')
        .put('reset_code_token', responseData['reset_code_token']);

    log(Hive.box('userBox').get('reset_code_token').toString());
  }

  logoutUserData() {
    Hive.box('userBox').clear();
  }

  updateUserInfo({required var responseData}) {
    log('update User data :' + responseData.toString());
    Hive.box('userBox').put('customerName', responseData['name']);
    Hive.box('userBox').put('customerEmail', responseData['email']);
    Hive.box('userBox').put('customerPhone', responseData['phone']);
  }
}
