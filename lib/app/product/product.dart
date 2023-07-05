import 'package:benji_vendor/app/product/view%20product.dart';
import 'package:flutter/material.dart';

import '../../modules/product/category button section.dart';
import '../../reusable widgets/my outlined elevatedButton.dart';
import '../../reusable widgets/search field.dart';
import '../../theme/colors.dart';
import '../../theme/constants.dart';
import 'add new product.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  //============================= ALL VARIABLES =====================================\\

  //===================== TEXTEDITING CONTROLLER =======================\\
  TextEditingController searchController = TextEditingController();

  //===================== CATEGORY BUTTONS =======================\\
  final List _categoryButton = [
    "Pasta",
    "Burgers",
    "Rice Dishes",
    "Chicken",
    "Snacks",
  ];

  final List<Color> _categoryButtonBgColor = [
    kAccentColor,
    const Color(
      0xFFF2F2F2,
    ),
    const Color(
      0xFFF2F2F2,
    ),
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
    const Color(
      0xFF828282,
    ),
    const Color(
      0xFF828282,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Product',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      MyOutlinedElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddProduct(),
                            ),
                          );
                        },
                        circularBorderRadius: 10,
                        minimumSizeWidth: 75,
                        minimumSizeHeight: 35,
                        maximumSizeWidth: 75,
                        maximumSizeHeight: 35,
                        buttonTitle: "+ Add",
                        titleFontSize: 14,
                      )
                    ],
                  ),
                ),
                kSizedBox,
                SearchField(
                  hintText: "Search your products",
                  searchController: searchController,
                ),
                kSizedBox,
                CategoryButtonSection(
                  category: _categoryButton,
                  categorybgColor: _categoryButtonBgColor,
                  categoryFontColor: _categoryButtonFontColor,
                ),
                kHalfSizedBox,
                const Text(
                  'Total 03 items',
                  style: TextStyle(
                    color: Color(
                      0xFF9B9BA5,
                    ),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kSizedBox,
                Flexible(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ViewProduct(),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 120,
                          width: 331,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 104,
                                  height: 104,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/images/food/pasta.png",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 110,
                                child: SizedBox(
                                  height: 70,
                                  width: 260,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 149,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Smokey Jollof Rice',
                                              style: TextStyle(
                                                color: Color(
                                                  0xFF32343E,
                                                ),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "Freshly steamed Jollof Rice",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.more_horiz_rounded,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                right: 0,
                                bottom: 30,
                                child: SizedBox(
                                  width: 260,
                                  height: 17,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₦850',
                                        style: TextStyle(
                                          color: Color(
                                            0xFF4F4F4F,
                                          ),
                                          fontSize: 18,
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Qty: 3200',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(
                                            0xFFAFAFAF,
                                          ),
                                          fontSize: 13.60,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
