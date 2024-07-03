import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/screen/auth/profile_page.dart';
import 'package:sarana_hidayah/screen/category/category_page.dart';
import 'package:sarana_hidayah/screen/home_page.dart';
import 'package:sarana_hidayah/screen/auth/login_page.dart';
import 'package:sarana_hidayah/screen/transaction/transaction_page.dart';

class DrawerWidget extends StatelessWidget {
  final bool isAdmin;
  final AuthController authController = AuthController();

  DrawerWidget({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: const Color(0xff134f5c),
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 70.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                const Text(
                  'Sarana Hidayah',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (isAdmin == true) ...[
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Catalog'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text('Category'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            isAdmin: isAdmin,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Transaction'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionPage(
                            isAdmin: isAdmin,
                          ),
                        ),
                      );
                    },
                  ),
                ] else ...[
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      Get.to(ProfilePage());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Catalog'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Transaction'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionPage(
                            isAdmin: isAdmin,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              String message = await authController.logout();
              if (message == 'Logout successful') {
                Get.offAll(() => LoginPage());
              } else {
                // Handle logout error
                Get.snackbar(
                  'Error',
                  message,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
