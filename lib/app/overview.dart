import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';

import 'dashboard/dashboard.dart';
import 'product/product.dart';
import 'profile/profile.dart';

class OverView extends StatefulWidget {
  const OverView({super.key});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  int _currentIndex = 1;

  final List<Widget> _pages = const [
    Dashboard(),
    Product(),
    Profile(),
  ];

  void onTappedBar(int index) {
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
        elevation: 10.0,
        currentIndex: _currentIndex,
        items: const [],
      ),
    );
  }
}
