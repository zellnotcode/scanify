import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/scan_controller.dart';
import 'package:scanify/screen/detail_screen.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScanController scanController = Get.put(ScanController());

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF323232),
        body: Center(child: Obx(() {
          if (scanController.isLoading.value == true) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          } else if (scanController.selectedImage.value == null) {
            Get.back();
            return const SizedBox();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    scanController.selectedImage.value!,
                    width: 281,
                    height: 370,
                  ),
                ),
                const SizedBox(
                  height: 73,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (scanController.selectedImage.value != null) {
                          scanController.selectedImage.value = null;
                        }
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
                        await scanController.predictFile();

                        if (scanController.predictResult.value != null) {
                          scanController.getAllHistory();
                          Get.off(DetailScreen(
                            data: scanController.predictResult.value!,
                          ));
                        } else {
                          Fluttertoast.showToast(
                            msg: "Model tidak yakin atau Object tidak terbaca",
                            toastLength: Toast.LENGTH_SHORT,
                            textColor: darkColor,
                            backgroundColor: Colors.white,
                          );
                          Get.back();
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
                ),
              ],
            );
          }
        })),
      ),
    );
  }
}
