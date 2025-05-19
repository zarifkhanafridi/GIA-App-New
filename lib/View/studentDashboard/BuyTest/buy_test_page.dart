import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/Cart/cart_view.dart';
import 'package:academy/ViewModel/controllers/buy_test_controller.dart';
import 'package:academy/data/status.dart';
import 'package:academy/res/icons.dart';
import 'package:academy/res/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../../../theme/colors/light_colors.dart';

class BuyTestPage extends StatefulWidget {
  @override
  State<BuyTestPage> createState() => _BuyTestPageState();
}

class _BuyTestPageState extends State<BuyTestPage> {
  int selectedTest = 0;
  int totalFee = 0;
  int qty = 1;
  String selectedValue = 'Online';

  GetBuyTestController getBuyTestController = Get.put(GetBuyTestController());

  void calculateTotalFee() {
    totalFee = qty * selectedTest;
  }

  @override
  void initState() {
    super.initState();

    getBuyTestController.getAllBuyTestList();
  }

  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Buy Test'),
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            PersistentShoppingCart().showCartItemCountWidget(
              cartItemCountWidgetBuilder: (itemCount) => IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartView()),
                  );
                },
                icon: Badge(
                  label: Text(itemCount.toString()),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ),
            const SizedBox(width: 20.0)
          ],
        ),
        body: Obx(
          () => getBuyTestController.appStatusGetBuyTest.value ==
                  AppStatus.LOADING
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: AppColors.kDarkBlue,
                  ),
                )
              : getBuyTestController.appStatusGetBuyTest.value ==
                      AppStatus.COMPLETED
                  ? getBuyTestController.getBuyTestList.isEmpty
                      ? Center(
                          child: Text('No available test'),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: getBuyTestController
                                      .getBuyTestList.length,
                                  itemBuilder: (context, index) {
                                    var buyTestModel = getBuyTestController
                                        .getBuyTestList[index];
                                    selectedTest =
                                        buyTestModel.online_test_fee ?? 0;
                                    calculateTotalFee();

                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(),
                                      child: SlideAnimation(
                                        verticalOffset: 44.0,
                                        child: FadeInAnimation(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0)
                                                .copyWith(
                                                    left: 0.w, right: 0.w),
                                            child: Container(
                                              padding: EdgeInsets.all(12.sp),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        AppColors.kDarkBlue,
                                                        AppColors.kLightBlue,
                                                      ]),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2.w)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  DropdownButton<String>(
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    dropdownColor: AppColors
                                                        .kDarkBlue
                                                        .withOpacity(0.9),
                                                    value: selectedValue,
                                                    items: <String>[
                                                      'Online',
                                                      'Incampus',
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      selectedValue = value!;
                                                      if (value == 'Online') {
                                                        selectedTest =
                                                            buyTestModel
                                                                .online_test_fee!;
                                                      } else {
                                                        selectedTest = buyTestModel
                                                            .incampus_test_fee!;
                                                      }
                                                      setState(() {
                                                        calculateTotalFee();
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    '$selectedTest',
                                                    style: CustomStyle
                                                        .textRegular12,
                                                  ),
                                                  Text(
                                                    'X',
                                                    style: CustomStyle
                                                        .textRegular12,
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            qty++;
                                                            calculateTotalFee();
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.arrow_drop_up,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$qty',
                                                        style: CustomStyle
                                                            .textRegular12,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            if (qty == 1)
                                                              return;
                                                            qty--;
                                                            calculateTotalFee();
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.arrow_drop_down,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '=',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    '$totalFee',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await PersistentShoppingCart()
                                                          .addToCart(
                                                              PersistentShoppingCartItem(
                                                        productId: 'T-' +
                                                            selectedValue,
                                                        productName:
                                                            selectedValue +
                                                                ' Test',
                                                        unitPrice:
                                                            selectedTest + 0.0,
                                                        quantity: qty,
                                                        productDetails: {
                                                          'fee_type': 'test',
                                                          'qty': qty,
                                                          'id': 1,
                                                        },
                                                      ));
                                                    },
                                                    child: SvgPicture.asset(
                                                      AppIcons.shoppingCard,
                                                      width: 45,
                                                      height: 45,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                  : Center(
                      child: SizedBox(
                        child: Text(
                          getBuyTestController.errorGetBuyTestText.value
                              .toString(),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
