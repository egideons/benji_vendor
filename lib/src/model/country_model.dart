import '../providers/constants.dart';

class CountryModel {
  String code, name;

  CountryModel({
    required this.code,
    required this.name,
  });

  factory CountryModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return CountryModel(
      code: json["code"] ?? notAvailable,
      name: json["name"] ?? notAvailable,
    );
  }
  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
