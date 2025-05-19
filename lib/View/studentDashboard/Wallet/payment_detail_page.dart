import 'package:academy/View/commonPage/background.dart';
import 'package:academy/ViewModel/controllers/post_invoice_by_id_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:url_launcher/url_launcher.dart';
// import 'package:academy/ViewModel/controllers/payment_controller.dart';
import 'package:academy/data/Model/myPayment/my_payments_model.dart';
import 'package:academy/data/status.dart';
// import 'package:academy/data/status.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
// import 'package:get/get.dart';

class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({required this.invoiceId});
  final String invoiceId;
  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  final ScrollController _scrollController = ScrollController();
  // InvoiceByIdController;
  InvoiceByIdController _invoiceByIdController =
      Get.put(InvoiceByIdController());
  // PaymentController paymentC = Get.find<PaymentController>();

  @override
  void initState() {
    super.initState();
    _invoiceByIdController.postInvoiceById({'invoice_id': widget.invoiceId});
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    final Size size = MediaQuery.of(context).size;
    // var invoiceDetil = widget.myPaymentDetail.invoiceDetil;
    // print(invoiceDetil);
    // for (var invoice in invoiceDetil!) {
    //   print(invoice);
    //   if (invoice.category != null && invoice.category!.name != null) {
    //     print(invoice.category!.name);
    //   }
    // }

    // User? userDetails = widget.myPaymentDetail.user;
    print('************ userDetail ************');
    // print(userDetails);

    return Background(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Payment Details',
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
        // Obx
        body: Obx(
          () => _invoiceByIdController.appStatusInvoiceData.value ==
                  AppStatus.LOADING
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _invoiceByIdController.appStatusInvoiceData.value ==
                      AppStatus.ERROR
                  ? Center(
                      child: Text(_invoiceByIdController.errorInvoiceDataText
                          .toString()),
                    )
                  : _invoiceByIdController.appStatusInvoiceData ==
                          AppStatus.COMPLETED
                      ?
                      /////////////////////

                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            // thickness: 6,
                            // radius: Radius.circular(10),
                            controller: _scrollController,
                            child: Column(
                              children: [
                                Card(
                                  margin: EdgeInsets.only(top: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: AppColors.kDarkBlue,
                                  child: Column(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(height: 15.0),
                                      Text(
                                        'Inv ID : ${_invoiceByIdController.invoiceData.inv!.id}',
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
                                                      color: _invoiceByIdController
                                                                  .invoiceData
                                                                  .inv!
                                                                  .status
                                                                  .toString() ==
                                                              'paid'
                                                          ? Colors.green
                                                          : Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                    _invoiceByIdController
                                                                .invoiceData
                                                                .inv!
                                                                .status
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
                                                  _invoiceByIdController
                                                              .invoiceData
                                                              .inv!
                                                              .status
                                                              .toString() ==
                                                          'paid'
                                                      // ? widget.myPaymentDetail.status.toString()
                                                      ? 'paid'
                                                      : 'Not Paid',
                                                  style: TextStyle(
                                                      fontSize: size.width > 600
                                                          ? size.width * 0.018
                                                          : size.width * 0.03,
                                                      color: _invoiceByIdController
                                                                  .invoiceData
                                                                  .inv!
                                                                  .status
                                                                  .toString() ==
                                                              'paid'
                                                          ? Colors.green
                                                          : Colors.red),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          left: 8.0,
                                          right: 8.0,
                                        ),
                                        child: Table(
                                          border: TableBorder.all(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5.0),
                                                  topRight:
                                                      Radius.circular(5.0)),
                                              width: 1,
                                              color: Colors.white),
                                          defaultColumnWidth:
                                              FlexColumnWidth(2),
                                          columnWidths: const {
                                            0: FlexColumnWidth(
                                                0.5), // 40% of available width for the 1st column
                                            1: FlexColumnWidth(
                                                1), // 20% for the 2nd column
                                            2: FlexColumnWidth(
                                                2), // 20% for the 3rd column
                                            3: FlexColumnWidth(
                                                1), // 20% for the 4th column
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    // padding: const EdgeInsets.all(5.0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      '#',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    // padding: const EdgeInsets.all(5.0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      'Group',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    // padding: const EdgeInsets.all(5.0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      'Subject/Group',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    // padding: const EdgeInsets.all(5.0),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      'Price',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // invoiceRow(
                                            //     no: '#',
                                            //     group: 'Group',
                                            //     subBook: 'Subject/Book',
                                            //     price: ,),

                                            ..._invoiceByIdController
                                                .invoiceData.inv!.invoiceDetil!
                                                .map((e) {
                                              i++;

                                              String subjectBook =
                                                  '${e.fee_type!.toUpperCase()}';
                                              if (int.parse(e.qty!) > 1) {
                                                subjectBook =
                                                    '${e.fee_type!.toUpperCase()} (${e.qty}*${e.price})';
                                              }

                                              return invoiceRow(
                                                no: '$i',
                                                group: (e.category != null &&
                                                        e.category!.name !=
                                                            null)
                                                    ? e.category!.name!
                                                    : '-',
                                                subBook: subjectBook,
                                                //  e.feeType.toString().toUpperCase() +
                                                //     e.qty.toString(),
                                                price: double.parse(e.price!),
                                                qty: double.parse(e.qty!),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          // top: -1,
                                        ),
                                        child: Table(
                                          columnWidths: const {
                                            0: FlexColumnWidth(
                                                0.75), // 40% of available width for the 1st column
                                            1: FlexColumnWidth(
                                                0.215), // 20% for the 2nd column
                                            // 2: FlexColumnWidth(2), // 20% for the 3rd column
                                            // 3: FlexColumnWidth(1), // 20% for the 4th column
                                          },
                                          // border: TableBorder.all(width: 1, color: Colors.white),
                                          border: TableBorder(
                                            // borderRadius: BorderRadius.all(Radius.circular(50)),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(5.0),
                                                bottomRight:
                                                    Radius.circular(5.0)),
                                            top: BorderSide.none,
                                            left: BorderSide(
                                                width: 1, color: Colors.white),
                                            right: BorderSide(
                                                width: 1, color: Colors.white),
                                            bottom: BorderSide(
                                                width: 1, color: Colors.white),
                                            horizontalInside: BorderSide(
                                                width: 1, color: Colors.white),
                                            verticalInside: BorderSide(
                                                width: 1, color: Colors.white),
                                          ),

                                          // border: TableBorder.symmetric(

                                          //     inside: BorderSide(width: 1, color: Colors.white)),
                                          children: [
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      'Total',
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      _invoiceByIdController
                                                          .invoiceData
                                                          .inv!
                                                          .invoiceTotalAmount!,
                                                      // widget.myPaymentDetail.invoiceTotalAmount
                                                      //     .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      'Other Charges',
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      _invoiceByIdController
                                                              .invoiceData
                                                              .inv!
                                                              .otherCharges ??
                                                          '0',
                                                      // widget.myPaymentDetail.otherCharges
                                                      //     .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      'Payable Amount',
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            top: 3.0,
                                                            bottom: 3.0),
                                                    child: Text(
                                                      _invoiceByIdController
                                                          .invoiceData
                                                          .inv!
                                                          .invoiceTotalAmount!,
                                                      // widget.myPaymentDetail.invoiceTotalAmount
                                                      //     .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   height: 15.0,
                                      //   color: Colors.white,
                                      // ),
                                      // ..._invoiceByIdController
                                      //     .invoiceData.pMethods!
                                      //     .map(
                                      //       (e) => Column(
                                      //         children: [
                                      //           Container(
                                      //             height: 25,
                                      //             color: Colors.white,
                                      //           ),
                                      //           ExpansionTile(
                                      //             iconColor: Colors.white,
                                      //             collapsedIconColor:
                                      //                 Colors.white,
                                      //             textColor: Colors.white,
                                      //             title: Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment.center,
                                      //               children: [
                                      //                 Text(
                                      //                   'Payment Method:',
                                      //                   style: TextStyle(
                                      //                       color: Colors.white),
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width: 18.0,
                                      //                 ),
                                      //                 Text(
                                      //                   e.payment_title
                                      //                       .toString(),
                                      //                   style: TextStyle(
                                      //                       color: Colors.white),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             children: [
                                      //               Column(
                                      //                 children: [
                                      //                   Divider(),
                                      //                   Html(
                                      //                     data: e.description!,
                                      //                     onLinkTap: (url,
                                      //                         attributes,
                                      //                         element) async {
                                      //                       print(url);
                                      //                       await launchUrl(
                                      //                           Uri.parse(url!));
                                      //                     },
                                      //                     style: {
                                      //                       "body": Style(
                                      //                         // fontSize: FontSize(18.0),
                                      //                         // fontWeight: FontWeight.bold,
                                      //                         color: Colors.white,
                                      //                       ),
                                      //                     },
                                      //                   ),

                                      //                   // Text(
                                      //                   //   parse(e.description.toString()),
                                      //                   //   // e.description.toString(),
                                      //                   //   style: TextStyle(
                                      //                   //       color: Colors.white),
                                      //                   // ),
                                      //                 ],
                                      //               ),
                                      //             ],
                                      //           ),
                                      //           Container(
                                      //             height: 25,
                                      //             color: Colors.white,
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     )
                                      //     .toList(),
                                    ],
                                  ),
                                ),
                                ..._invoiceByIdController.invoiceData.pMethods!
                                    .map(
                                      (e) => Card(
                                        margin: EdgeInsets.only(top: 4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        color: AppColors.kDarkBlue,
                                        child: ExpansionTile(
                                          iconColor: Colors.white,
                                          collapsedIconColor: Colors.white,
                                          textColor: Colors.white,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Payment Method:',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 18.0,
                                              ),
                                              Text(
                                                e.payment_title.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          children: [
                                            Column(
                                              children: [
                                                Divider(),
                                                Html(
                                                  data: e.description!,
                                                  onLinkTap: (url, attributes,
                                                      element) async {
                                                    print(url);
                                                    await launchUrl(
                                                        Uri.parse(url!));
                                                  },
                                                  style: {
                                                    "body": Style(
                                                      // fontSize: FontSize(18.0),
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          ),
                        )
                      : Text('Something went wrong'),
        ),
      ),
    );
  }

  TableRow invoiceRow({
    required String no,
    required String group,
    required String subBook,
    required double price,
    required double qty,
  }) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            // padding: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.only(left: 5.0, top: 3.0, bottom: 3.0),
            child: Text(
              no,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            // padding: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.only(left: 5.0, top: 3.0, bottom: 3.0),
            child: Text(
              group,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            // padding: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.only(left: 5.0, top: 3.0, bottom: 3.0),
            child: Text(
              subBook,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            // padding: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.only(left: 5.0, top: 3.0, bottom: 3.0),
            child: Text(
              (price * qty).toStringAsFixed(0),
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class PaymentDetailWidget extends StatelessWidget {
  const PaymentDetailWidget({
    super.key,
    required this.itemKey,
    required this.itemValue,
    required this.size,
  });
  final String itemKey;
  final String itemValue;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 5.0,
        top: 5.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemKey,
            style: TextStyle(
                fontSize:
                    size.width > 600 ? size.width * 0.018 : size.width * 0.034,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
          Text(itemValue,
              style: TextStyle(
                  fontSize: size.width > 600
                      ? size.width * 0.018
                      : size.width * 0.034,
                  color: Colors.white,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
