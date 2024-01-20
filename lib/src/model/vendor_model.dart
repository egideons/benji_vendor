import 'dart:convert';
import 'dart:developer';

import '../providers/api_url.dart';
import '../providers/constants.dart';

VendorModel userModelFromJson(String str) =>
    VendorModel.fromJson(json.decode(str));

String userModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  int id;
  String token;
  String email;
  String phone;
  String username;
  String code;
  String firstName;
  String lastName;
  String gender;
  String address;
  String longitude;
  String latitude;
  String country;
  String state;
  String city;
  String lga;
  String profileLogo;

  VendorModel({
    required this.id,
    required this.token,
    required this.email,
    required this.phone,
    required this.username,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.state,
    required this.city,
    required this.lga,
    required this.profileLogo,
  });

  factory VendorModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    log("JSON data: $json");
    try {
      return VendorModel(
        id: json["id"] ?? 0,
        token: json["token"] ?? '',
        email: json["email"] ?? notAvailable,
        phone: json["phone"] ?? notAvailable,
        username: json["username"] ?? notAvailable,
        code: json["code"] ?? notAvailable,
        firstName: json["first_name"] ?? notAvailable,
        lastName: json["last_name"] ?? notAvailable,
        gender: json["gender"] ?? notAvailable,
        address: json["address"] ?? notAvailable,
        longitude: json["longitude"] ?? notAvailable,
        latitude: json["latitude"] ?? notAvailable,
        country: json["country"] ?? notAvailable,
        state: json["state"] ?? notAvailable,
        city: json["city"] ?? notAvailable,
        lga: json["lga"] ?? notAvailable,
        profileLogo: json["profileLogo"] ?? '',
      );
    } catch (e) {
      consoleLog("Error parsing average_rating: $e");
      return VendorModel.fromJson(null);
      //  return VendorModel.defaults();
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "email": email,
        "phone": phone,
        "username": username,
        "code": code,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "lga": lga,
        "profileLogo": profileLogo,
      };
}
