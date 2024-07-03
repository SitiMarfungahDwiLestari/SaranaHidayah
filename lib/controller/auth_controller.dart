import 'package:get/get.dart';
import 'package:sarana_hidayah/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  var isAdmin = false.obs;

  Future<String> register(String name, String phone, String address,
      String email, String password, String confirmPassword) async {
    final response = await authService.register(
        name, phone, address, email, password, confirmPassword);
    if (response.containsKey('status') &&
        response['status'] == 'Registration successful') {
      return 'Registration successful';
    } else {
      return response['message'] ?? 'Terjadi kesalahan saat registrasi.';
    }
  }

  Future<String> login(String email, String password) async {
    final response = await authService.login(email, password);
    if (response.containsKey('status') &&
        response['status'] == 'Login success!') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('token', response['access_token']);
      isAdmin.value = email == "superadmin@gmail.com";
      return 'Login successful';
    } else {
      return response['message'] ?? 'Terjadi kesalahan saat login.';
    }
  }

  Future<String> logout() async {
    final response = await authService.logout();
    if (response.containsKey('status') &&
        response['status'] == 'Logout success!') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      isAdmin.value = false;
      return 'Logout successful';
    } else {
      return response['message'] ?? 'Terjadi kesalahan saat logout.';
    }
  }
}
