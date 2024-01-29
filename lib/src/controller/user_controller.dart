// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_vendor/app/auth/login.dart';
import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/main.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/model/user_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../providers/helpers.dart';

class UserController extends GetxController {
  static UserController get instance {
    return Get.find<UserController>();
  }

  var isLoading = false.obs;
  var user = UserModel.fromJson(null).obs;

  @override
  void onInit() {
    setUserSync();
    super.onInit();
  }

  Future checkAuth() async {
    if (await isAuthorized() == null) {
      ApiProcessorController.errorSnack('Connect to the internet');
      return;
    }

    if (await isAuthorized() == true) {
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
      Get.offAll(() => const Login());
    }
  }

  Future<void> saveUser(String user, String token) async {
    Map data = jsonDecode(user);
    data['token'] = token;

    await prefs.setString('user', jsonEncode(data));
    setUserSync();
  }

  void setUserSync() {
    String? userData = prefs.getString('user');
    bool? isVisibleCash = prefs.getBool('isVisibleCash');
    if (userData == null) {
      user.value = UserModel.fromJson(null);
    } else {
      Map<String, dynamic> userObj =
          (jsonDecode(userData) as Map<String, dynamic>);
      userObj['isVisibleCash'] = isVisibleCash;
      user.value = UserModel.fromJson(userObj);
    }
    update();
  }

  Future<bool> deleteUser() async {
    return await prefs.remove('user');
  }

  getUser() async {
    isLoading.value = true;
    update();

    final user = UserController.instance.user.value;
    http.Response? responseUserData = await HandleData.getApi(
        '${Api.baseUrl}/vendors/getVendor/${user.id}', user.token);
    if (responseUserData?.statusCode != 200) {
      ApiProcessorController.errorSnack("Failed to refresh");
      isLoading.value = false;
      update();
      return;
    }

    UserController.instance.saveUser(responseUserData!.body, user.token);
    isLoading.value = false;
    update();
  }

  // Future<void> saveVendor(String vendor, String token) async {
  //   Map data = jsonDecode(vendor);
  //   data['token'] = token;

  //   await prefs.setString('vendor', jsonEncode(data));
  //   setVendorSynce();
  // }

  // void setVendorSynce() {
  //   String? vendorData = prefs.getString('vendor');
  //   if (vendorData == null) {
  //     vendor.value = VendorModel.fromJson(null);
  //   } else {
  //     vendor.value = vendorModelFromJson(vendorData);
  //   }
  //   update();
  // }
}
