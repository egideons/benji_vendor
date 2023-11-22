// ignore_for_file: empty_catches

import 'dart:io';

import 'package:benji_vendor/app/auth/login.dart';
import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/api_url.dart';
import '../providers/helper.dart';
import 'error_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  Future checkAuth() async {
    try {
      if (await isAuthorized()) {
        consoleLog("User is authorized");
        Get.offAll(
          () => const OverView(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "OverView",
          predicate: (route) => false,
          popGesture: false,
          transition: Transition.cupertinoDialog,
        );
      } else {
        consoleLog("User is not authorized");
        Get.offAll(
          () => const Login(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "Login",
          predicate: (route) => false,
          popGesture: false,
          transition: Transition.cupertinoDialog,
        );
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
  }

  Future checkIfAuthorized() async {
    try {
      if (await isAuthorized()) {
        consoleLog("User is authorized");
        return;
      } else {
        UserController.instance.deleteUser();
        consoleLog("User is not authorized");
        Get.offAll(
          () => const Login(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "Login",
          predicate: (route) => false,
          popGesture: false,
          transition: Transition.cupertinoDialog,
        );
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
  }
}
