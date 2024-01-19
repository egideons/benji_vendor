// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromJson(jsonString);

import 'dart:developer';

import 'package:benji_vendor/src/model/business_type_model.dart';
import 'package:benji_vendor/src/model/vendor_model.dart';

import '../providers/constants.dart';
import 'country_model.dart';

class BusinessModel {
  String id;
  CountryModel country;
  String state;
  String city;
  String address;
  String shopName;
  dynamic shopImage;
  dynamic coverImage;
  BusinessType shopType;
  String weekOpeningHours;
  String weekClosingHours;
  String satOpeningHours;
  String satClosingHours;
  String sunWeekOpeningHours;
  String sunWeekClosingHours;
  VendorModel vendorOwner;
  String latitude;
  String longitude;
  String businessId;
  String businessBio;
  String accountName;
  String accountNumber;
  String accountType;
  String accountBank;
  dynamic agent;

  BusinessModel({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.shopImage,
    required this.coverImage,
    required this.shopType,
    required this.shopName,
    required this.vendorOwner,
    required this.latitude,
    required this.longitude,
    required this.weekOpeningHours,
    required this.weekClosingHours,
    required this.satOpeningHours,
    required this.satClosingHours,
    required this.sunWeekOpeningHours,
    required this.sunWeekClosingHours,
    required this.businessId,
    required this.businessBio,
    required this.accountName,
    required this.accountNumber,
    required this.accountType,
    required this.accountBank,
    required this.agent,
  });

  factory BusinessModel.fromJson(Map<String, dynamic>? json) {
    log("Business JSON: $json");
    json ??= {};
    return BusinessModel(
      id: json["id"] ?? '',
      country: CountryModel.fromJson(json['country'] ?? {}),
      state: json["state"] ?? notAvailable,
      city: json["city"] ?? notAvailable,
      address: json["address"] ?? notAvailable,
      shopName: json["shop_name"] ?? notAvailable,
      shopImage: json["shop_image"] ?? "",
      coverImage: json['coverImage'] ?? notAvailable,
      shopType: BusinessType.fromJson(json["shop_type"]),
      vendorOwner: VendorModel.fromJson(json['vendor_owner']),
      weekOpeningHours: json["weekOpeningHours"] ?? notAvailable,
      weekClosingHours: json["weekClosingHours"] ?? notAvailable,
      satOpeningHours: json["satOpeningHours"] ?? notAvailable,
      satClosingHours: json["satClosingHours"] ?? notAvailable,
      sunWeekOpeningHours: json["sunWeekOpeningHours"] ?? notAvailable,
      sunWeekClosingHours: json["sunWeekClosingHours"] ?? notAvailable,
      latitude: json["latitude"] ?? notAvailable,
      longitude: json["longitude"] ?? notAvailable,
      businessId: json["businessId"] ?? notAvailable,
      businessBio: json["businessBio"] ?? notAvailable,
      accountName: json["accountName"] ?? notAvailable,
      accountNumber: json["accountNumber"] ?? notAvailable,
      accountType: json["accountType"] ?? notAvailable,
      accountBank: json["accountBank"] ?? notAvailable,
      agent: json['agent'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "shop_name": shopName,
        "shop_image": shopImage,
        "shop_type": shopType.toJson(),
        "weekOpeningHours": weekOpeningHours,
        "weekClosingHours": weekClosingHours,
        "satOpeningHours": satOpeningHours,
        "satClosingHours": satClosingHours,
        "sunWeekOpeningHours": sunWeekOpeningHours,
        "sunWeekClosingHours": sunWeekClosingHours,
        "latitude": latitude,
        "longitude": longitude,
        "businessId": businessId,
        "businessBio": businessBio,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "accountType": accountType,
        "accountBank": accountBank,
      };
}
