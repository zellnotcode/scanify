import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:scanify/model/object_model.dart';

class FormController extends GetxController {
  final Dio dio = Dio();
  var listObject = <ObjectData>[].obs;
  var listSelectedObject = <ObjectData>[].obs;
  Rx<double> totalKwh = 0.0.obs;

  @override
  void onInit() {
    fetchObjectData();
    super.onInit();
  }

  void updateTotalKwh() {
    double roundedTotalKwh = double.parse(
      (listSelectedObject.fold(0.0,
              (previousValue, element) => previousValue + element.avgEnergy))
          .toStringAsFixed(3),
    );
    totalKwh.value = roundedTotalKwh;
  }

  Future<void> fetchObjectData() async {
    final response = await dio.get("http://203.194.114.198:8080/object");

    if (response.statusCode == 200) {
      final dataReady = ObjectModel.fromJson(response.data);

      listObject.value = dataReady.data;
    } else {
      print(response.statusCode);
    }
  }
}
