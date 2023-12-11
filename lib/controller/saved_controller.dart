import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:scanify/model/saved_data_model.dart';

class SavedController extends GetxController {
  final Dio dio = Dio();
  var listData = <Datum>[].obs;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    final String fId = auth.currentUser!.uid;
    getListSaved(fId);
    super.onInit();
  }

  Future<void> getListSaved(
    String firebaseId,
  ) async {
    try {
      final response = await dio.get(
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
