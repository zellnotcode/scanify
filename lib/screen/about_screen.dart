import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/screen/component/custom_top_screen.dart';
import 'package:scanify/screen/component/dampak_detail_item.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 12,
            ),
            child: Column(
              children: [
                CustomTop(
                  onTap: () {
                    Get.back();
                  },
                  text: "Tentang",
                ),
                const SizedBox(
                  height: 12,
                ),
                const DampakDetail(
                  dampak: "About Us",
                  isiDampak:
                      "OB adalah nama sekelompok mahasiswa Institut Teknologi Kalimantan yang peduli dan ingin berkontribusi dalam melindungi lingkungan. OB sendiri adalah OuroBoros yang berarti menunjukkan ambisi dan hasrat kami dalam memberi dampak.",
                ),
                const SizedBox(
                  height: 8,
                ),
                const DampakDetail(
                  dampak: "Our Mission",
                  isiDampak:
                      "Scanify dibuat untuk membantu masyarakat, untuk dengan mudah dapat memahami dampak lingkungan dari berbagai peralatan elektronik rumah tangga anda. Tidak hanya berapa energi yang dikonsumsi, namun juga dampak produksi, konsumsi, dan disposal dari peralatan tersebut.",
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tentunya, penting bagi setiap dari kita, untuk berkontribusi terhadap perlingkungan lingkungan, salah satunya dalam membuat keputusan yang membawa dampak terbaik terhadap lingkungan kita.",
                    textAlign: TextAlign.justify,
                    style: textNormal500.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DampakDetail(
                  dampak: "Our Method",
                  isiDampak:
                      "Scanify bekerja dengan membantu anda dalam melakukan pemindaian terhadap peralatan elektronik anda, dan dengan secara instan, memberi anda informasi mendetail tentang kategori produk tersebut, dan dampaknya kepada lingkungan.",
                ),
                const SizedBox(
                  height: 8,
                ),
                DampakDetail(
                  dampak: "Application Advantages",
                  isiDampak:
                      """1. Hasil instan! Tidak perlu menunggu lama dan mencari artikel di internet.
2. Online! Data sebuah peralatan elektronik tidak disimpan dalam perangkat anda, sehingga menghemat penyimpanan!
3. Data berasal dari Riset yang riil! Bukan dari artikel atau blog yang sumbernya tidak bisa dipercaya, kami mengumpulkan data dari Dataset Peneliti dan hasil penelitian.""",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
