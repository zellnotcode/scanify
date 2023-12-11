import 'package:flutter/material.dart';
import 'package:scanify/constant.dart';

class CustomTop extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomTop({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(180),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: textBold.copyWith(fontSize: 16, color: Colors.white),
          ),
        )
      ],
    );
  }
}
