import 'dart:convert';
import 'dart:io';

import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/bank_model.dart';
import 'package:benji_vendor/src/model/validate_bank_account.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WithdrawController extends GetxController {
  static WithdrawController get instance {
    return Get.find<WithdrawController>();
  }

  var isLoadWithdraw = false.obs;
  var isLoad = false.obs;
  var isLoadValidateAccount = false.obs;
  var userId = UserController.instance.user.value.id;
  var listOfBanks = <BankModel>[].obs;
  var listOfBanksSearch = <BankModel>[].obs;
  var validateAccount = ValidateBankAccountModel.fromJson(null).obs;
  var noWithdrawalHistory = "".obs;

  searchBanks(String search) {
    listOfBanksSearch = listOfBanks;
    listOfBanksSearch.value =
        listOfBanksSearch.where((str) => str.name.contains(search)).toList();
    update();
  }

  // makeWithdrawal(double amount) {
  //   final userId = UserController.instance.user.value.id;
  // }

  listBanks() async {
    var url = "${Api.baseUrl}${Api.listBanks}";
    isLoad.value = true;
    update();
    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());
      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          listOfBanks.value =
              BankModel.listFromJson(jsonResponse.cast<Map<String, dynamic>>());
          listOfBanksSearch = listOfBanks;
        } else if (jsonResponse is Map) {
          if (jsonResponse.containsKey('items')) {
            listOfBanks.value = BankModel.listFromJson(
                jsonResponse['items'].cast<Map<String, dynamic>>());
            listOfBanksSearch = listOfBanks;
          } else {
            listOfBanks.value = [];
            listOfBanksSearch.value = [];
          }
        } else {
          listOfBanks.value = [];
          listOfBanksSearch.value = [];
        }
      } else {
        listOfBanks.value = [];
        listOfBanksSearch.value = [];
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    }
    isLoad.value = false;
    update();
  }

  Future<void> validateBankNumbers(
      String accountNumber, String bankCode) async {
    var url =
        "${Api.baseUrl}${Api.validateBankNumber}?account_number=$accountNumber&bank_code=$bankCode";
    isLoadValidateAccount.value = true;
    update();

    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());

      if (response.statusCode != 200) {
        validateAccount.value = ValidateBankAccountModel.fromJson(null);
        return;
      }
      var responseData = jsonDecode(response.body);
      validateAccount.value = ValidateBankAccountModel.fromJson(
          responseData as Map<String, dynamic>);
      // responseData.map((item) => ValidateBankAccountModel.fromJson(item));
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e");
    }

    isLoadValidateAccount.value = false;
    update();
    return;
  }
}
