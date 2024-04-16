import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:benji_vendor/src/controller/error_controller.dart';

import '../providers/api_url.dart';
import '../providers/constants.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
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
  bool isOnline;

  UserModel({
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
    required this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    log("JSON data: $json");
    try {
      return UserModel(
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
        profileLogo: json['profileLogo'] == null || json['profileLogo'] == ""
            ? 'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049569.jpg'
            : json['profileLogo'],
        isOnline: json["is_online"] ?? false,
      );
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
      return UserModel.fromJson(null);
    } catch (e) {
      consoleLog("Error parsing average_rating: $e");
      return UserModel.fromJson(null);
      //  return UserModel.defaults();
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
        "is_online": isOnline,
      };
}
