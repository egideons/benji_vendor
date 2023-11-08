import 'package:benji_vendor/src/model/order_model.dart';
import 'package:benji_vendor/src/model/rider_model.dart';
import 'package:benji_vendor/src/providers/helper.dart';

class RiderHistory {
  String id;
  OrderModel order;
  RiderItem driver;
  String acceptanceStatus;
  String deliveryStatus;
  String createdDate;
  String deliveredDate;

  RiderHistory({
    required this.id,
    required this.order,
    required this.driver,
    required this.acceptanceStatus,
    required this.deliveryStatus,
    required this.createdDate,
    required this.deliveredDate,
  });

  factory RiderHistory.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return RiderHistory(
        id: json["id"] ?? notAvailable,
        order: OrderModel.fromJson(json["order"]),
        driver: RiderItem.fromJson(json["driver"]),
        acceptanceStatus: json["acceptance_status"] ?? "PEND",
        deliveryStatus: json["delivery_status"] ?? "pending",
        createdDate: json["created_date"] ?? notAvailable,
        deliveredDate: json["delivered_date"] ?? notAvailable);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order.toJson(),
        "driver": driver.toJson(),
        "acceptance_status": acceptanceStatus,
        "delivery_status": deliveryStatus,
        "created_date": createdDate,
        "delivered_date": deliveredDate,
      };
}
