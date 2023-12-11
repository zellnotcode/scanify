import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/saved_controller.dart';
import 'package:scanify/local/entity/predict_entity.dart';
import 'package:scanify/screen/component/custom_top_screen.dart';
import 'package:scanify/screen/component/history_item.dart';
import 'package:scanify/screen/detail_screen.dart';

class SavedScreen extends StatelessWidget {
  SavedScreen({super.key});

  final SavedController savedController = Get.put(SavedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            top: 25,
          ),
          child: Column(
            children: [
              CustomTop(
                  onTap: () {
                    Get.back();
                  },
                  text: "Barang Dirumah"),
              const SizedBox(
                height: 18,
              ),
              Obx(() {
                return savedController.listData.isEmpty
                    ? Center(
                        heightFactor: 5,
                        child: Image.asset(
                          "assets/images/no_data.png",
                          width: 113,
                          height: 59,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: savedController.listData.length,
                          itemBuilder: (context, index) {
                            final item = savedController.listData;
                            String formattedDate =
                                DateFormat.yMMMMd('id_ID').format(
                              item[index].createdAt,
                            );

                            return GestureDetector(
                              onTap: () {
                                final ItemInfoDB itemInfo =
                                    ItemInfoDB.fromDatum(item[index]);
                                Get.to(
                                  () => DetailScreen(data: itemInfo),
                                );
                              },
                              child: HistoryItem(
                                nama: item[index].main.objectName,
                                tanggal: formattedDate,
                                imageUrl: item[index].main.representativeImage,
                              ),
                            );
                          },
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
