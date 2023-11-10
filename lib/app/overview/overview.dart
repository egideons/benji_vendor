import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/controller/category_controller.dart';
import '../../src/controller/latlng_detail_controller.dart';
import '../../src/controller/notification_controller.dart';
import '../../src/controller/order_controller.dart';
import '../../src/controller/profile_controller.dart';
import '../../src/controller/user_controller.dart';
import '../../theme/colors.dart';
import '../dashboard/dashboard.dart';
import '../orders/orders.dart';
import '../product/products.dart';
import '../profile/profile.dart';

class OverView extends StatefulWidget {
  final user = Get.put(UserController());
  final userProfile = Get.put(ProfileController());
  final notiication = Get.put(NotificationController());
  final order = Get.put(OrderController());
  final category = Get.put(CategoryController());
  final location = Get.put(LatLngDetailController());

  final int currentIndex;
  OverView({super.key, this.currentIndex = 0});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  @override
  void initState() {
    currentIndex = widget.currentIndex;

    super.initState();
  }

//======== variables =========//
  late int currentIndex;

  final List<Widget> pages = const [
    Dashboard(),
    Orders(),
    Products(),
    Profile(),
  ];

  void onTappedNavBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: currentIndex,
        onTap: onTappedNavBar,
        elevation: 20.0,
        selectedItemColor: kAccentColor,
        selectedIconTheme: IconThemeData(color: kAccentColor),
        showSelectedLabels: true,
        unselectedItemColor: const Color(0xFFBDBDBD),
        unselectedIconTheme: const IconThemeData(color: Color(0xFFBDBDBD)),
        showUnselectedLabels: true,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Overview",
            activeIcon: Icon(Icons.grid_view_rounded),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.receipt),
            label: "Orders",
            activeIcon: FaIcon(FontAwesomeIcons.receipt),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.basketShopping),
            label: "Products",
            activeIcon: FaIcon(FontAwesomeIcons.basketShopping),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: "Profile",
            activeIcon: FaIcon(FontAwesomeIcons.solidUser),
          ),
        ],
      ),
    );
  }
}
