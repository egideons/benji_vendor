// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../providers/helper.dart';
import 'user_controller.dart';

class FormController extends GetxController {
  static FormController get instance {
    return Get.find<FormController>();
  }

  var isLoad = false.obs;
  var status = 0.obs;
  var responseObject = {}.obs;

  Future getAuth(String url, String tag,
      [String errorMsg = "Error occurred",
      String successMsg = "Submitted successfully"]) async {
    isLoad.value = true;
    update([tag]);
    final response = await http.get(
      Uri.parse(url),
      headers: authHeader(),
    );
    status.value = response.statusCode;
    consoleLog(response.body);

    update([tag]);
    if (response.statusCode != 200) {
      ApiProcessorController.errorSnack(errorMsg);
      isLoad.value = false;
      update([tag]);
      return;
    }

    ApiProcessorController.successSnack(successMsg);

    isLoad.value = false;
    update([tag]);
  }

  Future deleteAuth(String url, String tag,
      [String errorMsg = "Error occurred",
      String successMsg = "Submitted successfully"]) async {
    isLoad.value = true;
    update([tag]);
    final response = await http.delete(
      Uri.parse(url),
      headers: authHeader(),
    );
    status.value = response.statusCode;
    update([tag]);
    if (response.statusCode != 200) {
      ApiProcessorController.errorSnack(errorMsg);
      isLoad.value = false;
      update([tag]);
      return;
    }

    ApiProcessorController.successSnack(successMsg);
    isLoad.value = false;
    update([tag]);
  }

  // Future postAuth(String url, Map data, String tag,
  //     [String errorMsg = "Error occurred",
  //     String successMsg = "Submitted successfully"]) async {
  //   isLoad.value = true;
  //   update([tag]);
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: authHeader(),
  //     body: data,
  //   );
  //   status.value = response.statusCode;
  //   consoleLog(response.body);
  //   if (response.statusCode != 200) {
  //     ApiProcessorController.errorSnack(errorMsg);
  //     isLoad.value = false;
  //     update([tag]);
  //     return;
  //   }

  //   ApiProcessorController.successSnack(successMsg);
  //   isLoad.value = false;
  //   responseObject.value = jsonDecode(response.body) as Map;
  //   update([tag]);
  // }

  Future postAuth(String url, Map data, String tag,
      [String errorMsg = "Error occurred",
      String successMsg = "Submitted successfully"]) async {
    isLoad.value = true;
    update();
    update([tag]);
    final response = await http.post(
      Uri.parse(url),
      headers: authHeader(),
      body: data,
    );
    status.value = response.statusCode;
    consoleLog(response.body);
    var responseBody = jsonDecode(response.body);

    if (response.statusCode != 200) {
      ApiProcessorController.errorSnack(errorMsg);
      isLoad.value = false;
      update();
      update([tag]);
      return;
    } else {
      if (responseBody is String) {
        ApiProcessorController.successSnack(successMsg);
        isLoad.value = false;
        update();
        update([tag]);
      } else if (responseBody is Map) {
        responseObject.value = (responseBody);
        ApiProcessorController.successSnack(successMsg);
        isLoad.value = false;
        update();
        update([tag]);
      }
    }

    isLoad.value = false;
    update();
    update([tag]);
  }

  Future patchAuth(String url, Map data, String tag,
      [String errorMsg = "Error occurred",
      String successMsg = "Submitted successfully"]) async {
    isLoad.value = true;
    update();
    update([tag]);
    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: authHeader(),
        body: jsonEncode(data),
      );
      status.value = response.statusCode;
      consoleLog(response.body);
      var responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        ApiProcessorController.errorSnack(errorMsg);
        isLoad.value = false;
        update();
        update([tag]);
        return;
      } else {
        if (responseBody is String) {
          ApiProcessorController.successSnack(successMsg);
          isLoad.value = false;
          update();
          update([tag]);
        } else if (responseBody is Map) {
          responseObject.value = (responseBody);
          ApiProcessorController.successSnack(successMsg);
          isLoad.value = false;
          update();
          update([tag]);
        }
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
      ApiProcessorController.errorSnack(errorMsg);
    }

    isLoad.value = false;
    update();
    update([tag]);
  }

  Future postNoAuth(String url, Map data, String tag,
      [String errorMsg = "Error occurred",
      String successMsg = "Submitted successfully"]) async {
    isLoad.value = true;
    update([tag]);
    final response = await http.post(
      Uri.parse(url),
      body: data,
    );
    status.value = response.statusCode;
    if (response.statusCode != 200) {
      ApiProcessorController.errorSnack(errorMsg);
      isLoad.value = false;
      update([tag]);
      return;
    }

    ApiProcessorController.successSnack(successMsg);
    isLoad.value = false;
    responseObject.value = jsonDecode(response.body) as Map;
    update([tag]);
  }

  Future postAuthstream(
      String url, Map data, Map<String, File?> files, String tag,
      [String errorMsg = "Error occurred",
      String successMsg = "Submitted successfully",
      String noInternetMsg = "Please connect to the internet"]) async {
    http.StreamedResponse? response;

    isLoad.value = true;
    update();
    update([tag]);

    var request = http.MultipartRequest("POST", Uri.parse(url));
    Map<String, String> headers = authHeader();
    consoleLog("This is the image: ${files.toString()}");
    try {
      for (String key in files.keys) {
        if (files[key] == null) {
          continue;
        }

        request.files.add(await http.MultipartFile.fromPath(
            key, files[key]!.path,
            filename: files[key]!.path.split('/').last));
      }
      consoleLog("${request.files.map((e) => [
            e.filename,
            e.field,
            e.contentType
          ]).toList()}");

      request.headers.addAll(headers);

      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      consoleLog('request.fields ${request.fields}');
      consoleLog('stream response emma $response');
      // try {
      response = await request.send();
      consoleLog('pass 1 $response');
      status.value = response.statusCode;
      consoleLog('pass 2');
      final normalResp = await http.Response.fromStream(response);
      consoleLog('pass 3 ${response.statusCode}');
      consoleLog('resp response $normalResp');
      consoleLog('stream response ${normalResp.body}');
      if (response.statusCode == 200) {
        UserController.instance.saveUser(
            normalResp.body, UserController.instance.user.value.token);

        ApiProcessorController.successSnack(successMsg);
        isLoad.value = false;
        update();
        update([tag]);
      }
    } on SocketException {
      ApiProcessorController.errorSnack(noInternetMsg);
    } catch (e) {
      ApiProcessorController.errorSnack(errorMsg);
    }
    // } catch (e) {
    //   response = null;
    // }

    isLoad.value = false;
    update();
    update([tag]);
    return;
  }

  Future putAuthstream(
      String url, Map data, Map<String, File?> files, String tag,
      [String errorMsg = "Error occurred",
      String successMsg = "Submitted successfully"]) async {
    http.StreamedResponse? response;
    consoleLog('we in the in');
    isLoad.value = true;
    update();
    update([tag]);

    var request = http.MultipartRequest("PUT", Uri.parse(url));
    Map<String, String> headers = authHeader();

    for (String key in files.keys) {
      if (files[key] == null) {
        continue;
      }
      request.files
          .add(await http.MultipartFile.fromPath(key, files[key]!.path));
    }
    consoleLog("${request.files}");

    request.headers.addAll(headers);

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    consoleLog('request.fields ${request.fields}');
    consoleLog('stream response emma $response');
    // try {
    response = await request.send();
    consoleLog('pass 1 $response');
    status.value = response.statusCode;
    consoleLog('pass 2');
    final normalResp = await http.Response.fromStream(response);
    consoleLog('pass 3 ${response.statusCode}');
    consoleLog('resp response $normalResp');
    consoleLog('stream response ${normalResp.body}');
    if (response.statusCode == 200) {
      ApiProcessorController.successSnack(successMsg);
      isLoad.value = false;
      update();
      update([tag]);
      return;
    }
    // } catch (e) {
    //   response = null;
    // }

    ApiProcessorController.errorSnack(errorMsg);
    isLoad.value = false;
    update();
    update([tag]);
    return;
  }
}
