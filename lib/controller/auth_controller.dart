import 'package:get/get.dart';
import 'package:sarana_hidayah/model/user.dart';
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
    fetchUser(); // Panggil fetchUser saat controller diinisialisasi
  }

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
    try {
      final response = await authService.login(email, password);
      if (response.containsKey('status') &&
          response['status'] == 'Login success!') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('token', response['access_token']);
        isAdmin.value = email == "superadmin@gmail.com";
        await fetchUser(); // Ambil data pengguna setelah login berhasil
        return 'Login successful';
      } else {
        return response['message'] ?? 'Terjadi kesalahan saat login.';
      }
    } catch (e) {
      print('Error logging in: $e');
      return 'Terjadi kesalahan saat login.';
    }
  }

  Future<String> logout() async {
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
      ); // Reset user data saat logout
      return 'Logout successful';
    } else {
      return response['message'] ?? 'Terjadi kesalahan saat logout.';
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

  Future<void> updateUser(
      int id, String name, String phoneNumber, String address) async {
    try {
      await authService.updateUser(id, name, phoneNumber, address);
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await authService.deleteUser(id);
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
