import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sarana_hidayah/screen/login_page.dart';
import 'package:sarana_hidayah/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool checkIfAdmin(String email) {
    return email == "superadmin@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = "superadmin@gmail.com";
    bool isAdmin = checkIfAdmin(userEmail);

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
              home: LoginPage(isAdmin: isAdmin),
            );
          }
        });
  }
}
