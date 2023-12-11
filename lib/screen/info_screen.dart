import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/screen/about_screen.dart';
import 'package:scanify/screen/component/info_item.dart';
import 'package:scanify/screen/history_screen.dart';
import 'package:scanify/screen/saved_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Data Rumah',
        'onTap': () => Get.to(() => SavedScreen()),
      },
      {
        'title': 'Riwayat Item',
        'onTap': () => Get.to(() => const HistoryScreen())
      },
      {
        'title': 'Tentang Aplikasi',
        'onTap': () => Get.to(() => const AboutScreen())
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 32),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Scan",
                style: textBold.copyWith(fontSize: 32, color: Colors.white),
              ),
              Text(
                "ify",
                style: textBold.copyWith(fontSize: 32, color: redColor),
              ),
            ],
          ),
          const SizedBox(
            height: 34,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return InfoItem(
                name: menuItems[index]['title'],
                onTap: menuItems[index]["onTap"],
              );
            },
          ),
          Text(
            "Versi Aplikasi 1.0",
            style: textNormal400.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
