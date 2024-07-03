import 'package:get/get.dart';
import 'package:sarana_hidayah/service/user_service.dart';
import 'package:sarana_hidayah/model/user.dart';

class UserController extends GetxController {
  final UserService userService = UserService();

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
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      User userData = await userService.fetchUser();
      user.value = userData;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch user');
    }
  }

  Future<void> updateUser(
      String name, String phoneNumber, String address) async {
    try {
      await userService.updateUser(user.value.id, name, phoneNumber, address);
      await fetchUser();
    } catch (e) {
      print(e);
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser() async {
    try {
      await userService.deleteUser(user.value.id);
      // Handle additional logic after user deletion, like logging out the user
    } catch (e) {
      print(e);
      throw Exception('Failed to delete user');
    }
  }
}
