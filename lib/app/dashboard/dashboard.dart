// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:benji_vendor/app/orders/orders.dart';
import 'package:benji_vendor/app/others/reviews.dart';
import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/app/product/view_product.dart';
import 'package:benji_vendor/src/components/card/empty.dart';
import 'package:benji_vendor/src/components/container/dashboard_product_container.dart';
import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/components/section/my_liquid_refresh.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/controller/reviews_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/product_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/home appBar vendor name.dart';
import '../../src/components/container/home orders container.dart';
import '../../src/controller/auth_controller.dart';
import '../../src/controller/notification_controller.dart';
import '../../src/model/order_model.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../others/notifications.dart';
import '../product/add_new_product.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

typedef ModalContentBuilder = Widget Function(BuildContext);

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    AuthController.instance.checkIfAuthorized();

    numberOfNotifications = NotificationController.instance.notification.length;
    consoleLog(
        "This is the profile logo: ${UserController.instance.user.value.profileLogo}");
    OrderController.instance.getOrdersByPendingStatus();
  }

  List<OrderModel> get pendingOrders =>
      OrderController.instance.vendorPendingOrders
          .where((order) => order.assignedStatus == "PEND")
          .toList();

  List<OrderModel> get dispatchedOrders =>
      OrderController.instance.vendorCompletedOrders
          .where((order) => order.assignedStatus == "dispatched")
          .toList();

  List<OrderModel> get deliveredOrders =>
      OrderController.instance.vendorCompletedOrders
          .where((order) => order.assignedStatus == "COMP")
          .toList();

  int get pendingOrdersCount => pendingOrders.length;
  int get dispatchedOrdersCount => pendingOrders.length;
  int get deliveredOrdersCount => deliveredOrders.length;

  void printOrderCounts() {
    consoleLog('Pending Orders Count: $pendingOrdersCount');
    consoleLog('Dispatched Orders Count: $dispatchedOrdersCount');
    consoleLog('Delivered Orders Count: $deliveredOrdersCount');
  }

//=================================== ALL VARIABLES =====================================\\
  int? numberOfNotifications;
  final scrollController = ScrollController();
  bool refreshing = false;

  Future<void> handleRefresh() async {
    setState(() {
      refreshing = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        NotificationController.instance.runTask();
        ReviewsController.instance.getReviews();
        ReviewsController.instance.getAvgRating();
      },
    );
    setState(() {
      refreshing = false;
    });
  }

  addProduct() {
    HapticFeedback.lightImpact();
    Get.to(
      () => const AddProduct(),
      routeName: 'AddProduct',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
    );
  }

  reviewsPage() {
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

  productDetail(ProductModel product) {
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

  profilePage() {
    Get.to(
      () => const OverView(currentIndex: 3),
      routeName: 'OverView',
      duration: const Duration(milliseconds: 0),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
    );
  }

  productsPage() {
    Get.to(
      () => const OverView(currentIndex: 2),
      routeName: 'OverView',
      duration: const Duration(milliseconds: 0),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
    );
  }

  ordersPage(StatusType status) {
    OrderController.instance.setStatus(status);
    Get.to(
      () => const OverView(currentIndex: 1),
      routeName: 'OverView',
      duration: const Duration(milliseconds: 0),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
    );
  }

  void toNotificationsPage() => Get.to(
        () => const Notifications(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Notifications",
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.downToUp,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    printOrderCounts();
    return MyResponsivePadding(
      child: MyLiquidRefresh(
        onRefresh: handleRefresh,
        child: GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: addProduct,
              elevation: 20.0,
              backgroundColor: kAccentColor,
              foregroundColor: kPrimaryColor,
              tooltip: "Add a product",
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              titleSpacing: kDefaultPadding / 2,
              elevation: 0.0,
              title: GetBuilder<UserController>(
                builder: (controller) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: GestureDetector(
                        onTap: profilePage,
                        child: CircleAvatar(
                          maxRadius: 25,
                          minRadius: 20,
                          backgroundColor: kTransparentColor,
                          child: ClipOval(
                              child:
                                  //  controller.user.value.profileLogo.isEmpty
                                  //     ?
                                  Image.asset('assets/icons/store.png')
                              // : MyImage(
                              //     url: controller.user.value.profileLogo),
                              ),
                        ),
                      ),
                    ),
                    AppBarVendor(
                      vendorName: controller.user.value.username,
                      vendorLocation: controller.user.value.code,
                    ),
                  ],
                ),
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      iconSize: 20,
                      onPressed: toNotificationsPage,
                      icon: FaIcon(
                        FontAwesomeIcons.bell,
                        color: kAccentColor,
                        size: 30,
                      ),
                    ),
                    // Positioned(
                    //   top: 10,
                    //   right: 5,
                    //   child: Container(
                    //     height: 20,
                    //     width: 20,
                    //     decoration: ShapeDecoration(
                    //       color: kAccentColor,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(100),
                    //       ),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         formatNumber(numberOfNotifications!),
                    //         textAlign: TextAlign.center,
                    //         style: const TextStyle(
                    //           fontSize: 9,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                kWidthSizedBox,
              ],
            ),
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: Scrollbar(
                child: refreshing
                    ? CircularProgressIndicator(color: kAccentColor)
                    : ListView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(kDefaultPadding),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetBuilder<OrderController>(
                                builder: (controller) {
                                  return OrdersContainer(
                                    onTap: () =>
                                        ordersPage(StatusType.delivered),
                                    numberOfOrders:
                                        formatNumber(deliveredOrdersCount),
                                    typeOfOrders: "Delivered",
                                  );
                                },
                              ),
                              GetBuilder<OrderController>(
                                builder: (controller) {
                                  return OrdersContainer(
                                    onTap: () => ordersPage(StatusType.pending),
                                    numberOfOrders:
                                        formatNumber(pendingOrdersCount),
                                    typeOfOrders: "Pending",
                                  );
                                },
                              ),
                            ],
                          ),
                          kSizedBox,
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      color: kTextGreyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: reviewsPage,
                                    child: Text(
                                      'See All Reviews',
                                      style: TextStyle(
                                        color: kAccentColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                        decorationColor: kAccentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kHalfSizedBox,
                              GetBuilder<ReviewsController>(
                                initState: (state) {
                                  ReviewsController.instance.getAvgRating();
                                  ReviewsController.instance.getReviews();
                                },
                                builder: (controller) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: kStarColor,
                                      size: 20,
                                    ),
                                    kHalfWidthSizedBox,
                                    Text(
                                      "${controller.avgRating.value.toPrecision(1)}",
                                      style: TextStyle(
                                        color: kStarColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    kWidthSizedBox,
                                    Text(
                                      'You have ${formatNumber(controller.total.value)} Reviews',
                                      style: const TextStyle(
                                        color: Color(0xFF32343E),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kSizedBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Latest Products',
                                    style: TextStyle(
                                      color: kTextGreyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: productsPage,
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                        color: kAccentColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                        decorationColor: kAccentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kHalfSizedBox,
                            ],
                          ),
                          SizedBox(
                              height: deviceType(media.width) >= 2 ? 260 : 200,
                              child: GetBuilder<ProductController>(
                                  initState: (state) async =>
                                      await ProductController.instance
                                          .getProducts(),
                                  builder: (controller) {
                                    return controller.isLoad.value
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: kAccentColor,
                                            ),
                                          )
                                        : controller.products.isEmpty
                                            ? const EmptyCard()
                                            : ListView.separated(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        kWidthSizedBox,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                reverse: true,
                                                shrinkWrap: true,
                                                itemCount: min(
                                                    controller.products.length,
                                                    10),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return DashboardProductContainer(
                                                    productName: controller
                                                        .products[index].name,
                                                    child: InkWell(
                                                      onTap: () =>
                                                          productDetail(
                                                              controller
                                                                      .products[
                                                                  index]),
                                                      child: MyImage(
                                                        url: controller
                                                            .products[index]
                                                            .productImage,
                                                        imageHeight: 150,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                  })),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
