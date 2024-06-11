import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Sarana Hidayah'),
      actions: [
        IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () {},
        ),
      ],
    );
  }
}
