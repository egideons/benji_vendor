// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji_vendor/app/orders/orders.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/order_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/helper.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance {
    return Get.find<OrderController>();
  }

  var isLoad = false.obs;
  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;
  var total = 0.obs;
  var status = StatusType.pending.obs;
  var vendorsOrderList = <OrderModel>[].obs;
  var vendorPendingOrders = <OrderModel>[].obs;
  var vendorDispatchedOrders = <OrderModel>[].obs;
  var vendorDeliveredOrders = <OrderModel>[].obs;

  deleteCachedOrders() {
    vendorsOrderList.value = <OrderModel>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.delivered;
  }

  resetOrders() async {
    vendorsOrderList.value = <OrderModel>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.pending;
    setStatus();
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

  setStatus([StatusType newStatus = StatusType.pending]) async {
    status.value = newStatus;
    // if (newStatus == StatusType.pending) {
    //   vendorsOrderList.value = vendorPendingOrders;
    // } else if (newStatus == StatusType.dispatched) {
    //   vendorsOrderList.value = vendorDispatchedOrders;
    // } else if (newStatus == StatusType.delivered) {
    //   vendorsOrderList.value = vendorDeliveredOrders;
    // } else {
    // }
    vendorsOrderList.value = [];
    loadNum.value = 10;
    loadedAll.value = false;
    update();
    await getOrdersByStatus();
  }

  Future getOrdersByStatus() async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?start=${loadNum.value - 10}&end=${loadNum.value}&status=${statusTypeConverter(status.value)}";

    consoleLog(url);
    loadNum.value += 10;
    String token = UserController.instance.user.value.token;
    var response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
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
      print(decodedResponse);
      data =
          (decodedResponse as List).map((e) => OrderModel.fromJson(e)).toList();

      vendorsOrderList.value += data;
      // if (status.value == StatusType.pending) {
      //   vendorPendingOrders.value += data;
      // } else if (status.value == StatusType.dispatched) {
      //   vendorDispatchedOrders.value += data;
      // } else if (status.value == StatusType.delivered) {
      //   vendorDeliveredOrders.value += data;
      // }
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

  // Future getOrdersByPendingStatus() async {
  //   if (loadedAll.value) {
  //     return;
  //   }
  //   isLoad.value = true;
  //   late String token;
  //   String id = UserController.instance.user.value.id.toString();
  //   var url =
  //       "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?start=${loadNum.value - 10}&end=${loadNum.value}&status=PEND";
  //   consoleLog("This is the url: $url");
  //   loadNum.value += 10;
  //   token = UserController.instance.user.value.token;
  //   var response = await HandleData.getApi(url, token);
  //   consoleLog("This is the body: ${response?.body.toString()}");
  //   consoleLog("This is the status code: ${response?.statusCode.toString()}");
  //   var responseData = await ApiProcessorController.errorState(response);
  //   // var responseData = response!.body;
  //   if (responseData == null) {
  //     isLoad.value = false;
  //     loadedAll.value = true;
  //     isLoadMore.value = false;
  //     update();
  //     return;
  //   }

  //   List<OrderModel> data = [];
  //   try {
  //     var decodedResponse = jsonDecode(responseData);
  //     consoleLog("This is the decoded response: ${decodedResponse.toString()}");

  //     data = decodedResponse.map((e) => OrderModel.fromJson(e)).toList();

  //     // if (decodedResponse.containsKey('items')) {
  //     //   var items = decodedResponse['items'] as List;
  //     //   data = items.map((e) => OrderModel.fromJson(e)).toList();
  //     // } else {
  //     //   consoleLog("No 'items' key found in the response");
  //     // }
  //     // data = (jsonDecode(responseData)['items'] as List)
  //     // data = (jsonDecode(responseData) as List)
  //     //     .map((e) => OrderModel.fromJson(e))
  //     //     .toList();
  //     vendorPendingOrders.value += data;
  //   } on SocketException {
  //     ApiProcessorController.errorSnack("Please connect to the internet");
  //   } catch (e) {
  //     consoleLog(e.toString());
  //   }
  //   loadedAll.value = data.isEmpty;
  //   isLoad.value = false;
  //   isLoadMore.value = false;
  //   update();
  // }

  // Future getOrdersByDispatchedStatus() async {
  //   if (loadedAll.value) {
  //     return;
  //   }
  //   isLoad.value = true;
  //   late String token;
  //   String id = UserController.instance.user.value.id.toString();
  //   var url =
  //       "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?start=${loadNum.value - 10}&end=${loadNum.value}&status=dispatched";
  //   consoleLog("This is the url: $url");
  //   loadNum.value += 10;
  //   token = UserController.instance.user.value.token;
  //   var response = await HandleData.getApi(url, token);

  //   var responseData = await ApiProcessorController.errorState(response);
  //   // var responseData = response!.body;
  //   if (responseData == null) {
  //     isLoad.value = false;
  //     loadedAll.value = true;
  //     isLoadMore.value = false;
  //     update();
  //     return;
  //   }
  //   List<OrderModel> data = [];
  //   try {
  //     var decodedResponse = jsonDecode(responseData);
  //     consoleLog("This is the status code: ${response!.statusCode.toString()}");
  //     consoleLog("This is the decoded response: ${decodedResponse.toString()}");

  //     data = decodedResponse.map((e) => OrderModel.fromJson(e)).toList();

  //     // if (decodedResponse.containsKey('items')) {
  //     //   var items = decodedResponse['items'] as List;
  //     //   data = items.map((e) => OrderModel.fromJson(e)).toList();
  //     // } else {
  //     //   consoleLog("No 'items' key found in the response");
  //     // }
  //     // data = (jsonDecode(responseData)['items'] as List)
  //     // data = (jsonDecode(responseData) as List)
  //     //     .map((e) => OrderModel.fromJson(e))
  //     //     .toList();
  //     vendorDispatchedOrders.value += data;
  //   } on SocketException {
  //     ApiProcessorController.errorSnack("Please connect to the internet");
  //   } catch (e) {
  //     consoleLog(e.toString());
  //   }
  //   loadedAll.value = data.isEmpty;
  //   isLoad.value = false;
  //   isLoadMore.value = false;
  //   update();
  // }

  // Future getOrdersByDeliveredStatus() async {
  //   if (loadedAll.value) {
  //     return;
  //   }
  //   isLoad.value = true;
  //   late String token;
  //   String id = UserController.instance.user.value.id.toString();
  //   var url =
  //       "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?start=${loadNum.value - 10}&end=${loadNum.value}&status=COMP";
  //   consoleLog("This is the url: $url");
  //   loadNum.value += 10;
  //   token = UserController.instance.user.value.token;
  //   var response = await HandleData.getApi(url, token);

  //   var responseData = await ApiProcessorController.errorState(response);
  //   // var responseData = response!.body;
  //   if (responseData == null) {
  //     isLoad.value = false;
  //     loadedAll.value = true;
  //     isLoadMore.value = false;
  //     update();
  //     return;
  //   }
  //   List<OrderModel> data = [];
  //   try {
  //     var decodedResponse = jsonDecode(responseData);
  //     consoleLog("This is the status code: ${response!.statusCode.toString()}");
  //     consoleLog("This is the decoded response: ${decodedResponse.toString()}");

  //     data = decodedResponse.map((e) => OrderModel.fromJson(e)).toList();

  //     // if (decodedResponse.containsKey('items')) {
  //     //   var items = decodedResponse['items'] as List;
  //     //   data = items.map((e) => OrderModel.fromJson(e)).toList();
  //     // } else {
  //     //   consoleLog("No 'items' key found in the response");
  //     // }
  //     // data = (jsonDecode(responseData)['items'] as List)
  //     // data = (jsonDecode(responseData) as List)
  //     //     .map((e) => OrderModel.fromJson(e))
  //     //     .toList();
  //     vendorDeliveredOrders.value += data;
  //   } on SocketException {
  //     ApiProcessorController.errorSnack("Please connect to the internet");
  //   } catch (e) {
  //     consoleLog(e.toString());
  //   }
  //   loadedAll.value = data.isEmpty;
  //   isLoad.value = false;
  //   isLoadMore.value = false;
  //   update();
  // }
}
