import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/Cart/cart_view.dart';
import 'package:academy/ViewModel/controllers/getmybooks_controller.dart';
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

class BooksPage extends StatefulWidget {
  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  GetMyBooksController getMyBooksController = Get.put(GetMyBooksController());

  @override
  void initState() {
    super.initState();

    getMyBooksController.getAllMyBooksList();
  }

  Widget build(BuildContext context) {
    return Background(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Books List'),
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
        () => getMyBooksController.appStatusGetMyBooks.value ==
                AppStatus.LOADING
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.kDarkBlue,
                ),
              )
            : getMyBooksController.appStatusGetMyBooks.value ==
                    AppStatus.COMPLETED
                ? getMyBooksController.getMyBooksList.isEmpty
                    ? Center(
                        child: Text('No Books added'),
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
                                  itemCount: getMyBooksController
                                      .getMyBooksList.length,
                                  itemBuilder: (context, index) {
                                    var booksModel = getMyBooksController
                                        .getMyBooksList[index];

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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/book.png',
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                  SizedBox(width: 20.0),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        booksModel.title
                                                            .toString(),
                                                        style: CustomStyle
                                                            .textSemiBold15
                                                            .copyWith(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .whiteColor),
                                                      ),
                                                      Text(
                                                        'Price ${booksModel.price}',
                                                        style: CustomStyle
                                                            .textSemiBold15
                                                            .copyWith(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .whiteColor),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(child: Text('')),
                                                  InkWell(
                                                    onTap: () async {
                                                      await PersistentShoppingCart()
                                                          .addToCart(
                                                              PersistentShoppingCartItem(
                                                        productId:
                                                            'B-${booksModel.id}',
                                                        productName: booksModel
                                                            .title
                                                            .toString(),
                                                        unitPrice: double.parse(
                                                            booksModel.price
                                                                .toString()),
                                                        quantity: 1,
                                                        productDetails: {
                                                          'id': booksModel.id,
                                                          'fee_type': 'book',
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
                                  }),
                            )
                          ],
                        ),
                      )
                : Center(
                    child: SizedBox(
                    child: Text(
                      getMyBooksController.errorGetMyBooksText.value.toString(),
                    ),
                  )),
      ),
    ));
  }
}
