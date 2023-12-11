import 'package:flutter/material.dart';
import 'package:scanify/constant.dart';

class InfoItem extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const InfoItem({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0x0DFDFDFD),
            ),
          ),
        ),
        child: Text(
          name,
          style: textNormal400.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
