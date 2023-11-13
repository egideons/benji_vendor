import 'package:benji_vendor/app/others/reviews.dart';
import 'package:benji_vendor/app/profile/business_info.dart';
import 'package:benji_vendor/app/profile/personal_info.dart';
import 'package:benji_vendor/app/profile/settings.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../auth/login.dart';
import '../package/packages.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void logOut() async {
    UserController.instance.deleteUser();
    ProductController.instance.deleteCachedProducts();
    OrderController.instance.deleteCachedOrders();
    Get.offAll(
      () => const Login(),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "Login",
      predicate: (routes) => false,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }

  reviewsPage() {
    Get.to(
      () => const ReviewsPage(),
      routeName: 'ReviewsPage',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  sendPackage() {
    Get.to(
      () => const Packages(),
      routeName: 'Packages',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  void toBusinessInfo() => Get.to(
        () => const BusinessInfo(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "BusinessInfo",
        preventDuplicates: true,
        popGesture: false,
        transition: Transition.rightToLeft,
      );

  void toPersonalInfo() => Get.to(
        () => const PersonalInfo(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "PersonalInfo",
        preventDuplicates: true,
        popGesture: false,
        transition: Transition.rightToLeft,
      );
  void toSettings() => Get.to(
        () => const Settings(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Settings",
        preventDuplicates: true,
        popGesture: false,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    return MyResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          elevation: 0,
          title: Text(
            'My Profile',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10),
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
                child: Column(
                  children: [
                    ListTile(
                      onTap: toPersonalInfo,
                      leading: FaIcon(FontAwesomeIcons.solidUser,
                          color: kAccentColor),
                      title: const Text(
                        'Personal Info',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
                    ListTile(
                      onTap: toBusinessInfo,
                      leading: FaIcon(
                        FontAwesomeIcons.store,
                        color: kAccentColor,
                      ),
                      title: const Text(
                        'Business Info',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
                    ListTile(
                      onTap: toSettings,
                      leading: FaIcon(
                        FontAwesomeIcons.gear,
                        color: kAccentColor,
                      ),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
                  children: [
                    ListTile(
                      onTap: sendPackage,
                      leading: FaIcon(
                        FontAwesomeIcons.bicycle,
                        color: kAccentColor,
                      ),
                      title: const Text(
                        'Package delivery',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
                    ListTile(
                      onTap: reviewsPage,
                      leading: FaIcon(
                        FontAwesomeIcons.solidComment,
                        color: kAccentColor,
                      ),
                      title: const Text(
                        'User Reviews',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.receipt,
                        color: kAccentColor,
                      ),
                      title: const Text(
                        'Number of Orders',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: GetBuilder<OrderController>(
                        initState: (state) async =>
                            await OrderController.instance.getTotal(),
                        builder: (controller) => Text(
                          formatNumber(controller.total.value),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFF9B9BA5),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: ShapeDecoration(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
                child: ListTile(
                  onTap: logOut,
                  leading: FaIcon(
                    FontAwesomeIcons.rightFromBracket,
                    color: kAccentColor,
                  ),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: kTextBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
