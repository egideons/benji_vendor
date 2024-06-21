// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/order_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/order_model.dart';
import 'package:benji_vendor/src/model/task_item_status_update.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderStatusChangeController extends GetxController {
  static OrderStatusChangeController get instance {
    return Get.find<OrderStatusChangeController>();
  }

  var isLoadUpdateStatus = false.obs;
  var hasFetched = false.obs;
  late WebSocketChannel channelTask;
  var taskItemStatusUpdate = TaskItemStatusUpdate.fromJson(null).obs;

  var isLoad = false.obs;

  var order = OrderModel.fromJson(null).obs;

  void setOrder(OrderModel newOrder) {
    order.value = newOrder;
    update();
    // refreshOrder();
  }

  deleteCachedOrder() {
    order.value = OrderModel.fromJson(null);
    update();
  }

  resetOrder() async {
    order.value = OrderModel.fromJson(null);
    update();
  }

  Future refreshOrder() async {
    var url = "${Api.baseUrl}/orders/order/${order.value.id}";
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    OrderController.instance.getOrders();

    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }

    try {
      order.value = OrderModel.fromJson(jsonDecode(responseData));
    } catch (e) {}
    isLoad.value = false;
    update();
  }

  getTaskItemSocket() {
    final wsUrlTask = Uri.parse('$websocketBaseUrl/orderStatus/');
    channelTask = WebSocketChannel.connect(wsUrlTask);
    channelTask.sink.add(jsonEncode({
      'user_id': UserController.instance.user.value.id,
      'order_id': order.value.id,
      'user_type': 'vendor'
    }));

    Timer.periodic(const Duration(seconds: 10), (timer) {
      channelTask.sink.add(jsonEncode({
        'user_id': UserController.instance.user.value.id,
        'order_id': order.value.id,
        'user_type': 'vendor'
      }));
    });

    channelTask.stream.listen((message) {
      log(message);
      taskItemStatusUpdate.value =
          TaskItemStatusUpdate.fromJson(jsonDecode(message));
      refreshOrder();
      if (hasFetched.value != true) {
        hasFetched.value = true;
      }
      update();
    });
  }

  updateTaskItemStatus({String query = ""}) async {
    try {
      isLoadUpdateStatus.value = true;
      update();

      var url = "${Api.baseUrl}${taskItemStatusUpdate.value.url}$query";
      final response = await http.get(
        Uri.parse(url),
        headers: authHeader(),
      );

      dynamic data = jsonDecode(response.body);

      if (response.statusCode.toString().startsWith('2')) {
        channelTask.sink.add(jsonEncode({
          'user_id': UserController.instance.user.value.id,
          'order_id': order.value.id,
          'user_type': 'vendor'
        }));
        order.value = OrderModel.fromJson(data);
        ApiProcessorController.successSnack("Updated successfully");
      } else {
        ApiProcessorController.errorSnack(data['detail']);
      }
    } on SocketException {
      ApiProcessorController.errorSnack(
          "No internet connection. Please check your network settings.");
    }
    isLoadUpdateStatus.value = false;
    update();
  }

  closeTaskSocket() {
    channelTask.sink.close(1000);
  }
}
