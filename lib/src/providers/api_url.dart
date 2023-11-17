import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../controller/user_controller.dart';
import '../model/create_vendor_model.dart';

// API URLS AND HTTP CALL FUNCTIONS
const baseURL = "https://resource.bgbot.app/api/v1";
const baseImage = "https://resource.bgbot.app";

var vendorId = UserController.instance.user.value.id;

class Api {
  static const baseUrl = "https://resource.bgbot.app/api/v1";
  static const login = "/auth/token";
  static const user = "/auth/";
  static const changePassword = "/auth/changeNewPassword/";
  static const addProduct = "/products/addProduct";
  static const changeProduct = "/products/changeProduct/";
  static const deleteProduct = "/products/deleteProduct/";
  static const notification = "/vendors/";
  static const category = "/categories/list";

//Vendor
  static const getSpecificVendor = "/vendors/getVendor/";
  static const vendorsOrderList = "/vendors/";
  static const changeVendorPersonalProfile =
      "/vendors/changeVendorpersonalprofile/";
  static const changeVendorBusinessProfile =
      "/vendors/changeVendorbusinessprofile/";

//Item Packages
  static const getPackageCategory = "/sendPackage/getPackageCategory/";
  static const getPackageWeight = "/sendPackage/getPackageWeight/";
  static const createItemPackage = "/sendPackage/createItemPackage/";

//Payments
  static const getDeliveryFee = "/payments/getdeliveryfee/";

  //BusinessTypes
  static const businessType = "/categories/list";
}

String header = "application/json";
const content = "application/x-www-form-urlencoded";

class HandleData {
  static Future<http.Response?> postApi([
    String? url,
    String? token,
    dynamic body,
  ]) async {
    http.Response? response;
    try {
      if (token == null) {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                "Content-Type": content,
              },
              body: body,
            )
            .timeout(const Duration(seconds: 20));
      } else {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                "Content-Type": content,
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 20));
      }
    } catch (e) {
      response = null;
      consoleLog(e.toString());
    }
    return response;
  }

  static Future<http.Response?> getApi([
    String? url,
    String? token,
  ]) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url!),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
    } catch (e) {
      response = null;
      consoleLog(e.toString());
    }
    return response;
  }

  static Future put() async {}
  static Future delete() async {}

  static Future<http.StreamedResponse?> streamAddVendor(
      url, token, SendCreateModel data, bool vendorClassifier) async {
    http.StreamedResponse? response;

    //  final filePhotoName = basename(data.image!.path);

    var request = http.MultipartRequest("POST", Uri.parse(url));
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Content-Type": content,
      'authorization': 'Bearer $token',
    };

    // var file = await http.MultipartFile.fromPath('image', data.image!.path,
    //     filename: filePhotoName);

    request.headers.addAll(headers);

    request.fields["email"] = data.businessEmail!.toString();
    request.fields["phone"] = data.businessPhone!.toString();
    request.fields["address"] = data.bussinessAddress!.toString();
    request.fields["shop_name"] = data.businessName!.toString();

    request.fields["shop_type"] = data.businessType!.toString();
    request.fields["weekOpeningHours"] = data.openHours!.toString();
    request.fields["weekClosingHours"] = data.closeHours!.toString();
    request.fields["satOpeningHours"] = data.satOpenHours!.toString();
    request.fields["satClosingHours"] = data.satCloseHours!.toString();
    request.fields["sunWeekOpeningHours"] = data.sunOpenHours!.toString();

    request.fields["sunWeekClosingHours"] = data.sunCloseHours!.toString();

    request.fields["personalId"] = data.personaId!.toString();
    request.fields["businessId"] = data.businessId!.toString();
    request.fields["businessBio"] = data.businessBio!.toString();
    request.fields["city"] = data.city!.toString();

    request.fields["state"] = data.state!.toString();
    request.fields["country"] = data.country!.toString();
    request.fields["vendorClassifier"] = vendorClassifier.toString();
    //  request.files.add(file);
    try {
      response = await request.send();
    } catch (e) {
      log(e.toString());
      response = null;
    }
    return response;
  }

  static Future<http.StreamedResponse?> streamAddToVendor(
      url, token, SendCreateModel data) async {
    http.StreamedResponse? response;

    //  final filePhotoName = basename(data.image!.path);

    var request = http.MultipartRequest("POST", Uri.parse(url));
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Content-Type": content,
      'authorization': 'Bearer $token',
    };

    // var file = await http.MultipartFile.fromPath('image', data.image!.path,
    //     filename: filePhotoName);

    request.headers.addAll(headers);

    request.fields["email"] = data.businessEmail!.toString();
    request.fields["phone"] = data.businessPhone!.toString();
    request.fields["address"] = data.bussinessAddress!.toString();
    request.fields["shop_name"] = data.businessName!.toString();

    request.fields["shop_type"] = data.businessType!.toString();
    request.fields["weekOpeningHours"] = data.openHours!.toString();
    request.fields["weekClosingHours"] = data.closeHours!.toString();
    request.fields["satOpeningHours"] = data.satOpenHours!.toString();
    request.fields["satClosingHours"] = data.satCloseHours!.toString();
    request.fields["sunWeekOpeningHours"] = data.sunOpenHours!.toString();

    request.fields["sunWeekClosingHours"] = data.sunCloseHours!.toString();

    request.fields["personalId"] = data.personaId!.toString();
    request.fields["businessId"] = data.businessId!.toString();
    request.fields["businessBio"] = data.businessBio!.toString();
    request.fields["city"] = data.city!.toString();

    request.fields["state"] = data.state!.toString();
    request.fields["country"] = data.country!.toString();
    //  request.files.add(file);
    try {
      response = await request.send();
    } catch (e) {
      log(e.toString());
      response = null;
    }
    return response;
  }
}

consoleLog(String val) {
  return debugPrint(val);
}
