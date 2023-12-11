import 'package:flutter/material.dart';
import 'package:scanify/constant.dart';

class CustomRedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomRedButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: redColor,
        ),
        child: Center(
          child: Text(
            text,
            style: textNormal700.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
