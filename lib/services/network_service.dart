import 'package:http/http.dart' as http;

class NetworkService {
  static String baseURL = "http://43.202.161.19:8080/api";

  static getRestaurants(String place, int page) {
    var url = Uri.parse("$baseURL/restaurants/tag")
        .replace(queryParameters: makeQueryOptions(place, page));
    return http.get(url);
  }

  static getRestaurantsBySearch(String keyword, int page) {
    var url = Uri.parse("$baseURL/restaurants/keyword")
        .replace(queryParameters: makeSearchQueryOptions(keyword, page));
    return http.get(url);
  }

  static Map<String, dynamic> makeQueryOptions(String place, int page) {
    Map<String, dynamic> query = {};
    if (place != "전체") {
      query["place"] = place;
    }
    query["page"] = page.toString();
    return query;
  }

  static Map<String, dynamic> makeSearchQueryOptions(String keyword, int page) {
    Map<String, dynamic> query = {};
    query["keyword"] = keyword;
    query["page"] = page.toString();
    return query;
  }
}