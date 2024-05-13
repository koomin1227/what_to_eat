import 'model.dart';

class Res<T> {
  int statusCode;
  String message;
  T data;

  Res({
     required this.statusCode,
     required this.message,
     required this.data,
  });

  factory Res.fromJson(Map<String, dynamic> json, Model model) {
    return switch (json) {
      {
      'statusCode': int statusCode,
      'message': String message,
      'data': Map<String, dynamic> data,
      } =>
          Res(
            statusCode: statusCode,
            message: message,
            data: model.fromJson(data),
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
