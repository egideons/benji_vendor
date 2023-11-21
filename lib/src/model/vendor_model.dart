// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromJson(jsonString);

import 'dart:convert';

import 'package:benji_vendor/src/model/business_type_model.dart';
import 'package:get/get.dart';

import '../providers/constants.dart';

// vendorModelFromJson(String str) => List<VendorModel>.from(
//     json.decode(str).map((x) => VendorModel.fromJson(x)));

VendorModel vendorModelFromJson(String str) =>
    VendorModel.fromJson(json.decode(str));

String vendorModelToJson(List<VendorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorModel {
  int id;
  String email;
  String phone;
  String username;
  String code;
  String firstName;
  String lastName;
  String gender;
  String address;
  bool isOnline;
  double averageRating;
  int numberOfClientsReactions;
  String shopName;
  String shopImage;
  String profileLogo;
  BusinessType shopType;
  String weekOpeningHours;
  String weekClosingHours;
  String satOpeningHours;
  String satClosingHours;
  String sunWeekOpeningHours;
  String sunWeekClosingHours;
  String description;

  VendorModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.username,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.isOnline,
    required this.averageRating,
    required this.numberOfClientsReactions,
    required this.shopName,
    required this.shopImage,
    required this.profileLogo,
    required this.shopType,
    required this.weekOpeningHours,
    required this.weekClosingHours,
    required this.satOpeningHours,
    required this.satClosingHours,
    required this.sunWeekOpeningHours,
    required this.sunWeekClosingHours,
    required this.description,
  });

  factory VendorModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return VendorModel(
      id: json["id"] ?? 0,
      email: json["email"] ?? notAvailable,
      phone: json["phone"] ?? notAvailable,
      username: json["username"] ?? notAvailable,
      code: json["code"] ?? notAvailable,
      firstName: json["first_name"] ?? notAvailable,
      lastName: json["last_name"] ?? notAvailable,
      gender: json["gender"] ?? notAvailable,
      address: json["address"] ?? notAvailable,
      isOnline: json["is_online"] ?? false,
      averageRating: ((json["average_rating"] ?? 0.0) as double).toPrecision(1),
      // json["average_rating"] != null
      //     ? (json["average_rating"] is double
      //         ? json["average_rating"]
      //         : double.tryParse(json["average_rating"].toString()) ?? 0.0)
      //     : 0.0,
      numberOfClientsReactions: json["number_of_clients_reactions"] ?? 0,
      shopName: json["shop_name"] ?? notAvailable,
      shopImage: json["shop_image"] ?? "",
      profileLogo: json["profileLogo"] ?? "",
      shopType: BusinessType.fromJson(json["shop_type"]),
      weekOpeningHours: json["weekOpeningHours"] ?? notAvailable,
      weekClosingHours: json["weekClosingHours"] ?? notAvailable,
      satOpeningHours: json["satOpeningHours"] ?? notAvailable,
      satClosingHours: json["satClosingHours"] ?? notAvailable,
      sunWeekOpeningHours: json["sunWeekOpeningHours"] ?? notAvailable,
      sunWeekClosingHours: json["sunWeekClosingHours"] ?? notAvailable,
      description: json["description"] ?? notAvailable,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "username": username,
        "code": code,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "address": address,
        "is_online": isOnline,
        "average_rating": averageRating,
        "number_of_clients_reactions": numberOfClientsReactions,
        "shop_name": shopName,
        "shop_image": shopImage,
        "profileLogo": profileLogo,
        "shop_type": shopType.toJson(),
        "weekOpeningHours": weekOpeningHours,
        "weekClosingHours": weekClosingHours,
        "satOpeningHours": satOpeningHours,
        "satClosingHours": satClosingHours,
        "sunWeekOpeningHours": sunWeekOpeningHours,
        "sunWeekClosingHours": sunWeekClosingHours,
        "description": description,
      };
}
