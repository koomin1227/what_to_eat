import 'dart:async';

import 'package:dio/dio.dart';
import 'package:what_to_eat/models/restaurant.dart';
import 'package:what_to_eat/models/restaurantDetail.dart';

import 'dio_service.dart';

class RestaurantService {
  static final RestaurantService _instance = RestaurantService._internal();

  final Dio dio = DioService().to();

  RestaurantService._internal();

  factory RestaurantService() {
    return _instance;
  }

  Future<List<Restaurant>> getRestaurantListByTag(String place, List<String> tags, int page) async {
    var queryParameters = _makeQueryOptions(place, tags, page);
    var response = await dio.get("/restaurants/tag", queryParameters: queryParameters);
    return Restaurant.listFromJson(response.data);
  }

  Future<List<Restaurant>> getRestaurantListByKeyword(String keyword, int page) async {
    var response = await dio.get("/restaurants/keyword", queryParameters: {
      "keyword": keyword,
      "page": page.toString(),
    });
    return Restaurant.listFromJson(response.data);
  }

  Future<RestaurantDetail> getRestaurant(String restaurantId) async {
    var response = await dio.get("/restaurants/$restaurantId");
    return RestaurantDetail.fromJson(response.data);
  }

  static Map<String, dynamic> _makeQueryOptions(String place, List<String> tags, int page) {
    Map<String, dynamic> query = {};
    if (place != "전체") {
      query["place"] = place;
    }
    if (tags.isNotEmpty) {
      query["tags"] = [];
      for (var tag in tags) {
        query["tags"].add(tag);
      }
    }
    query["page"] = page.toString();
    return query;
  }
}