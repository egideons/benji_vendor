import 'dart:developer';

import 'package:benji_vendor/src/model/business_type_model.dart';
import 'package:get/get.dart';

import '../providers/constants.dart';
import 'country_model.dart';
import 'user_model.dart';

class BusinessModel {
  String id;
  CountryModel country;
  String state;
  String city;
  String address;
  String lga;
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
  UserModel vendorOwner;
  String latitude;
  String longitude;
  String businessId;
  String businessBio;
  String accountName;
  String accountNumber;
  String accountType;
  String accountBank;
  dynamic agent;
  double averageRating;
  int numberOfClientsReactions;
  double shopReward;

  BusinessModel({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.lga,
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
    required this.averageRating,
    required this.numberOfClientsReactions,
    required this.shopReward,
  });

  factory BusinessModel.fromJson(Map<String, dynamic>? json) {
    log("Business JSON: $json");
    json ??= {};
    return BusinessModel(
      id: json["id"] ?? '',
      country: CountryModel.fromJson(json['country'] ?? {}),
      state: json["state"] ?? notAvailable,
      city: json["city"] ?? notAvailable,
      lga: json["lga"] ?? notAvailable,
      address: json["address"] ?? notAvailable,
      shopName: json["shop_name"] ?? notAvailable,
      shopImage: json['shop_image'] == null || json['shop_image'] == ""
          ? 'https://ibb.co/j4d0VtC'
          : json['shop_image'],
      coverImage: json['coverImage'] == null || json['coverImage'] == ""
          ? 'https://ibb.co/9NqtrPt'
          : json['coverImage'],
      shopType: BusinessType.fromJson(json["shop_type"]),
      vendorOwner: UserModel.fromJson(json['vendor_owner']),
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
      averageRating: ((json["average_rating"] ?? 0.0) as double).toPrecision(1),
      numberOfClientsReactions: json["number_of_clients_reactions"] ?? 0,
      shopReward: double.parse((json['shopReward'] ?? 0.0).toString()),
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
        "vendor_owner": vendorOwner.toJson(),
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
        "average_rating": averageRating,
        "number_of_clients_reactions": numberOfClientsReactions,
      };
}
