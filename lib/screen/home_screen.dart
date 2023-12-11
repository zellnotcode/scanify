import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/navigation_controller.dart';
import 'package:scanify/controller/scan_controller.dart';
import 'package:scanify/local/entity/predict_entity.dart';
import 'package:scanify/screen/component/history_item.dart';
import 'package:scanify/screen/detail_screen.dart';
import 'package:scanify/screen/form_screen.dart';
import 'package:scanify/screen/history_screen.dart';
import 'package:scanify/screen/preview_screen.dart';
import 'package:scanify/screen/saved_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScanController scanController = Get.put(ScanController());
    NavigationController navigatorController = Get.put(NavigationController());

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 35,
          left: 28,
          right: 28,
          bottom: 60,
        ),
        child: Obx(
          () => Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/art_home.png",
                  width: 235,
                  height: 164,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Hi,",
                    style: textBold.copyWith(
                      fontSize: 36,
                      color: redColor,
                    ),
                  ),
                  Text(
                    " ${navigatorController.dataUser.value!.data.name.split(" ").first}",
                    style: textBold.copyWith(fontSize: 36, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await scanController.pickImage(ImageSource.camera);
                      Get.to(const PreviewScreen());
                    },
                    child: Image.asset(
                      "assets/images/scan_button.png",
                      width: 214,
                      height: 156,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await scanController.pickImage(ImageSource.gallery);

                          Get.to(const PreviewScreen());
                        },
                        child: Image.asset(
                          "assets/images/galerry_button.png",
                          width: 82,
                          height: 74,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(FormScreen());
                        },
                        child: Image.asset(
                          "assets/images/kalku_button.png",
                          width: 82,
                          height: 74,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 23,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Barang Dirumah",
                      style: textBold.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => SavedScreen(),
                        );
                      },
                      child: Text(
                        "Lihat lebih",
                        style: textNormal500.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 7,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              scanController.listData.isEmpty
                  ? Center(
                      child: Image.asset(
                        "assets/images/no_data.png",
                        width: 120,
                        height: 120,
                      ),
                    )
                  : Column(
                      children: [
                        if (scanController.listData.isNotEmpty)
                          ...scanController.listData
                              .take(2)
                              .map(
                                (item) => GestureDetector(
                                  onTap: () {
                                    final ItemInfoDB itemInfo =
                                        ItemInfoDB.fromDatum(item);
                                    Get.to(
                                      () => DetailScreen(data: itemInfo),
                                    );
                                  },
                                  child: HistoryItem(
                                    nama: item.objectName,
                                    tanggal: DateFormat.yMMMMd('id_ID')
                                        .format(item.createdAt),
                                    imageUrl: item.main.representativeImage,
                                  ),
                                ),
                              )
                              .toList(),
                      ],
                    ),
              const SizedBox(
                height: 23,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Terakhir Dilihat",
                      style: textBold.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(const HistoryScreen());
                      },
                      child: Text(
                        "Lihat lebih",
                        style: textNormal500.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 7,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              scanController.historyItem.isEmpty
                  ? Center(
                      child: Image.asset(
                        "assets/images/no_data.png",
                        width: 120,
                        height: 120,
                      ),
                    )
                  : Column(
                      children: [
                        if (scanController.historyItem.isNotEmpty)
                          ...scanController.historyItem
                              .take(3)
                              .map(
                                (item) => GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => DetailScreen(data: item),
                                    );
                                  },
                                  child: HistoryItem(
                                    nama: item.name,
                                    tanggal: DateFormat.yMMMMd('id_ID')
                                        .format(item.time),
                                    imageUrl: item.image,
                                  ),
                                ),
                              )
                              .toList(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
