import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:sarana_hidayah/screen/login_page.dart';
import 'package:sarana_hidayah/service/auth_service.dart';
import 'package:sarana_hidayah/widgets/input_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = Get.put(AuthService());

  void _register() async {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password and confirm password do not match');
      return;
    }

    await _authService.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register Page',
              style: GoogleFonts.poppins(fontSize: size * 0.080),
            ),
            SizedBox(height: 30),
            InputWidget(
              hintText: 'Name',
              controller: _nameController,
              obscuredText: false,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Email',
              controller: _emailController,
              obscuredText: false,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Password',
              controller: _passwordController,
              obscuredText: true,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Confirm Password',
              controller: _confirmPasswordController,
              obscuredText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: _register,
              child: Text(
                'Register',
                style: GoogleFonts.poppins(
                  fontSize: size * 0.040,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(() => LoginPage());
              },
              child: Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: size * 0.040,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
