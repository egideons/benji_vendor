// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji_vendor/app/auth/login.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/user_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  static ProfileController get instance {
    return Get.find<ProfileController>();
  }

  bool? isFirst;
  ProfileController({this.isFirst});

  var user = UserModel.fromJson(null).obs;
  var isLoad = false.obs;

//===================== Update Personal Profile ==================\\

  Future<bool> updateProfile({
    String? profileLogo,
    firstName,
    lastName,
    address,
    phone,
    gender,
    latitude,
    longitude,
  }) async {
    late String token;
    token = UserController.instance.user.value.token;
    int uuid = UserController.instance.user.value.id;
    isLoad.value = true;
    update();

    var url = "${Api.baseUrl}${Api.changeVendorPersonalProfile}$uuid";
    consoleLog(url);

    Map body = {
      "profileLogo": profileLogo ?? "",
      "phone": phone ?? "",
      "first_name": firstName ?? "",
      "last_name": lastName ?? "",
      "address": address ?? "",
      "gender": gender ?? "",
      "latitude": latitude ?? "",
      "longitude": longitude ?? "",
    };
    consoleLog('our body $body');
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": content,
        },
        body: jsonEncode(body),
      );
      consoleLog("Response body: ${response.body}");
      consoleLog("Response Status Code: ${response.statusCode}");
      consoleLog(response.body);
      //Print the response in the console:
      // will do this when the endpoint stops returning null (save the new data)

      if (response.statusCode == 200) {
        UserController.instance
            .saveUser(response.body, UserController.instance.user.value.token);
        await Future.delayed(
            const Duration(milliseconds: 500), () => Get.back());
        ApiProcessorController.successSnack(
            "Your changes have been saved successfully.");
      } else {
        ApiProcessorController.errorSnack(
            "Something went wrong, please try again.");
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet.");
    } catch (e) {
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e \nPlease contact admin.");
    }

    isLoad.value = false;
    update();
    return false;
  }

//===================== Change Password ==================\\

  Future<void> changePassword(
      {String? oldPassword,
      newPassword,
      confirmPassword,
      bool isCurrent = true}) async {
    late String token;
    isLoad.value = true;
    update();

    var url = "${Api.baseUrl}${Api.changePassword}";
    token = UserController.instance.user.value.token;

    Map body = {
      'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          "Content-Type": content,
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        ApiProcessorController.successSnack("Password Changed Successfully");
        await UserController.instance.deleteUser();
        Get.offAll(
          () => const Login(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "Login",
          predicate: (route) => false,
          popGesture: true,
          transition: Transition.rightToLeft,
        );
        return;
      } else {
        ApiProcessorController.errorSnack("Invalid, please try again.");
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet.");
      return;
    } catch (e) {
      consoleLog(e.toString());
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e \nPlease try again.");
    }
    isLoad.value = false;
    update();
  }
}
