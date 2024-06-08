import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscuredText,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscuredText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          obscureText: obscuredText,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(),
              contentPadding: EdgeInsets.symmetric(horizontal: 20))),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
    );
  }
}
