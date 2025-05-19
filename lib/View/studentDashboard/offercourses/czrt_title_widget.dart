import 'dart:convert';

import 'package:academy/data/Model/offerCourses/offer_courses_list_model.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartTileWidget extends StatelessWidget {
  final PersistentShoppingCartItem data;

  CartTileWidget({Key? key, required this.data}) : super(key: key);

  final PersistentShoppingCart _shoppingCart = PersistentShoppingCart();

  @override
  Widget build(BuildContext context) {
    List courseList = [];
    var productDetails = data.productDetails;
    if (productDetails!['course_details'] != null) {
      var c_d = productDetails['course_details'];
      var decoded = json.decode(c_d);

      courseList = List.from(decoded['resultDetails']);
      print(courseList);
    }

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,

      // padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.kDarkBlue,
                AppColors.kLightBlue,
                // LightColors.kLightYellow,

                // Colors.redAccent[200],
                // Colors.greenAccent[300],
              ]),
          border: Border.all(color: Colors.white, width: 1)),
      // decoration: BoxDecoration(
      //   color: Colors.grey.withOpacity(.05),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Row(
        children: [
          // NetworkImageWidget(
          //   borderRadius: 10,
          //   height: 80,
          //   width: 80,
          //   imageUrl: data.productThumbnail ?? '',
          // ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.productName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rs ${data.unitPrice}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                if (data.productDetails!['fee_type'] == 'test')
                  Container(
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.kDarkBlue,
                            AppColors.kLightBlue,
                          ]),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              data.unitPrice.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              data.productDetails!['qty'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              // 'asdf',
                              data.totalPrice.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (data.productDetails!['fee_type'] == 'course' &&
                    courseList.isNotEmpty)
                  ...courseList.map(
                    (course) {
                      return Container(
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.kDarkBlue,
                                AppColors.kLightBlue,
                              ]),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  course['price'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  course['course_code'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  course['course_title'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  course['first_name'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  course['class_time'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),

                // ...productList.map(
                //   (e) {
                //     return Text('asd');
                //   },
                // ).toList(),
                // Column(
                //   children: [
                //     Text('Book: '),
                //     Text('Teacher: '),
                //     Text('Timing'),
                //     Text('Price'),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(width: 5.0),
          Column(
            children: [
              InkWell(
                onTap: () async {
                  bool removed =
                      await _shoppingCart.removeFromCart(data.productId);
                  if (removed) {
                    // Handle successful removal
                    showSnackBar(context, removed);
                  } else {
                    // Handle the case where if product was not found in the cart
                  }
                },
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Center(
                    child: Text(
                      'Remove',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, bool removed) {
    final snackBar = SnackBar(
      content: Text(
        removed
            ? 'Product removed from cart.'
            : 'Product not found in the cart.',
      ),
      backgroundColor: removed ? Colors.green : Colors.red,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
