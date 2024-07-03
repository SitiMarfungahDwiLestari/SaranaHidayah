import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/screen/auth/login_page.dart';
import 'package:sarana_hidayah/widgets/input_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authController.fetchUser().then((_) {
      // Populate the text fields with the fetched user data
      if (_authController.user.value != null) {
        nameController.text = _authController.user.value.name;
        emailController.text = _authController.user.value.email;
        phoneController.text = _authController.user.value.phoneNumber ?? '';
        addressController.text = _authController.user.value.address ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Obx(() {
          if (_authController.user.value.name.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading user data...'),
              ],
            );
          }
          // Display user data
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputWidget(
                  hintText: 'Name',
                  controller: nameController,
                  obscuredText: false,
                ),
                const SizedBox(height: 10),
                InputWidget(
                  hintText: 'Email',
                  controller: emailController,
                  obscuredText: false,
                ),
                const SizedBox(height: 10),
                InputWidget(
                  hintText: 'Phone Number',
                  controller: phoneController,
                  obscuredText: false,
                ),
                const SizedBox(height: 10),
                InputWidget(
                  hintText: 'Address',
                  controller: addressController,
                  obscuredText: false,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    int id = _authController.user.value.id;
                    String name = nameController.text;
                    String phone = phoneController.text;
                    String address = addressController.text;

                    try {
                      await _authController.updateUser(
                          id, name, phone, address);
                      Get.snackbar(
                        'Success',
                        'Profile updated successfully',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Failed to update profile',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      print('Error: $e');
                    }
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await _authController
                            .deleteUser(_authController.user.value.id);
                        Get.snackbar(
                          'Success',
                          'User deleted successfully',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Get.to(LoginPage());
                      } catch (e) {
                        Get.snackbar(
                          'Error',
                          'Failed to delete user',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: const Text('Delete Account')),
              ],
            ),
          );
        }),
      ),
    );
  }
}
