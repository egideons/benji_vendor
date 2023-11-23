// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:benji_vendor/src/model/address_model.dart';
import 'package:benji_vendor/src/model/client_model.dart';
import 'package:benji_vendor/src/model/product_model.dart';

import '../providers/constants.dart';

class OrderModel {
  String id;
  String code;
  double totalPrice;
  double deliveryFee;
  String assignedStatus;
  String deliveryStatus;
  Client client;
  List<Orderitem> orderitems;
  double preTotal;
  String latitude;
  String longitude;
  String deliveryAddress;
  String message;
  String created;

  OrderModel({
    required this.id,
    required this.code,
    required this.totalPrice,
    required this.deliveryFee,
    required this.assignedStatus,
    required this.deliveryStatus,
    required this.client,
    required this.orderitems,
    required this.preTotal,
    required this.latitude,
    required this.longitude,
    required this.deliveryAddress,
    required this.message,
    required this.created,
  });

  factory OrderModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return OrderModel(
      id: json["id"] ?? notAvailable,
      code: json["code"] ?? notAvailable,
      totalPrice: json["total_price"] ?? 0.0,
      deliveryFee: json["delivery_fee"] ?? 0.0,
      assignedStatus: json["assigned_status"] ?? "PEND",
      deliveryStatus: json["delivery_status"] ?? "PEND",
      client: Client.fromJson(json["client"]),
      orderitems:
          // (json["orderitems"] as List)
          //     .map((item) => Orderitem.fromJson(item))
          //     .toList(),
          json["orderitems"] == null
              ? []
              : (json["orderitems"] as List)
                  .map((item) => Orderitem.fromJson(item))
                  .toList(),
      preTotal:
          json["pre_total"] != null ? double.parse(json["pre_total"]) : 0.0,
      latitude: json["latitude"] ?? notAvailable,
      longitude: json["longitude"] ?? notAvailable,
      deliveryAddress: json["delivery_address"] ?? notAvailable,
      message: json["message"] ?? notAvailable,
      created: json["created"] ?? notAvailable,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "total_price": totalPrice,
        "delivery_fee": deliveryFee,
        "assigned_status": assignedStatus,
        "delivery_status": deliveryStatus,
        "client": client.toJson(),
        "orderitems": orderitems.map((item) => (item).toJson()).toList(),
        "pre_total": preTotal,
        "latitude": latitude,
        "longitude": longitude,
        "delivery_address": deliveryAddress,
        "message": message,
        "created": created,
      };
}

class Orderitem {
  String id;
  ProductModel product;
  int quantity;
  DeliveryAddress deliveryAddress;

  Orderitem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.deliveryAddress,
  });

  factory Orderitem.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Orderitem(
      id: json["id"] ?? notAvailable,
      product: ProductModel.fromJson(json["product"]),
      deliveryAddress: DeliveryAddress.fromJson(json["delivery_address"]),
      quantity: json["quantity"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "delivery_address": deliveryAddress.toJson(),
        "quantity": quantity,
      };
}
