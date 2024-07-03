import 'package:flutter/material.dart';
import 'package:sarana_hidayah/controller/login_controller.dart';
import 'package:sarana_hidayah/screen/home_page.dart';
import 'package:sarana_hidayah/screen/register_page.dart';

class LoginPage extends StatefulWidget {
  final bool isAdmin;

  const LoginPage({super.key, required this.isAdmin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController();
  bool visibilityPass = true;

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      final message = await _loginController.login(
        _emailController.text,
        _passwordController.text,
      );
      if (message == 'Login successful') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(isAdmin: widget.isAdmin),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 250,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(90)),
                color: Color(0xff134f5c),
                gradient: LinearGradient(colors: [
                  Color(0xcc134f5c),
                  Color(0xff134f5c),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: ListView(
                padding: const EdgeInsets.only(left: 20),
                children: const [
                  SizedBox(height: 60),
                  Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )),
          Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                                color: Color(0xff134f5c), width: 2.0)),
                        labelText: "Email",
                        hintText: "Masukkan eMail anda",
                        labelStyle: const TextStyle(color: Color(0xff134f5c)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xff134f5c),
                        ),
                      ),
                      validator: (value) {
                        bool valid = RegExp(r"@").hasMatch(value!);
                        if (value.isEmpty) {
                          return "Email tidak boleh kosong";
                        } else if (!valid) {
                          return "Harus ada @";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: visibilityPass,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                                color: Color(0xff134f5c), width: 2.0)),
                        labelText: 'Password',
                        hintText: "Masukkan password anda",
                        labelStyle: const TextStyle(color: Color(0xff134f5c)),
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xff134f5c)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibilityPass = !visibilityPass;
                            });
                          },
                          icon: visibilityPass
                              ? const Icon(Icons.visibility,
                                  color: Color(0xff134f5c))
                              : const Icon(Icons.visibility_off,
                                  color: Color(0xff134f5c)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password tidak boleh kosong!!";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: loginUser,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff134f5c),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 50,
                                        color: Color(0xffEEEEEE))
                                  ]),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegisterPage(isAdmin: widget.isAdmin)),
                              );
                            },
                            child: const Text(
                              'Daftar Sekarang',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff134f5c)),
                            ))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
