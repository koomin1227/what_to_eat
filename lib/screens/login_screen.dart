import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = FlutterSecureStorage();
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginController.checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "내가 찾는 식당이 여기에",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
                onTap: () async => loginController.loginWithKakao(),
                child:
                    Image.asset("assets/images/kakao_login_medium_narrow.png")),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({
    super.key,
    required this.storage,
  });

  final FlutterSecureStorage storage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await storage.write(key: 'token', value: 'hello');
          print('token 넣었다.');
          Get.toNamed('/main');
        },
        child: Text('로그인'));
  }
}
