// ignore_for_file: camel_case_types, file_names

import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/src/controller/auth_controller.dart';
import 'package:benji_vendor/src/controller/category_controller.dart';
import 'package:benji_vendor/src/controller/form_controller.dart';
import 'package:benji_vendor/src/controller/latlng_detail_controller.dart';
import 'package:benji_vendor/src/controller/login_controller.dart';
import 'package:benji_vendor/src/controller/notification_controller.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:benji_vendor/src/controller/payment_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/controller/product_property_controller.dart';
import 'package:benji_vendor/src/controller/profile_controller.dart';
import 'package:benji_vendor/src/controller/reviews_controller.dart';
import 'package:benji_vendor/src/controller/send_package_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSplashScreen extends StatelessWidget {
  LoginSplashScreen({super.key});
  final user = Get.put(UserController());
  final category = Get.put(CategoryController());
  final login = Get.put(LoginController());
  final auth = Get.put(AuthController());
  final product = Get.put(ProductController());
  final order = Get.put(OrderController());

  final form = Get.put(FormController());
  final reviews = Get.put(ReviewsController());
  final latLngDetail = Get.put(LatLngDetailController());
  final profile = Get.put(ProfileController());
  final notify = Get.put(NotificationController());
  final package = Get.put(SendPackageController());
  final deliveryFee = Get.put(PaymentController());
  final productProperty = Get.put(ProductPropertyController());

  @override
  Widget build(BuildContext context) {
    order.setStatus();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OverView(),
        ),
      );
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Center(
              child: Container(
                width: 400,
                height: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/animations/splash screen/successful.gif",
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
