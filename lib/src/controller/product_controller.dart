// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/product_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  static ProductController get instance {
    return Get.find<ProductController>();
  }

  var isLoad = false.obs;
  var products = <ProductModel>[].obs;

  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;

  Future<void> scrollListener(scrollController) async {
    if (ProductController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      ProductController.instance.isLoadMore.value = true;
      update();
      await ProductController.instance.getProducts();
    }
  }

  reset() {
    loadedAll.value = false;
    loadNum.value = 10;
    products.value = products.toList();
    update();
  }

  Future getProducts() async {
    if (loadedAll.value) {
      return;
    }

    isLoad.value = true;

    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}/vendors/$id/listMyProducts?start=${loadNum.value - 10}&end=${loadNum.value}";
    loadNum.value += 10;
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoad.value = false;
      loadedAll.value = true;
      isLoadMore.value = false;
      update();
      return;
    }
    List<ProductModel> data = [];
    try {
      data = (jsonDecode(responseData)['items'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      products.value += data;
    } catch (e) {
      consoleLog(e.toString());
    }
    loadedAll.value = data.isEmpty;
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }
}
