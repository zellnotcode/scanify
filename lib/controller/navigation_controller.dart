import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanify/model/data_user_model.dart';
import 'package:scanify/screen/home_screen.dart';
import 'package:scanify/screen/info_screen.dart';
import 'package:scanify/screen/input_data_screen.dart';
import 'package:scanify/screen/login_screen.dart';
import 'package:scanify/screen/splash_screen.dart';

class NavigationController extends GetxController {
  RxInt selectedIndex = RxInt(2);
  Rx<Widget> get screen => Rx<Widget>(listScreen[selectedIndex.value]());
  Rx<DataUserModel?> dataUser = Rx<DataUserModel?>(null);
  var isLoading = false.obs;

  final Dio dio = Dio();

  late List<Function()> listScreen;

  void initialize() {
    listScreen = [
      () => const HomeScreen(),
      () => const InfoScreen(),
      () => const SplashScreen(),
      () => const LoginScreen(),
      () => InputDataScreen(),
    ];
  }

  Future<bool> saveDataUser(String firebaseId, int kwhId, String name) async {
    final Map<String, dynamic> data = {
      "firebaseId": firebaseId,
      "kwhId": kwhId,
      "name": name,
    };

    try {
      final response = await dio.post(
        "http://203.194.114.198:8080/user/prefrence",
        data: data,
      );

      if (response.statusCode == 201) {
        final DataUserModel ready = DataUserModel.fromJson(response.data);

        dataUser.value = ready;

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveDataScan(String firebaseId, String name) async {
    isLoading.value = true;
    final Map<String, dynamic> data = {
      "firebaseId": firebaseId,
      "objectName": name,
    };

    try {
      final response = await dio.post(
        "http://203.194.114.198:8080/user/save",
        data: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> checkUserSaved(String firebaseId) async {
    try {
      final response = await dio.get(
        "http://203.194.114.198:8080/user/check/$firebaseId",
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        dataUser.value = DataUserModel.fromJson(response.data);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
