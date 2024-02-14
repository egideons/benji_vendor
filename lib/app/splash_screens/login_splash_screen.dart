// ignore_for_file: camel_case_types, file_names

import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSplashScreen extends StatelessWidget {
  LoginSplashScreen({super.key});

  final order = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OverView(),
        ),
      );
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Center(
              child: Container(
                // width: 400,
                // height: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/animations/splash_screen/successful.gif",
                    ),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
