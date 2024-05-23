import 'package:dio/dio.dart';

class DioService {
  static final DioService _dioServices = DioService._internal();
  factory DioService() => _dioServices;
  Map<String, dynamic> dioInformation = {};

  static Dio _dio = Dio();

  DioService._internal() {
    BaseOptions _options = BaseOptions(
      baseUrl: "http://43.202.161.19:8080/api",
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
      // headers: {},
    );
    _dio = Dio(_options);
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        response.data = response.data["data"];
        return handler.next(response);
      },
    ));
  }

  Dio to() {
    return _dio;
  }
}