// ignore_for_file: file_names

import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/components/section/order_item_section.dart';
import 'package:flutter/material.dart';

import '../../src/components/appbar/my appbar.dart';
import '../../src/model/order_model.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constants.dart';
import '../../theme/colors.dart';

class OrderDetails extends StatefulWidget {
  final OrderModel order;

  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
//============================== ALL VARIABLES ================================\\

//============================== VARIABLES ================================\\

//============================== BOOLS ================================\\
  bool isOrderProcessing = false;
  bool isOrderAccepted = false;
  bool isOrderCanceled = false;

//============================== FUNCTIONS ================================\\
  //Order Accepted
  void processOrderAccepted() {
    setState(() {
      isOrderProcessing = true;
    });

    // Simulating an asynchronous process
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isOrderProcessing = false;
        isOrderAccepted = true;
      });
    });
  }

  //Order Canceled
  void processOrderCanceled() {
    setState(() {
      isOrderProcessing = true;
    });

    // Simulating an asynchronous process
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isOrderProcessing = false;
        isOrderCanceled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyResponsivePadding(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Order Details",
          elevation: 0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          width: media.width,
          padding: const EdgeInsets.all(
            kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                width: media.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.30),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: media.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Oder ID',
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 11.62,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.order.created,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: kTextBlackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      kHalfSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.order.code,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: kTextBlackColor,
                              fontSize: 16.09,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.32,
                            ),
                          ),
                          widget.order.deliveryStatus == "CANC"
                              ? Text(
                                  'Canceled',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: kAccentColor,
                                    fontSize: 16.09,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.32,
                                  ),
                                )
                              : widget.order.deliveryStatus == "PEND"
                                  ? Text(
                                      'Pending',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontSize: 16.09,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.32,
                                      ),
                                    )
                                  : const Text(
                                      'Delivered',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kSuccessColor,
                                        fontSize: 16.09,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.32,
                                      ),
                                    ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              kSizedBox,
              Container(
                width: media.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.30),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Items ordered',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 16.09,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.32,
                      ),
                    ),
                    kHalfSizedBox,
                    Column(
                      children: List.generate(
                        widget.order.orderitems.length,
                        (index) => OrderItemSection(
                          order: widget.order,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              kSizedBox,
              Container(
                width: media.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.30),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Customer's Detail",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 16.09,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.32,
                      ),
                    ),
                    kSizedBox,
                    Row(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(right: kDefaultPadding * 2),
                          child: CircleAvatar(
                            radius: deviceType(media.width) >= 2 ? 60 : 30,
                            child: ClipOval(
                              child: MyImage(url: widget.order.client.image),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.order.client.firstName}  ${widget.order.client.lastName}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kHalfSizedBox,
                            Text(
                              widget.order.client.phone,
                              style: TextStyle(
                                color: kTextGreyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Container(
                width: media.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.30),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 16.09,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.32,
                      ),
                    ),
                    kSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "₦",
                                style: TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              // TextSpan(
                              //   text: widget.order.orderitems.totalAmount,
                              //   style: TextStyle(
                              //     color: kTextBlackColor,
                              //     fontSize: 14.30,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
