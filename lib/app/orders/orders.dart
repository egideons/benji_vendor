import 'package:flutter/material.dart';

import '../../modules/product/category button section.dart';
import '../../theme/colors.dart';
import '../../theme/constants.dart';

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
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
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/food/jollof-rice-chicken-plaintain.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        )
                      ],
                    )
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
