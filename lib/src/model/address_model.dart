import '../providers/constants.dart';
import 'country_model.dart';

class DeliveryAddress {
  String id;
  int userId;
  String title;
  String details;
  String recipientName;
  String phone;
  CountryModel country;
  String state;
  String city;
  String latitude;
  String longitude;
  bool isCurrent;

  DeliveryAddress({
    required this.id,
    required this.userId,
    required this.title,
    required this.details,
    required this.recipientName,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.isCurrent,
    required this.latitude,
    required this.longitude,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return DeliveryAddress(
      id: json["id"] ?? notAvailable,
      userId: json["user_id"] ?? notAvailable,
      title: json["title"] ?? notAvailable,
      details: json["details"] ?? notAvailable,
      recipientName: json["recipient_name"] ?? notAvailable,
      phone: json["phone"] ?? notAvailable,
      country: CountryModel.fromJson(json),
      state: json["state"] ?? notAvailable,
      city: json["city"] ?? notAvailable,
      latitude: json["latitude"] ?? notAvailable,
      longitude: json["longitude"] ?? notAvailable,
      isCurrent: json["is_current"] ?? false,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "details": details,
        "phone": phone,
        "country": country.toJson(),
        "state": state,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
        "is_current": isCurrent,
      };
}
