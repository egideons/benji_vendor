import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../dashboard/dashboard.dart';
import '../orders/orders.dart';
import '../product/products.dart';
import '../profile/profile.dart';

class OverView extends StatefulWidget {
  final int currentIndex;
  const OverView({super.key, this.currentIndex = 0});

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
    Product(),
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
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Orders",
            activeIcon: Icon(Icons.shopping_bag_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Products",
            activeIcon: Icon(Icons.menu_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
            activeIcon: Icon(Icons.person_2_rounded),
          ),
        ],
      ),
    );
  }
}
