import 'package:flutter/material.dart';

import '../../modules/product/category button section.dart';
import '../../theme/colors.dart';
import '../../theme/constants.dart';
import 'order details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //============================= ALL VARIABLES =====================================\\
  //===================== CATEGORY BUTTONS =======================\\
  final List _categoryButton = [
    "Pending",
    "Completed",
    "Cancelled",
  ];

  final List<Color> _categoryButtonBgColor = [
    kAccentColor,
    const Color(
      0xFFF2F2F2,
    ),
    const Color(
      0xFFF2F2F2,
    ),
  ];
  final List<Color> _categoryButtonFontColor = [
    kPrimaryColor,
    const Color(
      0xFF828282,
    ),
    const Color(
      0xFF828282,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CategoryButtonSection(
                category: _categoryButton,
                categorybgColor: _categoryButtonBgColor,
                categoryFontColor: _categoryButtonFontColor,
              ),
              kSizedBox,
              Flexible(
                child: Scrollbar(
                  thickness: 10,
                  interactive: true,
                  thumbVisibility: true,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrderDetails(),
                            ),
                          );
                        },
                        child: OrderContainer(
                          orderNumber: "00977",
                          customerName: "Blessing Elechi",
                          orderTimeStamp: "04-06-2023 | 12:30pm",
                          orderName: "Jollof Rice and Chicken with Plantain",
                          orderQuantity: 2.toString(),
                          orderPrice: "5,000",
                          customerAddress: "21 Kanna Street, GRA, Enugu",
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  final String customerName;
  final String orderNumber;
  final String orderTimeStamp;
  final String orderName;
  final String orderQuantity;
  final String orderPrice;
  final String customerAddress;
  const OrderContainer({
    super.key,
    required this.customerName,
    required this.orderNumber,
    required this.orderTimeStamp,
    required this.orderName,
    required this.orderQuantity,
    required this.orderPrice,
    required this.customerAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.all(
        kDefaultPadding / 2,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
              kHalfSizedBox,
              Text(
                '#$orderNumber',
                style: const TextStyle(
                  color: Color(0xFF808080),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          kHalfWidthSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      customerName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF020202),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 122,
                    child: Text(
                      orderTimeStamp,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFFC4C4C4),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              kHalfSizedBox,
              SizedBox(
                width: 204,
                child: Text(
                  orderName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              kHalfSizedBox,
              Row(
                children: [
                  Text(
                    "x $orderQuantity",
                    style: const TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  kHalfWidthSizedBox,
                  SizedBox(
                    width: 77,
                    height: 23,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: '₦',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 15,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: orderPrice,
                            style: const TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              kHalfSizedBox,
              Text(
                customerAddress,
                style: const TextStyle(
                  color: Color(0xFFA6A6A6),
                  fontSize: 12.52,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
