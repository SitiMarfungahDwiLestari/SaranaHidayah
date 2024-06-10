import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarana_hidayah/controller/login_controller.dart';
import 'package:sarana_hidayah/screen/register_page.dart';
import 'package:sarana_hidayah/widgets/input_widget.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

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
              'Login Page',
              style: GoogleFonts.poppins(fontSize: size * 0.080),
            ),
            SizedBox(height: 30),
            InputWidget(
              hintText: 'Email',
              controller: _loginController.emailController,
              obscuredText: false,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Password',
              controller: _loginController.passwordController,
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
              onPressed: _loginController.login,
              child: Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: size * 0.040,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(() => RegisterPage());
              },
              child: Text(
                'Register',
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
