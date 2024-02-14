// ignore_for_file: empty_catches

import 'dart:developer';
import 'dart:io';

import 'package:benji_vendor/app/auth/login.dart';
import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/api_url.dart';
import '../providers/helpers.dart';
import 'error_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  Future checkAuth() async {
    if (await isAuthorized() == null) {
      ApiProcessorController.errorSnack('Please connect to the internet');
      Get.offAll(
        () => const Login(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Login",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
      return;
    }
    try {
      if (await isAuthorized() == true) {
        log("User is authorized");

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
        log("User is not authorized");
        ApiProcessorController.errorSnack(
          "User is not authorized, Please log in.",
        );
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
      Get.offAll(
        () => const Login(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Login",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
    } catch (e) {
      ApiProcessorController.errorSnack("Something went wrong");
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
  }

  Future checkIfAuthorized() async {
    if (await isAuthorized() == null) {
      ApiProcessorController.errorSnack('Connect to the internet');
      Get.offAll(
        () => const Login(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Login",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
      return;
    }
    try {
      if (await isAuthorized() == true) {
        log("User is authorized");
        return;
      } else {
        UserController.instance.deleteUser();
        ApiProcessorController.errorSnack(
          "User is not authorized, Please log in",
        );
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
      Get.offAll(
        () => const Login(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Login",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
    } catch (e) {
      ApiProcessorController.errorSnack("Something went wrong");
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
  }
}
