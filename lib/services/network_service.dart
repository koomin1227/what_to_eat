import 'package:http/http.dart' as http;

class NetworkService {
  static String baseURL = "http://43.202.161.19:8080/api";

  static getRestaurants(String place) {
    var url = Uri.parse("$baseURL/restaurants/tag")
        .replace(queryParameters: makeQueryOptions(place));
    return http.get(url);
  }

  static Map<String, dynamic> makeQueryOptions(String place) {
    Map<String, dynamic> query = {};
    if (place != "전체") {
      query["place"] = place;
    }
    return query;
  }
}