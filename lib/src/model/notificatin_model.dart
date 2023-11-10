import 'dart:convert';

import 'package:benji_vendor/src/model/client_model.dart';
import 'package:benji_vendor/src/model/user_model.dart';
import 'package:benji_vendor/src/providers/helper.dart';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String id;
  DateTime created;
  String message;
  Client client;
  UserModel vendor;

  NotificationModel({
    required this.id,
    required this.created,
    required this.message,
    required this.client,
    required this.vendor,
  });

  factory NotificationModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return NotificationModel(
      id: json["id"] ?? notAvailable,
      created: json["created"] == null
          ? DateTime.now()
          : DateTime.parse(json["created"]),
      message: json["message"],
      client: Client.fromJson(json["client"]),
      vendor: UserModel.fromJson(json["vendor"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created.toIso8601String(),
        "message": message,
        "client": client.toJson(),
        "vendor": vendor,
      };
}
