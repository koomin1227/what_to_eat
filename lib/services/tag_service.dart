import 'package:dio/dio.dart';

import '../models/tag.dart';
import 'dio_service.dart';

class TagService {
  static final TagService _instance = TagService._internal();

  final Dio dio = DioService().to();

  TagService._internal();

  factory TagService() {
    return _instance;
  }

  Future<List<Tag>> getTagList() async {
    var response = await dio.get("/tags");
    return Tag.listFromJson(response.data);
  }
}