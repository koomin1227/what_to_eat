import 'package:what_to_eat/models/tag.dart';

class Restaurant {
  final String name;
  final String thumbnail;
  final String restaurantId;
  final List<Tag> tags;

  Restaurant({
    required this.name,
    required this.thumbnail,
    required this.restaurantId,
    required this.tags,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'name': String name,
      'thumbnail': var thumbnail,
      'restaurantId': String restaurantId,
      'tags': var json,
      } =>
          Restaurant(
            name: name,
            thumbnail: thumbnail ?? '',
            restaurantId: restaurantId,
            tags: Tag.listFromJsonList(json),
          ),
      _ => throw const FormatException('Failed to load Restaurant.'),
    };
  }

  static List<Restaurant> listFromJson(Map<String, dynamic> json) {
    return [
      for (var element in json["restaurants"])
        Restaurant.fromJson(element)
    ];
  }
}