import 'package:flutter/material.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/screen/auth/login_page.dart';
import 'package:sarana_hidayah/screen/auth/map_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _address = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  bool visibilityPass = true;
  bool visibilityConfirmPass = true;

  final AuthController authController = AuthController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String response = await authController.register(
          _name, _phone, _address, _email, _password, _confirmPassword);

      if (response == 'Registration successful') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response),
          backgroundColor: Colors.green,
        ));
        await Future.delayed(Duration(seconds: 1)); // Delay 1 second
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void _selectAddress() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(onLocationSelected: (selectedAddress) {
          setState(() {
            _address = selectedAddress;
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Daftar sekarang!',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: const BorderSide(
                            color: Color(0xff134f5c),
                            width: 2.0,
                          ),
                        ),
                        labelText: "Nama",
                        hintText: "Masukkan nama anda",
                        labelStyle: const TextStyle(color: Color(0xff134f5c)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color(0xff134f5c),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _name = newValue!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: const BorderSide(
                            color: Color(0xff134f5c),
                            width: 2.0,
                          ),
                        ),
                        labelText: "Email",
                        hintText: "Masukkan email anda",
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
                      onSaved: (newValue) {
                        _email = newValue!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: visibilityPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: const BorderSide(
                            color: Color(0xff134f5c),
                            width: 2.0,
                          ),
                        ),
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
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 8) {
                          return 'Password harus memiliki minimal 8 karakter';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: visibilityConfirmPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: const BorderSide(
                            color: Color(0xff134f5c),
                            width: 2.0,
                          ),
                        ),
                        labelText: 'Konfirmasi Password',
                        hintText: "Masukkan konfirmasi password anda",
                        labelStyle: const TextStyle(color: Color(0xff134f5c)),
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xff134f5c)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibilityConfirmPass = !visibilityConfirmPass;
                            });
                          },
                          icon: visibilityConfirmPass
                              ? const Icon(Icons.visibility,
                                  color: Color(0xff134f5c))
                              : const Icon(Icons.visibility_off,
                                  color: Color(0xff134f5c)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi Password tidak boleh kosong';
                        }
                        if (value != _password) {
                          return 'Password dan Konfirmasi Password tidak sama';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _register,
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
                              "Daftar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah punya akun?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff134f5c)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
