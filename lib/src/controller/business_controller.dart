// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/business_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../providers/helpers.dart';

class BusinessController extends GetxController {
  static BusinessController get instance {
    return Get.find<BusinessController>();
  }

  var isLoad = false.obs;
  var isLoadBalance = false.obs;
  var businesses = <BusinessModel>[].obs;
  var balance = 0.0.obs;

  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;

  Future<void> scrollListener(scrollController) async {
    if (BusinessController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      BusinessController.instance.isLoadMore.value = true;
      update();
      await BusinessController.instance.getVendorBusinesses();
    }
  }

  refreshData() {
    loadedAll.value = false;
    loadNum.value = 10;
    businesses.value = [];
    getVendorBusinesses();
  }

  Future getVendorBusinesses() async {
    isLoad.value = true;

    String userId = UserController.instance.user.value.id.toString();

    String url = Api.baseUrl + Api.getVendorBusinesses + userId;
    // "${Api.baseUrl}${Api.getVendorBusinesses}$userId?start=${loadNum.value - 10}&end=${loadNum.value}";
    var parsedURL = Uri.parse(url);

    List<BusinessModel> data = [];
    try {
      var response = await http.get(
        parsedURL,
        headers: authHeader(),
      );
      if (response.body.isEmpty) {
        isLoad.value = false;
        loadedAll.value = true;
        isLoadMore.value = false;
        update();
        return;
      }

      if (response.statusCode == 200) {
        data = (jsonDecode(response.body) as List)
            .map((item) => BusinessModel.fromJson(item))
            .toList();
        businesses.value = data;
        log(response.body);
      } else {
        log(response.statusCode.toString());
        log(response.body);
        ApiProcessorController.errorSnack("An error occured, please refresh.");
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      log(e.toString());
    }
    loadedAll.value = data.isEmpty;
    isLoadMore.value = false;
    isLoad.value = false;
    update();
  }

  Future getVendorBusinessBalance(String id) async {
    isLoadBalance.value = true;

    try {
      String url = '${Api.baseUrl}/wallet/getvendorbusinessbalance/$id';
      var parsedURL = Uri.parse(url);

      final result = await http.get(
        parsedURL,
        headers: authHeader(),
      );
      if (result.statusCode != 200) {
        ApiProcessorController.errorSnack("Something went wrong");
        return;
      }
      balance.value =
          double.parse(jsonDecode(result.body)['balance'].toString());
      isLoadBalance.value = false;
      update();
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<http.Response?> getVendorBusinessWithdraw(BusinessModel business,
      {double shopReward = 0.0}) async {
    String url = '${Api.baseUrl}/wallet/requestVendorRewardWithdrawal';

    try {
      final body = {
        "business_id": business.id,
        "amount_to_withdraw": shopReward,
        // "bank_details_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
      };
      print(body);
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: authHeader(),
      );
      print('value of type what');
      return response;
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
