// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:benji_vendor/app/orders/orders.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/order_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  static OrderController get instance {
    return Get.find<OrderController>();
  }

  var isLoad = false.obs;
  var isLoadAwait = false.obs;
  var isLoadAwaitConfirm = false.obs;
  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;
  var total = 0.obs;
  var status = StatusType.pending.obs;
  var vendorsOrderAwaitList = <OrderModel>[].obs;
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

  Future getOrders() async {
    if (loadedAll.value) {
      return;
    }

    isLoad.value = true;

    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.myOrders}$id?start=${loadNum.value - 10}&end=${loadNum.value}";
    loadNum.value += 10;

    log('in list history $url');

    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoadMore.value = false;
      isLoad.value = false;
      update();

      return;
    }
    List<OrderModel> data = [];
    try {
      data = (jsonDecode(responseData) as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
      vendorsOrderList.value += data;
      loadedAll.value = data.isEmpty;
    } catch (e) {}
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }

  Future getOrdersAwait() async {
    isLoadAwait.value = true;
    vendorsOrderAwaitList.value = [];

    String id = UserController.instance.user.value.id.toString();
    var url = "${Api.baseUrl}/orders/ordersAwaitingConfirmation/$id";

    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoadAwait.value = false;
      update();
      return;
    }
    try {
      vendorsOrderAwaitList.value = (jsonDecode(responseData) as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
    } catch (e) {}
    isLoadAwait.value = false;
    update();
  }

  Future confirmOrder(String id,
      {bool confirm = true, String reason = ''}) async {
    isLoadAwaitConfirm.value = true;
    update();

    final response = await http.get(
        Uri.parse(
            '${Api.baseUrl}/orders/orderConfirmItems/$id?confirm=$confirm&reason=$reason'),
        headers: authHeader());
    if (response.statusCode == 200) {
      ApiProcessorController.successSnack("Order items availability confirmed");
      vendorsOrderAwaitList.value = [];
      isLoadAwaitConfirm.value = false;
      update();
      getOrdersAwait();
      Get.close(1);
    } else {
      ApiProcessorController.errorSnack(jsonDecode(response.body)['detail']);
    }
    isLoadAwaitConfirm.value = false;
    update();
  }
}
