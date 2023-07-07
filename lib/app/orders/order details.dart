// ignore_for_file: file_names

import 'package:benji_vendor/reusable%20widgets/my%20appbar.dart';
import 'package:benji_vendor/reusable%20widgets/my%20elevatedButton.dart';
import 'package:benji_vendor/reusable%20widgets/my%20outlined%20elevatedButton.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:benji_vendor/providers/constants.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
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
                        Text(
                          '#00977',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 16.09,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.32,
                          ),
                        ),
                        Text(
                          'Pending',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF0003C4),
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
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/food/jollof-rice-chicken-plantain.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 182.38,
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
                                text: "x 2",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/customer/blessing-elechi.png",
                            fit: BoxFit.fill,
                            height: 60,
                            width: 60,
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
                      Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: kAccentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadows: [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 0.7,
                              color: kBlackColor.withOpacity(0.4),
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.phone_rounded,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                        ),
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
                        'Subtotal',
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
                        'Delivery Fee',
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
                              text: '300',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyOutlinedElevatedButton(
                  onPressed: () {},
                  buttonTitle: "Cancel Order",
                  elevation: 10.0,
                  titleFontSize: 16.09,
                  circularBorderRadius: 10.0,
                  maximumSizeHeight: 50.07,
                  maximumSizeWidth: MediaQuery.of(context).size.width / 2.5,
                  minimumSizeHeight: 50.07,
                  minimumSizeWidth: MediaQuery.of(context).size.width / 2.5,
                ),
                MyElevatedButton(
                  onPressed: () {},
                  elevation: 10.0,
                  buttonTitle: "Accept Order",
                  titleFontSize: 16.09,
                  circularBorderRadius: 10.0,
                  maximumSizeHeight: 50.07,
                  maximumSizeWidth: MediaQuery.of(context).size.width / 2.5,
                  minimumSizeHeight: 50.07,
                  minimumSizeWidth: MediaQuery.of(context).size.width / 2.5,
                ),
              ],
            ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
