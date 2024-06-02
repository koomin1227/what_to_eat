import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioService {
  static final DioService _dioServices = DioService._internal();
  final _storage = FlutterSecureStorage();
  factory DioService() => _dioServices;
  Map<String, dynamic> dioInformation = {};
  String? _cachedToken;

  static Dio _dio = Dio();

  DioService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://43.202.161.19:8080/api",
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
    );
    _dio = Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        _cachedToken ??= await _storage.read(key: 'accessToken');
        if (_cachedToken != null) {
          options.headers['Authorization'] = 'Bearer $_cachedToken';
        }
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print(response.statusCode);
        response.data = response.data["data"];
        return handler.next(response);
      },
    ));
  }

  Dio to() {
    return _dio;
  }
}