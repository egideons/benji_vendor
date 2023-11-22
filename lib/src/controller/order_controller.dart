// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji_vendor/app/orders/orders.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/order_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../providers/helper.dart';

class OrderController extends GetxController {
  static OrderController get instance {
    return Get.find<OrderController>();
  }

  var isLoad = false.obs;
  var vendorsOrderList = <OrderModel>[].obs;

  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;
  var total = 0.obs;
  var status = StatusType.delivered.obs;

  var vendorPendingOrders = <OrderModel>[].obs;
  var vendorDispatchedOrders = <OrderModel>[].obs;
  var vendorCompletedOrders = <OrderModel>[].obs;

  deleteCachedOrders() {
    vendorsOrderList.value = <OrderModel>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.delivered;
  }

  Future<void> scrollListener(scrollController) async {
    if (OrderController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      OrderController.instance.isLoadMore.value = true;
      update();
      await OrderController.instance.getOrdersByStatus();
    }
  }

  setStatus([StatusType newStatus = StatusType.delivered]) async {
    status.value = newStatus;
    vendorsOrderList.value = [];
    loadNum.value = 10;
    loadedAll.value = false;
    update();
    await getOrdersByStatus();
  }

  Future getTotal() async {
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrders?start=0&end=1";
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    try {
      total.value =
          jsonDecode(response?.body ?? ({'total': 0}).toString())['total'];
    } catch (e) {
      total.value = 0;
      consoleLog(e.toString());
    }
    update();
  }

  Future getOrdersByStatus() async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?status=${statusTypeConverter(status.value)}&start=${loadNum.value - 10}&end=${loadNum.value}";
    consoleLog("This is the url: $url");
    loadNum.value += 10;
    token = UserController.instance.user.value.token;
    var response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    // var responseData = response!.body;
    if (responseData == null) {
      isLoad.value = false;
      loadedAll.value = true;
      isLoadMore.value = false;
      update();
      return;
    }
    List<OrderModel> data = [];
    try {
      var decodedResponse = jsonDecode(responseData);
      consoleLog("This is the status code: ${response!.statusCode.toString()}");
      consoleLog("This is the decoded response: ${decodedResponse.toString()}");

      if (decodedResponse is List) {
        data = decodedResponse.map((e) => OrderModel.fromJson(e)).toList();
      } else if (decodedResponse is Map<String, dynamic> &&
          decodedResponse.containsKey('items')) {
        // Handle the response as a map with 'items' key
        var items = decodedResponse['items'] as List;
        data = items.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        consoleLog("Invalid response structure: $decodedResponse");
      }
      // if (decodedResponse.containsKey('items')) {
      //   var items = decodedResponse['items'] as List;
      //   data = items.map((e) => OrderModel.fromJson(e)).toList();
      // } else {
      //   consoleLog("No 'items' key found in the response");
      // }
      // data = (jsonDecode(responseData)['items'] as List)
      // data = (jsonDecode(responseData) as List)
      //     .map((e) => OrderModel.fromJson(e))
      //     .toList();
      vendorsOrderList.value += data;
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
    loadedAll.value = data.isEmpty;
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }

  Future getOrdersByPendingStatus() async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?status=PEND&start=${loadNum.value - 10}&end=${loadNum.value}";
    consoleLog(url);
    loadNum.value += 10;
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    consoleLog(response!.body);
    if (responseData == null) {
      isLoad.value = false;
      loadedAll.value = true;
      isLoadMore.value = false;
      update();
      return;
    }
    List<OrderModel> data = [];
    try {
      var decodedResponse = jsonDecode(responseData);
      consoleLog("This is the status code: ${response.statusCode.toString()}");
      consoleLog("This is the decoded response: ${decodedResponse.toString()}");
      if (decodedResponse.containsKey('items')) {
        var items = decodedResponse['items'] as List;
        data = items.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        consoleLog("No 'items' key found in the response");
      }
      // data = (jsonDecode(responseData)['items'] as List)
      // data = (jsonDecode(responseData) as List)
      //     .map((e) => OrderModel.fromJson(e))
      //     .toList();

      vendorPendingOrders.value += data;
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
    // try {
    //   var decodedResponse = jsonDecode(responseData);
    //   if (decodedResponse.containsKey('items')) {
    //     var items = decodedResponse['items'] as List;
    //     data = items.map((e) => OrderModel.fromJson(e)).toList();
    //   } else {
    //     consoleLog("No 'items' key found in the response");
    //   }
    //   consoleLog(data.toString());
    //   vendorPendingOrders.value += data;
    // } on SocketException {
    //   ApiProcessorController.errorSnack("Please connect to the internet");
    // } catch (e) {
    //   consoleLog("An error occured: ${e.toString()}");
    // }
    loadedAll.value = data.isEmpty;
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }

  Future getOrdersByDispatchedStatus() async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?status=PEND&start=${loadNum.value - 10}&end=${loadNum.value}";
    consoleLog(url);
    loadNum.value += 10;
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    consoleLog(response!.body);
    if (responseData == null) {
      isLoad.value = false;
      loadedAll.value = true;
      isLoadMore.value = false;
      update();
      return;
    }
    List<OrderModel> data = [];
    try {
      var decodedResponse = jsonDecode(responseData);
      consoleLog("This is the status code: ${response.statusCode.toString()}");
      consoleLog("This is the decoded response: ${decodedResponse.toString()}");
      if (decodedResponse.containsKey('items')) {
        var items = decodedResponse['items'] as List;
        data = items.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        consoleLog("No 'items' key found in the response");
      }
      // data = (jsonDecode(responseData)['items'] as List)
      // data = (jsonDecode(responseData) as List)
      //     .map((e) => OrderModel.fromJson(e))
      //     .toList();

      vendorDispatchedOrders.value += data;
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
    // try {
    //   var decodedResponse = jsonDecode(responseData);
    //   if (decodedResponse.containsKey('items')) {
    //     var items = decodedResponse['items'] as List;
    //     data = items.map((e) => OrderModel.fromJson(e)).toList();
    //   } else {
    //     consoleLog("No 'items' key found in the response");
    //   }
    //   consoleLog(data.toString());
    //   vendorPendingOrders.value += data;
    // } on SocketException {
    //   ApiProcessorController.errorSnack("Please connect to the internet");
    // } catch (e) {
    //   consoleLog("An error occured: ${e.toString()}");
    // }
    loadedAll.value = data.isEmpty;
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }

  Future getOrdersByCompletedStatus() async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?status=COMP&start=${loadNum.value - 10}&end=${loadNum.value}";
    consoleLog(url);
    loadNum.value += 10;
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    consoleLog(response!.body);
    if (responseData == null) {
      isLoad.value = false;
      loadedAll.value = true;
      isLoadMore.value = false;
      update();
      return;
    }
    List<OrderModel> data = [];
    try {
      var decodedResponse = jsonDecode(responseData);
      consoleLog("This is the status code: ${response.statusCode.toString()}");
      consoleLog("This is the decoded response: ${decodedResponse.toString()}");
      if (decodedResponse.containsKey('items')) {
        var items = decodedResponse['items'] as List;
        data = items.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        consoleLog("No 'items' key found in the response");
      }
      // data = (jsonDecode(responseData)['items'] as List)
      // data = (jsonDecode(responseData) as List)
      //     .map((e) => OrderModel.fromJson(e))
      //     .toList();
      vendorPendingOrders.value += data;
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
    // try {
    //   data = (jsonDecode(responseData)['items'] as List)
    //       // data = (jsonDecode(responseData) as List)
    //       .map((e) => OrderModel.fromJson(e))
    //       .toList();
    //   consoleLog(data.toString());
    //   vendorCompletedOrders.value += data;
    // } on SocketException {
    //   ApiProcessorController.errorSnack("Please connect to the internet");
    // } catch (e) {
    //   consoleLog(e.toString());
    // }
    loadedAll.value = data.isEmpty;
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }
}
