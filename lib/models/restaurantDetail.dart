import 'package:what_to_eat/models/restaurant.dart';
import 'package:what_to_eat/models/tag.dart';

class RestaurantDetail extends Restaurant {
  final List<String> reviews;

  RestaurantDetail({
    required super.name,
    required super.thumbnail,
    required super.restaurantId,
    required super.tags,
    required this.reviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      reviews: List<String>.from(parseReview(json['reviews'])),
      name: json['name'],
      thumbnail: json['thumbnail'] ?? '',
      restaurantId: json['restaurantId'],
      tags: Tag.listFromJsonList(json['tags']),

    );
  }

  static parseReview(List<dynamic> json) {
    return json.map((element) {
      return element["review"];
    }).toList();
  }
}
