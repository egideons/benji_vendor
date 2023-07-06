import 'package:benji_vendor/reusable%20widgets/my%20appbar.dart';
import 'package:benji_vendor/reusable%20widgets/my%20elevatedButton.dart';
import 'package:benji_vendor/reusable%20widgets/my%20outlined%20elevatedButton.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:benji_vendor/theme/constants.dart';
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
              height: 69,
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
              child: const SizedBox(
                width: 300,
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Oder ID',
                          style: TextStyle(
                            color: Color(0xFF808080),
                            fontSize: 11.62,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 7),
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
                      ],
                    ),
                    SizedBox(width: 149),
                    SizedBox(
                      height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 94,
                            child: Text(
                              'Today, 12:30pm',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 12.52,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Pending',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0003C4),
                              fontSize: 16.09,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kSizedBox,
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 168,
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
                          child: Text(
                            'Jellof Rice and Chicken',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.52,
                              fontWeight: FontWeight.w700,
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
                                text: '2,500',
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
                          child: Text(
                            'Jellof Rice and Chicken',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.52,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 68.84,
                          height: 20.56,
                          child: Text.rich(
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
                                  text: '2,500',
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
              height: 165,
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
                            height: 80,
                            width: 80,
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
                          Text(
                            '21 Kanna Street, GRA, Enugu',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 12.52,
                              fontWeight: FontWeight.w400,
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
                            borderRadius: BorderRadius.circular(14.30),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.phone_rounded,
                              color: kPrimaryColor,
                            ),
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
              height: 161,
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
                  titleFontSize: 16.09,
                  circularBorderRadius: 10.0,
                  maximumSizeHeight: 50.07,
                  maximumSizeWidth: MediaQuery.of(context).size.width / 2.5,
                  minimumSizeHeight: 50.07,
                  minimumSizeWidth: MediaQuery.of(context).size.width / 2.5,
                ),
                MyElevatedButton(
                  onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
