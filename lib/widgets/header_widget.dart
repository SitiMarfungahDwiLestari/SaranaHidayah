import 'package:flutter/material.dart';
import 'package:sarana_hidayah/screen/cart/cart_page.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isAdmin;

  const HeaderWidget({Key? key, required this.title, required this.isAdmin})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff134f5c),
      title: Text(title, style: TextStyle(color: Colors.white)),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Handle search action here
          },
        ),
        if (isAdmin == false)
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
      ],
    );
  }
}
