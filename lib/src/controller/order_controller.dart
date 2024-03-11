// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji_vendor/app/orders/orders.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/order_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/helpers.dart';
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

  resetOrders(String id) async {
    vendorsOrderList.value = <OrderModel>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.pending;
    setStatus(id);
  }

  Future<void> scrollListener(scrollController, String id) async {
    if (OrderController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      OrderController.instance.isLoadMore.value = true;
      update();
      await OrderController.instance.getOrdersByStatus(id);
    }
  }

  setStatus(String id, [StatusType newStatus = StatusType.pending]) async {
    status.value = newStatus;

    vendorsOrderList.value = [];
    loadNum.value = 10;
    loadedAll.value = false;
    update();
    await getOrdersByStatus(id);
  }

  Future getOrdersByStatus(String id) async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    var url =
        "${Api.baseUrl}/orders/filterBusinessOrdersByStatus/$id?status=${statusTypeConverter(status.value)}";
// &start=${loadNum.value - 10}&end=${loadNum.value}";
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
      data =
          (decodedResponse as List).map((e) => OrderModel.fromJson(e)).toList();

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
}
