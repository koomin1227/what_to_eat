import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:what_to_eat/models/jwt_tokens.dart';

import 'dio_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  final Dio dio = DioService().to();
  final storage = FlutterSecureStorage();

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  isLogin() async {
    String? accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null) {
      return false;
    } else {
      return true;
    }
  }
  
  loginWithKakao() async {
    OAuthToken? token = await getKakaoToken();
    if (token == null) {
      print("로그인 실패");
      throw Exception('login failed');
    }
    String? accessToken = token.accessToken;
    var response = await dio.post('/auth/kakao', data: {
      "token": accessToken,
    });
    if (response.statusCode == 200) {
      JwtTokens jwtTokens = JwtTokens.fromJson(response.data);
      await storage.write(key: 'accessToken', value: jwtTokens.accessToken);
      await storage.write(key: 'refreshToken', value: jwtTokens.refreshToken);
    } else {
      print("로그인 실패");
      throw Exception('login failed');
    }
  }

  logout() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
  }

  Future<OAuthToken?> getKakaoToken() async {
    if (await isKakaoTalkInstalled()) {
      try {
        return await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          Get.offAllNamed('/');
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          return await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return null;
        }
      }
    } else {
      try {
        return await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return null;
      }
    }
    return null;
  }
}
