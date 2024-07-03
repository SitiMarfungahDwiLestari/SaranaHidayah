import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarana_hidayah/controller/cart_controller.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/screen/auth/profile_page.dart';
import 'package:sarana_hidayah/screen/transaction/transaction_page.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final AuthController authController = Get.find<AuthController>();
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                print('Container clicked');
                Get.to(ProfilePage());
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Alamat Pengiriman',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            // Tampilkan nama dan alamat dari AuthController
                            String nama = authController.user.value.name;
                            String alamat =
                                authController.user.value.address ?? '';

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama : $nama',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Alamat : $alamat',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (cartController.cartItems.isEmpty) {
                return Center(
                  child: Text('No items in cart'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartController.cartItems[index];
                  int count = item['count'] is String
                      ? int.parse(item['count'])
                      : item['count'];
                  int price = item['book']['price'] is String
                      ? double.parse(item['book']['price']).toInt()
                      : item['book']['price'];
                  int totalItemPrice = count * price;

                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item['book']['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.broken_image,
                                  size: 100,
                                  color: Colors.grey,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['book']['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Quantity: $count',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Price: ${formatCurrency.format(price)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Total: ${formatCurrency.format(totalItemPrice)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        if (count > 1) {
                                          cartController.updateCartItem(
                                              item['id'], count - 1);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        cartController.updateCartItem(
                                            item['id'], count + 1);
                                      },
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        cartController
                                            .deleteCartItem(item['id']);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                double totalPrice =
                    cartController.cartItems.fold(0.0, (sum, item) {
                  int count = item['count'] is String
                      ? int.parse(item['count'])
                      : item['count'];
                  int price = item['book']['price'] is String
                      ? double.parse(item['book']['price']).toInt()
                      : item['book']['price'];
                  return sum + (count * price).toDouble();
                });

                return Text(
                  'Total Price: ${formatCurrency.format(totalPrice)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(TransactionPage());
        },
        label: Text('Lanjutkan Pembayaran'),
        icon: Icon(Icons.payment),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
