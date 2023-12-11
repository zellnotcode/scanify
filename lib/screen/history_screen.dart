import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/history_controller.dart';
import 'package:scanify/screen/component/custom_top_screen.dart';
import 'package:scanify/screen/component/history_item.dart';
import 'package:scanify/screen/detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  void initState() {
    super.initState();
    historyController.getAllHistory();
  }

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
                  text: "Riwayat Scan"),
              const SizedBox(
                height: 18,
              ),
              Obx(() {
                return historyController.listItem.isEmpty
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
                          itemCount: historyController.listItem.length,
                          itemBuilder: (context, index) {
                            final item = historyController.listItem;
                            String formattedDate =
                                DateFormat.yMMMMd('id_ID').format(
                              item[index].time,
                            );

                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => DetailScreen(data: item[index]),
                                );
                              },
                              child: HistoryItem(
                                  nama: item[index].name,
                                  tanggal: formattedDate,
                                  imageUrl: item[index].image),
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
