import 'dart:convert';

import 'package:academy/View/studentDashboard/offercourses/EmptyCartMsgWidget.dart';
import 'package:academy/View/studentDashboard/offercourses/czrt_title_widget.dart';
import 'package:academy/ViewModel/controllers/post_invoice_controller.dart';
import 'package:academy/data/Model/InoviceModel/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final shoppingCart = PersistentShoppingCart();
  void f() {
    shoppingCart.getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child:
                    // PersistentShoppingCart().showCartItems(
                    //   cartTileWidget: ({required data}) =>
                    //       CartTileWidget(data: data),
                    //   showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
                    // ),
                    PersistentShoppingCart().showCartItems(
                  cartItemsBuilder: (context, cartItems) {
                    if (cartItems.isEmpty) {
                      return const EmptyCartMsgWidget();
                    }
                    return ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartTileWidget(data: cartItems[index]);
                      },
                    );
                  },
                ),
              ),
              PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) => Visibility(
                  visible: totalAmount == 0.0 ? false : true,
                  child: Column(
                    children: [
                      Text(
                          'Total price ${shoppingCart.getCartData()['totalPrice']}'),
                      ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> cartData =
                              shoppingCart.getCartData();
                          List<PersistentShoppingCartItem> cartItems =
                              cartData['cartItems'];
                          List<InvoiceDetail> invoiceDetailList = [];
                          for (var item in cartItems) {
                            var myItem = InvoiceDetail(
                              id: item.productDetails!['id'],
                              product: item.productName,
                              feeType:
                                  item.productDetails!['fee_type'] ?? 'null',
                              groupId:
                                  item.productDetails!['group_id'] ?? 'null',
                              price: item.unitPrice.toString(),
                              qty: item.quantity.toString(),
                              categoryId:
                                  item.productDetails!['category_id'] ?? 'null',
                              courseId:
                                  item.productDetails!['course_id'] ?? 'null',
                            );
                            invoiceDetailList.add(myItem);
                          }
                          List jsonList = [];
                          for (var item in invoiceDetailList) {
                            var json = item.toJson();
                            jsonList.add(json);
                            print(json);
                          }
                          final InvoiceController invoiceController =
                              Get.put(InvoiceController());
                          invoiceController
                              .postInvoice({"data": json.encode(jsonList)});
                        },
                        child: const Text('Checkout'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
