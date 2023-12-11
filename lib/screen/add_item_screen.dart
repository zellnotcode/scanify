import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/navigation_controller.dart';
import 'package:scanify/controller/scan_controller.dart';
import 'package:scanify/local/entity/predict_entity.dart';
import 'package:scanify/local/infoitem_database.dart';

// ignore: must_be_immutable
class AddItemScreen extends StatelessWidget {
  ItemInfoDB data;
  AddItemScreen({super.key, required this.data});

  final NavigationController navController = Get.put(NavigationController());
  final ScanController scanController = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
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
                      "Hasil Scan",
                      style: textBold.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  child: Image.network(
                    data.image,
                    fit: BoxFit.cover,
                    width: 320,
                    height: 320,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                data.name,
                style: textBold.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Apakah ingin ditambahkan ke dalam daftar barang di rumah anda ?",
                style: textNormal400.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Obx(() {
                return navController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              navController.selectedIndex.value = 0;
                              Get.back();
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(180),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final FirebaseAuth auth = FirebaseAuth.instance;
                              final String fId = auth.currentUser!.uid;
                              final InfoItemDatabase db =
                                  InfoItemDatabase.instance;
                              print(fId);
                              bool upload = await navController.saveDataScan(
                                  fId, data.name);
                              await db.updateIsSaved(data.id!);

                              if (upload) {
                                Fluttertoast.showToast(
                                  msg: "Berhasil menyimpan data",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.white,
                                  textColor: darkColor,
                                );
                                await scanController.getListSaved();
                                Get.back();
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Gagal menyimpan data",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.white,
                                  textColor: darkColor,
                                );
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(180),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
