import 'package:flutter/material.dart';
import 'package:scanify/constant.dart';

class HistoryItem extends StatelessWidget {
  final String nama;
  final String tanggal;
  final String imageUrl;

  const HistoryItem(
      {super.key,
      required this.nama,
      required this.tanggal,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.maxFinite,
        height: 62,
        decoration: BoxDecoration(
            color: lightBlackColor, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: 62,
                height: 63,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/placeholder_image.png",
                    width: 62,
                    height: 63,
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nama,
                    style: textBold.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    tanggal,
                    style: textNormal400.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                weight: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
