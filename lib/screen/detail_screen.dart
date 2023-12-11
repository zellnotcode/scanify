import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/local/entity/predict_entity.dart';
import 'package:scanify/local/infoitem_database.dart';
import 'package:scanify/screen/add_item_screen.dart';
import 'package:scanify/screen/component/custom_top_screen.dart';
import 'package:scanify/screen/component/dampak_detail_item.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  ItemInfoDB data;
  DetailScreen({super.key, required this.data});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final InfoItemDatabase db = InfoItemDatabase.instance;
  bool isSaved = false;

  Future<void> getIsSaved() async {
    isSaved = await db.getIsSavedById(widget.data.id!);
  }

  @override
  void initState() {
    super.initState();
    getIsSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 22,
                ),
                child: CustomTop(
                  onTap: () {
                    isSaved == true || widget.data.isSaved == true
                        ? Get.back()
                        : Get.off(
                            AddItemScreen(
                              data: widget.data,
                            ),
                          );
                  },
                  text: "Hasil Scan",
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                child: Image.network(
                  widget.data.image,
                  fit: BoxFit.cover,
                  width: 450,
                  height: 380,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    Text(
                      widget.data.name,
                      style: textBold.copyWith(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          widget.data.averageEnergy.toString(),
                          style: textBold.copyWith(
                            color: yellowColor,
                            fontSize: 23,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.bolt,
                              size: 20,
                              color: yellowColor,
                            ),
                            Text(
                              "kWh",
                              style: textNormal500.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DampakDetail(
                      dampak: "Dampak Konsumsi",
                      isiDampak: widget.data.dampakKonsumsiPanjang,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DampakDetail(
                      dampak: "Dampak Produksi",
                      isiDampak: widget.data.dampakProduksiPanjang,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DampakDetail(
                      dampak: "Dampak Disposal",
                      isiDampak: widget.data.dampakDisposalPanjang,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: lightBlackColor,
                      ),
                      child: Text(
                        "Alternative",
                        style: textNormal600.copyWith(
                          fontSize: 16,
                          color: yellowColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lightBlackColor,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/images/placeholder_image.png",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.recommendations,
                                style: textBold.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                widget.data.name,
                                style: textNormal500.copyWith(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
