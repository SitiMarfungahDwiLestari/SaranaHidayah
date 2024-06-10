import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarana_hidayah/controller/register_controller.dart';
import 'package:sarana_hidayah/screen/login_page.dart';
import 'package:sarana_hidayah/widgets/input_widget.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());

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
              controller: _registerController.nameController,
              obscuredText: false,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Email',
              controller: _registerController.emailController,
              obscuredText: false,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Password',
              controller: _registerController.passwordController,
              obscuredText: true,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Confirm Password',
              controller: _registerController.confirmPasswordController,
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
              onPressed: _registerController.register,
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
