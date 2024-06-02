import 'package:get/get.dart';
import 'package:what_to_eat/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService();

  loginWithKakao() async {
    try{
      await authService.loginWithKakao();
      Get.offAllNamed('/main');
    } catch (e) {
      Get.offAllNamed('/');
    }
  }

  checkLogin() async {
    if(await authService.isLogin()) {
      print('token 이 있다.');
      Get.offAllNamed('/main');
    } else {
      print('token 이 없다.');
    }
  }
}
