import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/payment_controller.dart';
import 'package:academy/data/status.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  PaymentController walletC = Get.find<PaymentController>();
  @override
  void initState() {
    super.initState();

    // fetchStudent();

    walletC.getCurrentUserBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'My Wallet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Obx(() => walletC.appStatusWalletModel.value == AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : walletC.appStatusWalletModel.value == AppStatus.COMPLETED
                ? walletC.walletModel == null
                    ? Center(
                        child: Text(
                            '"You can buy test for wallet which u can use anytime",'),
                      )
                    : Center(
                        child: Text(
                            'Balance :: ${walletC.walletModel!.balance.toString()}'),
                      )
                : Center(
                    child: Text('error'),
                  )),
      ),
    );
  }
}
