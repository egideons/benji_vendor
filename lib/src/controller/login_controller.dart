// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/login_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  static LoginController get instance {
    return Get.find<LoginController>();
  }

  var isLoad = false.obs;

  Future<void> login(SendLogin data) async {
    try {
      UserController.instance;
      isLoad.value = true;
      update();
      Map finalData = {
        "username": data.username,
        "password": data.password,
      };

      http.Response? response =
          await HandleData.postApi(Api.baseUrl + Api.login, null, finalData);

      var jsonData = jsonDecode(response?.body ?? '');
      if ((response?.statusCode ?? 400) != 200) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
        return;
      }
      http.Response responseUser = await http.get(
          Uri.parse("${Api.baseUrl}/auth/"),
          headers: authHeader(jsonData["token"]));

      if (responseUser.statusCode != 200) {
        throw const SocketException('Please connect to the internet');
      }

      if (jsonDecode(responseUser.body)['id'] == null) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
        return;
      }
      http.Response? responseUserData = await HandleData.getApi(
          '${Api.baseUrl}/vendors/getVendor/${jsonDecode(responseUser.body)['id']}',
          jsonData["token"]);

      if (responseUserData == null) {
        throw const SocketException('Please connect to the internet');
      }

      if (responseUserData.statusCode != 200) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
        return;
      }

      UserController.instance
          .saveUser(responseUserData.body, jsonData["token"]);

      ApiProcessorController.successSnack("Login Successful");
      isLoad.value = false;
      update();

      Get.offAll(
        () => const OverView(currentIndex: 0),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "OverView",
        predicate: (route) => false,
        popGesture: true,
        transition: Transition.cupertinoDialog,
      );
      return;
    } catch (e) {
      ApiProcessorController.errorSnack("Invalid email or password. Try again");
      isLoad.value = false;
      update();
    }
  }
}
