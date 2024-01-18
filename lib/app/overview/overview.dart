import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../theme/colors.dart';
import '../dashboard/dashboard.dart';
import '../profile/business_info.dart';
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
  bool _bottomNavBarIsVisible = true;
  late int currentIndex;

//===================================== FUNCTIONS =================================================\\

  void showNav() {
    setState(() {
      _bottomNavBarIsVisible = true;
    });
  }

  void hideNav() {
    setState(() {
      _bottomNavBarIsVisible = false;
    });
  }

  addVendorBusiness() {
    Get.to(
      () => const BusinessInfo(),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "BusinessInfo",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.downToUp,
    );
  }

  @override
  Widget build(BuildContext context) {
    //===================================== PAGINATION =================================================\\
    final List<Widget> pages = [
      Dashboard(showNavigation: showNav, hideNavigation: hideNav),
      const Profile(),
    ];

    void onTappedNavBar(int index) {
      HapticFeedback.selectionClick();
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      body: pages[currentIndex],
      backgroundColor: kPrimaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: addVendorBusiness,
        elevation: 20.0,
        backgroundColor: kAccentColor,
        foregroundColor: kPrimaryColor,
        tooltip: "Add a business",
        enableFeedback: true,
        mouseCursor: SystemMouseCursors.click,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: AnimatedContainer(
        height: _bottomNavBarIsVisible ? kBottomNavigationBarHeight : 0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: Wrap(
          children: [
            BottomNavigationBar(
              backgroundColor: kPrimaryColor,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              currentIndex: currentIndex,
              mouseCursor: SystemMouseCursors.click,
              onTap: onTappedNavBar,
              elevation: 20.0,
              selectedItemColor: kAccentColor,
              selectedIconTheme: IconThemeData(color: kAccentColor),
              showSelectedLabels: true,
              unselectedItemColor: const Color(0xFFBDBDBD),
              unselectedIconTheme:
                  const IconThemeData(color: Color(0xFFBDBDBD)),
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
                  icon: FaIcon(FontAwesomeIcons.user),
                  label: "Profile",
                  activeIcon: FaIcon(FontAwesomeIcons.solidUser),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
