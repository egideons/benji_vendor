import 'package:benji_vendor/app/orders/order_details.dart';
import 'package:benji_vendor/src/common_widgets/card/empty.dart';
import 'package:benji_vendor/src/common_widgets/container/vendors_order_container.dart';
import 'package:benji_vendor/src/common_widgets/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
    scrollController.addListener(
        () => OrderController.instance.scrollListener(scrollController));
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  _orderDetails() {
    Get.to(
      () => const OrderDetails(),
      routeName: 'OrderDetails',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  //========= variables ==========//
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MyResponsivePadding(
      child: Scaffold(
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            color: kPrimaryColor,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(
              kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Orders',
                  style: TextStyle(
                    color: Color(0xFF181C2E),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                kSizedBox,
                Column(
                  children: [
                    GetBuilder<OrderController>(
                      initState: (state) async {
                        await OrderController.instance.getOrders();
                      },
                      init: OrderController(),
                      builder: (controller) => controller.isLoad.value &&
                              controller.orderList.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                                color: kAccentColor,
                              ),
                            )
                          : controller.orderList.isEmpty
                              ? const EmptyCard()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.orderList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: _orderDetails,
                                      child: VendorsOrderContainer(
                                        order: controller.orderList[index],
                                      ),
                                    );
                                  },
                                ),
                    ),
                    GetBuilder<OrderController>(
                      builder: (controller) => Column(
                        children: [
                          controller.isLoadMore.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: kAccentColor,
                                  ),
                                )
                              : const SizedBox(),
                          controller.loadedAll.value
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  height: 10,
                                  width: 10,
                                  decoration: ShapeDecoration(
                                      shape: const CircleBorder(),
                                      color: kPageSkeletonColor),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
