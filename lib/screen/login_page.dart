import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarana_hidayah/screen/register_page.dart';
import 'package:sarana_hidayah/service/auth_service.dart';
import 'package:sarana_hidayah/widgets/input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = Get.put(AuthService());

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    debugPrint(
        'Attempting to login with email: $email and password: $password');

    await _authService.login(email: email, password: password);
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
            'Login Page',
            style: GoogleFonts.poppins(fontSize: size * 0.080),
          ),
          SizedBox(
            height: 30,
          ),
          InputWidget(
            hintText: 'Email',
            controller: _emailController,
            obscuredText: false,
          ),
          SizedBox(
            height: 20,
          ),
          InputWidget(
            hintText: 'Password',
            controller: _passwordController,
            obscuredText: true,
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            onPressed: _login,
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                  fontSize: size * 0.040, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => RegisterPage());
              },
              child: Text(
                'Register',
                style: GoogleFonts.poppins(
                    fontSize: size * 0.040, color: Colors.black),
              ))
        ],
      ),
    ));
  }
}
