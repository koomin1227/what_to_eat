import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:what_to_eat/screens/login_screen.dart';
import 'package:what_to_eat/screens/main_screen.dart';
import 'screens/restaurant_list_screen.dart';
import 'screens/vote_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade600, primary: Color(0xffF77248)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () =>  LoginScreen()),
        GetPage(name: '/main', page: () => MainScreen()),
      ],
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
