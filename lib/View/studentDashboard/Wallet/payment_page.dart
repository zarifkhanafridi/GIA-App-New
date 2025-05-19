import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/Wallet/payment_detail_page.dart';
import 'package:academy/ViewModel/controllers/payment_controller.dart';
import 'package:academy/data/Model/myPayment/my_payments_model.dart';
import 'package:academy/data/status.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final ScrollController _scrollController = ScrollController();
  PaymentController paymentC = Get.find<PaymentController>();
  @override
  void initState() {
    super.initState();

    // fetchStudent();
    print('Student DashBoard');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      paymentC.getMyPayment();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Fee Details',
            style: TextStyle(
                color: AppColors.kDarkBlue,
                fontSize:
                    size.width > 600 ? size.width * 0.021 : size.width * 0.048,

                //                                  fontSize: size.width * 0.048,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2),
          ),
          actions: [],
        ),
        backgroundColor: Colors.transparent,
        body: Obx(() => paymentC.appStatusMyPaymentDetail.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : paymentC.appStatusMyPaymentDetail.value == AppStatus.COMPLETED
                ? paymentC.myPaymentDetailList.isEmpty
                    ? Center(
                        child: Text('payment list is Empty'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Scrollbar(
                          thickness: 6,
                          radius: Radius.circular(10),
                          controller: _scrollController,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            controller: _scrollController,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: paymentC.myPaymentDetailList.length,
                            itemBuilder: (BuildContext context, int index) {
                              MyPaymentDetail? dataList =
                                  paymentC.myPaymentDetailList[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PaymentDetailPage(
                                            invoiceId: dataList.id.toString())
                                        //  PaymentPageDetail(
                                        //   invoiceId: dataList.id.toString(),
                                        // ),
                                        ),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.only(top: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: AppColors.kDarkBlue,
                                  child: Column(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(height: 5.0),
                                      Text(
                                        'INV ID : ' + dataList.id.toString(),
                                        style: TextStyle(
                                            fontSize: size.width > 600
                                                ? size.width * 0.02
                                                : size.width * 0.040,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          bottom: 5.0,
                                          top: 5.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Status',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: dataList.status
                                                                  .toString() ==
                                                              'paid'
                                                          ? Colors.green
                                                          : Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                    dataList.status
                                                                .toString() ==
                                                            'paid'
                                                        ? Icons.check
                                                        : Icons.close,
                                                    size: size.width > 600
                                                        ? size.width * 0.022
                                                        : size.width * 0.045,
                                                    //size: size.width * 0.045,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 5.0),
                                                Text(
                                                  dataList.status.toString() ==
                                                          'paid'
                                                      ? dataList.status
                                                          .toString()
                                                      : 'Not Paid',
                                                  style: TextStyle(
                                                      fontSize: size.width > 600
                                                          ? size.width * 0.018
                                                          : size.width * 0.03,
                                                      color: dataList.status
                                                                  .toString() ==
                                                              'paid'
                                                          ? Colors.green
                                                          : Colors.red),
                                                )
                                              ],
                                            ),
                                            // SizedBox(
                                            //   width: 8,
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          bottom: 5.0,
                                          top: 5.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Fee',
                                              style: TextStyle(
                                                  fontSize: size.width > 600
                                                      ? size.width * 0.018
                                                      : size.width * 0.034,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                                dataList.invoiceTotalAmount!
                                                        .isEmpty
                                                    ? '0'
                                                    : dataList
                                                        .invoiceTotalAmount
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: size.width > 600
                                                        ? size.width * 0.018
                                                        : size.width * 0.034,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                : Center(child: Text('error'))),
      ),
    );
  }
}

class TuitionFeeModel {
  final String type;
  final String status;
  final String totalFee;
  final dynamic discount;
  final dynamic amount;

  TuitionFeeModel({
    required this.type,
    required this.status,
    required this.totalFee,
    required this.discount,
    required this.amount,
  });
}

List<TuitionFeeModel> tuitionFeeList = [
  TuitionFeeModel(
    type: 'Semester 1',
    status: 'Paid',
    totalFee: '1000',
    discount: 100,
    amount: 900,
  ),
  TuitionFeeModel(
    type: 'Semester 2',
    status: 'Not Paid',
    totalFee: '1200',
    discount: 150,
    amount: 0,
  ),
  // Add more items as needed
  // ...
  TuitionFeeModel(
    type: 'Semester 11',
    status: 'Paid',
    totalFee: '2000',
    discount: 200,
    amount: 1800,
  ),
  TuitionFeeModel(
    type: 'Semester 12',
    status: 'Not Paid',
    totalFee: '1500',
    discount: 100,
    amount: 0,
  ),
];
