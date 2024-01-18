// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/vendor_business.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../providers/helper.dart';

class BusinessController extends GetxController {
  static BusinessController get instance {
    return Get.find<BusinessController>();
  }

  var isLoad = false.obs;
  var businesses = <BusinessModel>[].obs;

  Future getVendorBusiness() async {
    isLoad.value = true;

    try {
      var response = await http.get(
        Uri.parse(
            '$baseURL/vendors/getVendorBusinesses/${UserController.instance.user.value.id}'),
        headers: authHeader(),
      );

      if (response.statusCode == 200) {
        businesses.value = (jsonDecode(response.body) as List)
            .map((item) => BusinessModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      consoleLog(e.toString());
    }
    isLoad.value = false;
    update();
  }
}
