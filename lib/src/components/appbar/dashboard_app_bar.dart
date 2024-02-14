// ignore_for_file: file_names

import 'package:benji_vendor/app/others/notifications.dart';
import 'package:benji_vendor/src/components/appbar/app_bar_title.dart';
import 'package:benji_vendor/src/providers/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int numberOfNotifications;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const DashboardAppBar({super.key, required this.numberOfNotifications});
//======================================== ALL VARIABLES ==============================================\\

//======================================== FUNCTIONS ==============================================\\
  void toProfilePage() {
    // Get.to(
    //   () => const PersonalInfo(),
    //   duration: const Duration(milliseconds: 300),
    //   fullscreenDialog: true,
    //   curve: Curves.easeIn,
    //   routeName: "PersonalInfo",
    //   preventDuplicates: true,
    //   popGesture: true,
    //   transition: Transition.downToUp,
    // );
  }

  void toNotificationsPage() => Get.to(
        () => const Notifications(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Notifications",
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.downToUp,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    // void showSearchField() {
    //   showSearch(context: context, delegate: CustomSearchDelegate());
    // }

    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      titleSpacing:
          deviceType(media.width) > 2 ? kDefaultPadding : kDefaultPadding / 2,
      elevation: 0,
      title: const AppBarTitle(),
      actions: [
        Stack(
          children: [
            IconButton(
              iconSize: 20,
              onPressed: toNotificationsPage,
              icon: FaIcon(
                FontAwesomeIcons.bell,
                color: kAccentColor,
                size: 30,
              ),
            ),
            // Positioned(
            //   top: 10,
            //   right: 5,
            //   child: Container(
            //     height: 20,
            //     width: 20,
            //     decoration: ShapeDecoration(
            //       color: kAccentColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //     ),
            //     child: Center(
            //       child: Text(
            //         formatNumber(numberOfNotifications),
            //         textAlign: TextAlign.center,
            //         style: const TextStyle(
            //           fontSize: 9,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
        kWidthSizedBox
      ],
    );
  }
}
