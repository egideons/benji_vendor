// ignore_for_file: file_names

import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:flutter/material.dart';

import '../../src/components/appbar/my appbar.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

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
    return MyResponsivePadding(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Order Details",
          elevation: 0.0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(
            kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: Colors.white,
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Oder ID',
                            style: TextStyle(
                              color: Color(0xFF808080),
                              fontSize: 11.62,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Today, 12:30pm',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 12.52,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      kHalfSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '#00977',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16.09,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.32,
                            ),
                          ),
                          isOrderCanceled
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
                              : isOrderAccepted
                                  ? const Text(
                                      'Accepted',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kSuccessColor,
                                        fontSize: 16.09,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.32,
                                      ),
                                    )
                                  : isOrderProcessing
                                      ? Text(
                                          'Processing',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: kLoadingColor,
                                            fontSize: 16.09,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.32,
                                          ),
                                        )
                                      : Text(
                                          'Pending',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: kSecondaryColor,
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
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: Colors.white,
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
                        color: Colors.black,
                        fontSize: 16.09,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.32,
                      ),
                    ),
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const MyImage(url: ''),
                        ),
                        const SizedBox(
                          child: Text.rich(
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Jollof Rice and Chicken",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.52,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.52,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: "x 1",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.52,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '₦',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 9.83,
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 12.52,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '5,000',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 14.30,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: Colors.white,
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
                        color: Colors.black,
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
                          child: const CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                              child: MyImage(
                                url: '',
                              ),
                            ),
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Blessing Elechi',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.52,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kHalfSizedBox,
                            Text(
                              '09023348400',
                              style: TextStyle(
                                color: Color(0xFF979797),
                                fontSize: 11.62,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kSizedBox,
                            Text(
                              'Delivery address',
                              style: TextStyle(
                                color: Color(0xFF979797),
                                fontSize: 10.73,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kHalfSizedBox,
                            SizedBox(
                              width: 155,
                              child: Text(
                                '21 Kanna Street, GRA, Enugu',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12.52,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: ShapeDecoration(
                  color: Colors.white,
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
                        color: Colors.black,
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
                          'Item',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.52,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "₦",
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 9.83,
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 12.52,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '5,000',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 14.30,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.black,
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
                                  color: Color(0xFF222222),
                                  fontSize: 9.83,
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 12.52,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '5,300',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 14.30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
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
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
