import 'package:get/get.dart';
import 'package:sarana_hidayah/service/cart_service.dart';

class CartController extends GetxController {
  var cartItems = [].obs;

  @override
  void onInit() {
    fetchCartItems();
    super.onInit();
  }

  void clearCart() {
    cartItems.clear();
  }

  Future<void> fetchCartItems() async {
    try {
      var items = await CartService().fetchCartItems();
      cartItems.assignAll(items);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch cart items');
    }
  }

  Future<void> addToCart(int bookId, int count) async {
    try {
      await CartService().addToCart(bookId, count);
      fetchCartItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart');
    }
  }

  Future<void> deleteCartItem(int cartId) async {
    try {
      await CartService().deleteCartItem(cartId);
      fetchCartItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete item from cart');
    }
  }

  Future<void> updateCartItem(int cartId, int count) async {
    try {
      await CartService().updateCartItem(cartId, count);
      fetchCartItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update item quantity');
    }
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      int count =
          item['count'] is String ? int.parse(item['count']) : item['count'];
      int price = item['book']['price'] is String
          ? double.parse(item['book']['price']).toInt()
          : item['book']['price'];
      return sum + (count * price).toDouble();
    });
  }
}
