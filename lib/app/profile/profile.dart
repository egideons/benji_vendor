import 'dart:convert';

import 'package:benji_vendor/app/businesses/edit_businesses.dart';
import 'package:benji_vendor/app/profile/edit_profile.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../auth/login.dart';
import '../packages/packages.dart';
import '../settings/settings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

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

  toPackages() {
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

  void toBusinesses() {
    Get.to(
      () => const EditBusinessesPage(),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "EditBusinessesPage",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }

  void toEditProfile() => Get.to(
        () => const EditProfile(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "EditProfile",
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

  void _deleteAccount() async {
    final res = await UserController.instance.deleteAccount();
    if (res.statusCode == 200) {
      await UserController.instance.deleteUser();
      UserController.instance.logoutUser();

      Get.offAll(
        () => const Login(),
        predicate: (route) => false,
        routeName: 'HomePage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.upToDown,
      );
      return;
    }
    ApiProcessorController.errorSnack(jsonDecode(res.body)['message']);
  }

  void _deletePopUp() => Get.defaultDialog(
        title: "What do you want to do?",
        titleStyle: const TextStyle(
          fontSize: 20,
          color: kTextBlackColor,
          fontWeight: FontWeight.w700,
        ),
        content: const SizedBox(height: 0),
        cancel: ElevatedButton(
          onPressed: () => _deleteAccount(),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: kAccentColor),
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: kBlackColor.withOpacity(0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                UserController.instance.isLoadingDelete.value
                    ? "Deleting..."
                    : "Delete Account",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kAccentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: kAccentColor,
            elevation: 10.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shadowColor: kBlackColor.withOpacity(0.4),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Cancel",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return MyResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          elevation: 0,
          title: const Text(
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
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
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
                            onTap: toEditProfile,
                            leading: const FaIcon(FontAwesomeIcons.solidUser,
                                color: kAccentColor),
                            title: const Text(
                              'Personal Info',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing:
                                const FaIcon(FontAwesomeIcons.chevronRight),
                          ),
                          ListTile(
                            onTap: toSettings,
                            leading: const FaIcon(
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
                            trailing:
                                const FaIcon(FontAwesomeIcons.chevronRight),
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
                            onTap: toPackages,
                            leading: const FaIcon(
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
                            trailing:
                                const FaIcon(FontAwesomeIcons.chevronRight),
                          ),
                          ListTile(
                            onTap: toBusinesses,
                            leading: const FaIcon(
                              FontAwesomeIcons.store,
                              color: kAccentColor,
                            ),
                            title: const Text(
                              'Edit Businesses',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: const FaIcon(
                              FontAwesomeIcons.solidPenToSquare,
                              color: kAccentColor,
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
                      child: Column(
                        children: [
                          ListTile(
                            onTap: _deletePopUp,
                            enableFeedback: true,
                            mouseCursor: SystemMouseCursors.click,
                            leading: const FaIcon(
                              FontAwesomeIcons.solidTrashCan,
                              color: kAccentColor,
                            ),
                            title: const Text(
                              'Delete Account',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: const FaIcon(
                              FontAwesomeIcons.chevronRight,
                            ),
                          ),
                          kHalfSizedBox,
                          ListTile(
                            onTap: logOut,
                            leading: const FaIcon(
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
                            trailing:
                                const FaIcon(FontAwesomeIcons.chevronRight),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
