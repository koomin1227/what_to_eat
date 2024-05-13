import 'dart:convert';
import 'package:http/http.dart' as http;

class DataExtractor {
  static Map<String, dynamic> extractData(http.Response response) {
    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    return json["data"];
  }
}

