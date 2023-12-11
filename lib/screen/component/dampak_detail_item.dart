import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanify/constant.dart';

class DampakDetail extends StatelessWidget {
  final String dampak;
  final String isiDampak;
  const DampakDetail(
      {super.key, required this.dampak, required this.isiDampak});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            dampak,
            style: GoogleFonts.overpass(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            isiDampak,
            textAlign: TextAlign.justify,
            style: textNormal500.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
