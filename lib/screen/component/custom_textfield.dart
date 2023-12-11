import 'package:flutter/material.dart';
import 'package:scanify/constant.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool obscureText;

  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.label,
      required this.type,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textNormal700.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: lightBlackColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              keyboardType: type,
              obscureText: obscureText,
              style: textNormal400.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
              controller: controller,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
