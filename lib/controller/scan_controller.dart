import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/data_mapper.dart';
import 'package:scanify/local/entity/predict_entity.dart';
import 'package:scanify/local/infoitem_database.dart';
import 'package:scanify/model/predict_model.dart';
import 'package:scanify/model/saved_data_model.dart';

class ScanController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  var predictResult = Rx<ItemInfoDB?>(null);
  var historyItem = <ItemInfoDB>[].obs;
  var listData = <Datum>[].obs;

  final String url = "http://203.194.114.198:8080";
  final dioClint = dio.Dio();
  final InfoItemDatabase db = InfoItemDatabase.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  get image => null;

  @override
  void onInit() {
    getAllHistory();
    getListSaved();
    super.onInit();
  }

  Future pickImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemproray = File(image.path);
      selectedImage.value = imageTemproray;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> predictFile() async {
    isLoading.value = true;
    dio.FormData formData = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(selectedImage.value!.path,
          filename: "file.jpg"),
    });

    try {
      final response = await dioClint.post(
        "$url/scan/predict",
        data: formData,
      );

      if (response.statusCode == 200) {
        final body = response.data;
        final PredictModel predictResponse = PredictModel.fromJson(body);

        final ItemInfoDB dataReady =
            ItemInfoMapper.fromItemInfo(predictResponse.itemInfo);

        final dataReal = await db.insertItemInfoDB(dataReady);

        predictResult.value = dataReal;
        isLoading.value = false;
      } else if (response.statusCode == 422) {
        Fluttertoast.showToast(
            msg: "Tingkat Akurasi Rendah",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,
            textColor: darkColor);
      } else {
        print(response.statusCode);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> getAllHistory() async {
    historyItem.value = await db.getAllHistoryItem();
    print(historyItem);
  }

  Future<void> getListSaved() async {
    String firebaseId = auth.currentUser!.uid;
    try {
      final response = await dioClint.get(
        "http://203.194.114.198:8080/user/statistic/?id=$firebaseId",
      );

      if (response.statusCode == 200) {
        final SavedModel ready = SavedModel.fromJson(response.data);

        listData.value = ready.data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
