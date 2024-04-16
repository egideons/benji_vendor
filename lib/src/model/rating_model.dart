import 'dart:convert';

import 'package:benji_vendor/src/model/client_model.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:http/http.dart' as http;

import '../providers/constants.dart';
import '../providers/helpers.dart';

class Ratings {
  final String id;
  final double ratingValue;
  final String comment;
  final DateTime created;
  final Client client;

  Ratings({
    required this.id,
    required this.ratingValue,
    required this.comment,
    required this.created,
    required this.client,
  });

  factory Ratings.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Ratings(
      id: json['id'] ?? notAvailable,
      ratingValue: json['rating_value'] ?? 0.0,
      comment: json['comment'] ?? notAvailable,
      created: json['created'] == null
          ? DateTime.now()
          : DateTime.parse(json['created']),
      client: Client.fromJson(json['client']),
    );
  }
}

Future<List<Ratings>> getRatingsByVendorId(String id,
    {start = 0, end = 10}) async {
  // url to be changed to agent endpoint
  final response = await http.get(
    Uri.parse('$baseURL/agents/getBusinessRatings/$id?start=$start&end=$end'),
    headers: authHeader(),
  );
  print('$baseURL/agents/getBusinessRatings/$id?start=$start&end=$end');

  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => Ratings.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<List<Ratings>> getRatingsByVendorIdAndRating(int id, int rating,
    {start = 0, end = 10}) async {
  // url to be changed to agent endpoint

  final response = await http.get(
    Uri.parse(
        '$baseURL/clients/filterVendorReviewsByRating/$id?rating_value=$rating'),
    headers: authHeader(),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Ratings.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
