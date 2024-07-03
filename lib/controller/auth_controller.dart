import 'package:get/get.dart';
import 'package:sarana_hidayah/model/user.dart';
import 'package:sarana_hidayah/screen/auth/login_page.dart';
import 'package:sarana_hidayah/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  var isAdmin = false.obs;
  var user = User(
    id: 0,
    name: '',
    phoneNumber: '',
    address: '',
    email: '',
    isAdmin: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser(); // Call fetchUser when controller initializes
  }

  Future<String> register(String name, String phone, String address,
      String email, String password, String confirmPassword) async {
    try {
      final response = await authService.register(
          name, phone, address, email, password, confirmPassword);
      if (response.containsKey('status') &&
          response['status'] == 'Registration successful') {
        return 'Registration successful';
      } else {
        return response['message'] ?? 'Registration error';
      }
    } catch (e) {
      print('Error registering: $e');
      return 'Registration error';
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await authService.login(email, password);
      if (response.containsKey('status') &&
          response['status'] == 'Login success!') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('token', response['access_token']);
        isAdmin.value = email == "superadmin@gmail.com";
        await fetchUser(); // Fetch user data after successful login
        return 'Login successful';
      } else {
        return response['message'] ?? 'Login error';
      }
    } catch (e) {
      print('Error logging in: $e');
      return 'Login error';
    }
  }

  Future<String> logout() async {
    try {
      final response = await authService.logout();
      if (response.containsKey('status') &&
          response['status'] == 'Logout success!') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        isAdmin.value = false;
        user.value = User(
          id: 0,
          name: '',
          phoneNumber: '',
          address: '',
          email: '',
          isAdmin: false,
        ); // Reset user data on logout
        return 'Logout successful';
      } else {
        return response['message'] ?? 'Logout error';
      }
    } catch (e) {
      print('Error logging out: $e');
      return 'Logout error';
    }
  }

  Future<void> fetchUser() async {
    try {
      print('Fetching user...');
      User fetchedUser = await authService.fetchUser();
      user.value = fetchedUser;
      print('User fetched successfully: ${user.value}');
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  Future<bool> updateUser(
      int id, String name, String phoneNumber, String address) async {
    try {
      print('Updating user: $id, $name, $phoneNumber, $address');
      await authService.updateUser(id, name, phoneNumber, address);
      // Update local user data
      user.update((val) {
        val!.name = name;
        val.phoneNumber = phoneNumber;
        val.address = address;
      });
      print('User updated successfully: ${user.value}');
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await authService.deleteUser(id);
      print('User deleted successfully in controller');
      Get.to(LoginPage());
    } catch (e) {
      print('Error deleting user in controller: $e');
    }
  }
}
