import 'package:benji_vendor/app/others/reviews.dart';
import 'package:benji_vendor/app/profile/personal_info.dart';
import 'package:benji_vendor/app/profile/settings.dart';
import 'package:benji_vendor/src/common_widgets/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

void _logOut() async {
  await UserController.instance.deleteUser();
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

_reviewsPage() {
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

void _toPersonalInfo() => Get.to(
      () => const PersonalInfo(),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "PersonalInfo",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
void _toSettings() => Get.to(
      () => const Settings(),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "Settings",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.rightToLeft,
    );

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MyResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: const Padding(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
            ),
            child: Text(
              'My Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 1.5,
                ),
                child: Container(
                  width: 327,
                  height: 190,
                  padding: const EdgeInsets.all(
                    kDefaultPadding / 2,
                  ),
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(
                          0x0F000000,
                        ),
                        blurRadius: 24,
                        offset: Offset(
                          0,
                          4,
                        ),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: _toPersonalInfo,
                        leading: Icon(
                          Icons.person_outlined,
                          color: kAccentColor,
                        ),
                        title: const Text(
                          'Personal Info',
                          style: TextStyle(
                            color: Color(
                              0xFF333333,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.business_rounded,
                          color: kAccentColor,
                        ),
                        title: const Text(
                          'Shop Info',
                          style: TextStyle(
                            color: Color(
                              0xFF333333,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      ListTile(
                        onTap: _toSettings,
                        leading: Icon(
                          Icons.settings_rounded,
                          color: kAccentColor,
                        ),
                        title: const Text(
                          'Settings',
                          style: TextStyle(
                            color: Color(
                              0xFF333333,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 1.5,
                ),
                child: Container(
                  width: 327,
                  height: 141,
                  padding: const EdgeInsets.all(
                    kDefaultPadding / 2,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(
                          0x0F000000,
                        ),
                        blurRadius: 24,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: _reviewsPage,
                        leading: Icon(
                          Icons.keyboard_command_key_rounded,
                          color: kAccentColor,
                        ),
                        title: const Text(
                          'User Reviews',
                          style: TextStyle(
                            color: Color(
                              0xFF333333,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.receipt_long_outlined,
                          color: kAccentColor,
                        ),
                        title: const Text(
                          'Number of Orders',
                          style: TextStyle(
                            color: Color(
                              0xFF333333,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const Text(
                          '29K',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(
                              0xFF9B9BA5,
                            ),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 1.5,
                ),
                child: Container(
                  width: 327,
                  height: 78,
                  padding: const EdgeInsets.all(
                    kDefaultPadding / 2,
                  ),
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
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
                    onTap: _logOut,
                    leading: Icon(
                      Icons.logout_rounded,
                      color: kAccentColor,
                    ),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Color(
                          0xFF333333,
                        ),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
