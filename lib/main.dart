import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/controller/category_controller.dart';
import 'package:sarana_hidayah/screen/auth/login_page.dart';
import 'package:sarana_hidayah/screen/splash_screen.dart';

void main() {
  Get.put(CategoryController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const LoginPage(),
            );
          }
        });
  }
}

// superadmin@gmail.com