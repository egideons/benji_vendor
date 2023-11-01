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
                      builder: (controller) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return VendorsOrderContainer(
                            order: controller.orderList[index],
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
