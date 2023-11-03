import 'package:benji_vendor/src/controller/form_controller.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/controller/reviews_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import '../dashboard/dashboard.dart';
import '../orders/orders.dart';
import '../product/product.dart';
import '../profile/profile.dart';

class OverView extends StatefulWidget {
  final user = Get.put(UserController());
  final product = Get.put(ProductController());
  final order = Get.put(OrderController());
  final form = Get.put(FormController());
  final reviews = Get.put(ReviewsController());

  final int currentIndex;
  OverView({super.key, this.currentIndex = 0});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  @override
  void initState() {
    _currentIndex = widget.currentIndex;

    super.initState();
  }

//======== variables =========//
  late int _currentIndex;

  final List<Widget> _pages = const [
    Dashboard(),
    Orders(),
    Product(),
    Profile(),
  ];

  void _onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: _currentIndex,
        onTap: _onTappedBar,
        elevation: 20.0,
        selectedItemColor: kAccentColor,
        selectedIconTheme: IconThemeData(
          color: kAccentColor,
        ),
        showSelectedLabels: true,
        unselectedItemColor: const Color(
          0xFFBDBDBD,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Color(
            0xFFBDBDBD,
          ),
        ),
        showUnselectedLabels: true,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_view,
            ),
            label: "Overview",
            activeIcon: Icon(
              Icons.grid_view_rounded,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_outlined,
            ),
            label: "Orders",
            activeIcon: Icon(
              Icons.shopping_bag_rounded,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: "Products",
            activeIcon: Icon(
              Icons.menu_rounded,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: "Profile",
            activeIcon: Icon(
              Icons.person_2_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
