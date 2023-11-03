// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:benji_vendor/app/others/reviews.dart';
import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/app/product/view%20product.dart';
import 'package:benji_vendor/src/common_widgets/card/empty.dart';
import 'package:benji_vendor/src/common_widgets/image/my_image.dart';
import 'package:benji_vendor/src/common_widgets/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/controller/reviews_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/common_widgets/appbar/home appBar vendor name.dart';
import '../../src/common_widgets/container/home orders container.dart';
import '../../src/common_widgets/section/home showModalBottomSheet.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../others/notifications.dart';
import '../product/add new product.dart';
import '../profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

typedef ModalContentBuilder = Widget Function(BuildContext);

class _DashboardState extends State<Dashboard> {
//=================================== ALL VARIABLES =====================================\\

//=================================== DROP DOWN BUTTON =====================================\\

  String dropDownItemValue = "Daily";

  void dropDownOnChanged(String? newValue) {
    setState(() {
      dropDownItemValue = newValue!;
    });
  }

  _addProduct() {
    Get.to(
      () => const AddProduct(),
      routeName: 'AddProduct',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  _reviewsPage() {
    Get.to(
      () => const ReviewsPage(),
      routeName: 'ReviewsPage',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  _productDetail(ProductModel product) {
    Get.to(
      () => ViewProduct(product: product),
      routeName: 'ViewProduct',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  _profilePage() {
    Get.to(
      () => const Profile(),
      routeName: 'Profile',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  _productsPage() {
    Get.to(
      () => OverView(currentIndex: 2),
      routeName: 'OverView',
      duration: const Duration(milliseconds: 0),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyResponsivePadding(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        floatingActionButton: FloatingActionButton(
          onPressed: _addProduct,
          elevation: 20.0,
          backgroundColor: kAccentColor,
          foregroundColor: kPrimaryColor,
          tooltip: "Add a product",
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          titleSpacing: kDefaultPadding / 2,
          elevation: 0.0,
          title: GetBuilder<UserController>(
            builder: (controller) => Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                  ),
                  child: GestureDetector(
                    onTap: _profilePage,
                    child: CircleAvatar(
                      maxRadius: 25,
                      minRadius: 20,
                      backgroundColor: kTransparentColor,
                      backgroundImage: const AssetImage(
                          'assets/images/profile/avatar-image.jpg'),
                      child: ClipOval(
                        child: MyImage(url: controller.user.value.shopImage),
                      ),
                    ),
                  ),
                ),
                AppBarVendor(
                  vendorName: controller.user.value.shopName,
                  vendorLocation: controller.user.value.address,
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              iconSize: 30,
              onPressed: () {
                Get.to(
                  () => const Notifications(),
                  routeName: 'Notifications',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  preventDuplicates: true,
                  popGesture: true,
                  transition: Transition.rightToLeft,
                );
              },
              splashRadius: 20,
              icon: Icon(
                Icons.notifications_outlined,
                color: kAccentColor,
              ),
            ),
            kWidthSizedBox,
          ],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                padding: const EdgeInsets.all(
                  kDefaultPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrdersContainer(
                      onTap: () {
                        OrdersContainerBottomSheet(
                          context,
                          "20 Running",
                          20,
                        );
                      },
                      numberOfOrders: "20",
                      typeOfOrders: "Active",
                    ),
                    OrdersContainer(
                      onTap: () {
                        OrdersContainerBottomSheet(
                          context,
                          "5 Pending",
                          5,
                        );
                      },
                      numberOfOrders: "05",
                      typeOfOrders: "Pending",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 16.57,
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _reviewsPage,
                          child: Text(
                            'See All Reviews',
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                    GetBuilder<ReviewsController>(
                      initState: (state) {
                        ReviewsController.instance.getReviews(0);
                        ReviewsController.instance.getAvgRating();
                      },
                      builder: (controller) => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star_sharp,
                            color: kAccentColor,
                            size: 30,
                          ),
                          kWidthSizedBox,
                          Text(
                            controller.avgRating.value
                                .toPrecision(1)
                                .toString(),
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 21.80,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          kWidthSizedBox,
                          Text(
                            'Total ${controller.total.value} Reviews',
                            style: const TextStyle(
                              color: Color(
                                0xFF32343E,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 16.57,
                          child: Text(
                            'Latest Products',
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _productsPage,
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                  ],
                ),
              ),
              Container(
                  height: 180,
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  child: GetBuilder<ProductController>(
                      initState: (state) async =>
                          await ProductController.instance.getProducts(),
                      builder: (controller) {
                        return controller.isLoad.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              )
                            : controller.products.isEmpty
                                ? const EmptyCard()
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        min(controller.products.length, 5),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          right: kDefaultPadding,
                                          bottom: kDefaultPadding / 1.5,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: ShapeDecoration(
                                          color: kGreyColor1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              kDefaultPadding,
                                            ),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(
                                                0x0F000000,
                                              ),
                                              blurRadius: 24,
                                              offset: Offset(
                                                0,
                                                4,
                                              ),
                                              spreadRadius: 4,
                                            )
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () => _productDetail(
                                              controller.products[index]),
                                          child: MyImage(
                                              url: controller.products[index]
                                                  .productImage),
                                        ),
                                      );
                                    },
                                  );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
