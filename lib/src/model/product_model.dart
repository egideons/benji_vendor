import 'package:benji_vendor/src/model/sub_category.dart';

import '../providers/constants.dart';
import 'business_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantityAvailable;
  final String productImage;
  final bool isAvailable;
  final bool isTrending;
  final bool isRecommended;
  final BusinessModel business;
  final SubCategory subCategory;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantityAvailable,
    required this.productImage,
    required this.isAvailable,
    required this.isTrending,
    required this.isRecommended,
    required this.business,
    required this.subCategory,
  });

  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ProductModel(
      id: json['id'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      price: (json['price'] ?? 0).toDouble() ?? 0.0,
      quantityAvailable: json['quantity_available'] ?? 0,
      productImage: json['product_image'] ?? '',
      isAvailable: json['is_available'] ?? false,
      isTrending: json['is_trending'] ?? false,
      isRecommended: json['is_recommended'] ?? false,
      business: BusinessModel.fromJson(json['business']),
      subCategory: SubCategory.fromJson(json['sub_category']),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "quantity_available": quantityAvailable,
        "product_image": productImage,
        "is_available": isAvailable,
        "is_trending": isTrending,
        "is_recommended": isRecommended,
        "business": business.toJson(),
        "sub_category_id": subCategory.toJson(),
      };
}


// class ProductModel {
//   String id;
//   String name;
//   String description;
//   double price;
//   int quantityAvailable;
//   String productImage;
//   bool isAvailable;
//   bool isTrending;
//   bool isRecommended;
//   UserModel vendor;
//   SubCategory subCategory;

//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.quantityAvailable,
//     required this.productImage,
//     required this.isAvailable,
//     required this.isTrending,
//     required this.isRecommended,
//     required this.vendor,
//     required this.subCategory,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic>? json) {
//     json ??= {};
//     return ProductModel(
//       id: json["id"] ?? notAvailable,
//       name: json["name"] ?? notAvailable,
//       description: json["description"] ?? notAvailable,
//       // price:
//       //     json["price"] != null ? double.parse(json["price"].toString()) : 0.0,
//       price: json["price"] ?? 0.0,
//       quantityAvailable: json["quantity_available"] ?? 0,
//       productImage: json["product_image"] ?? '',
//       isAvailable: json["is_available"] ?? false,
//       isTrending: json["is_trending"] ?? false,
//       isRecommended: json["is_recommended"] ?? false,
//       vendor: UserModel.fromJson(json["vendor"]),
//       subCategory: SubCategory.fromJson(json["sub_category"]),
//     );
//   }
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "price": price,
//         "quantity_available": quantityAvailable,
//         "product_image": productImage,
//         "is_available": isAvailable,
//         "is_trending": isTrending,
//         "is_recommended": isRecommended,
//         "vendor_id": vendor.toJson(),
//         "sub_category_id": subCategory.toJson(),
//       };
// }
