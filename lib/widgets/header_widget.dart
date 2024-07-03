import 'package:flutter/material.dart';

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
        if (isAdmin == false)
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle shopping cart action here
            },
          ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Handle search action here
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {},
        ),
      ],
    );
  }
}
