import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
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
        title: Text('Profile'),
      ),
      body: Center(
        child: Obx(() {
          if (_authController.user.value.name.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(), // Placeholder while loading user data
                SizedBox(height: 20),
                Text('Loading user data...'),
              ],
            );
          }
          // Display user data
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputWidget(
                  hintText: 'Name',
                  controller: nameController,
                  obscuredText: false,
                ),
                SizedBox(height: 10),
                InputWidget(
                  hintText: 'Email',
                  controller: emailController,
                  obscuredText: false,
                ),
                SizedBox(height: 10),
                InputWidget(
                  hintText: 'Phone Number',
                  controller: phoneController,
                  obscuredText: false,
                ),
                SizedBox(height: 10),
                InputWidget(
                  hintText: 'Address',
                  controller: addressController,
                  obscuredText: false,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Save the updated user data
                    int id = _authController.user.value.id;
                    String name = nameController.text;
                    String phone = phoneController.text;
                    String address = addressController.text;

                    await _authController.updateUser(id, name, phone, address);

                    Get.snackbar(
                      'Success',
                      'Profile updated successfully',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Text('Save'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Logout implementation
                    String message = await _authController.logout();
                    if (message == 'Logout successful') {
                      Get.offAllNamed('/login'); // Navigate to login page
                    } else {
                      Get.snackbar(
                        'Error',
                        message,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
