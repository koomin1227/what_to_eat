import 'package:http/http.dart' as http;

class NetworkService {
  static String baseURL = "http://43.202.161.19:8080/api";

  static getRestaurants(String place) {
    var url = Uri.parse("$baseURL/restaurants/tags").replace(queryParameters: {
      "tags": "맛있는",
      "place": place,
    });
    return http.get(url);
  }
}