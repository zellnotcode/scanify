import 'package:get/get.dart';
import 'package:scanify/local/entity/predict_entity.dart';
import 'package:scanify/local/infoitem_database.dart';

class HistoryController extends GetxController {
  var listItem = <ItemInfoDB>[].obs;

  final InfoItemDatabase db = InfoItemDatabase.instance;

  @override
  void onInit() {
    getAllHistory();
    super.onInit();
  }

  Future<void> getAllHistory() async {
    listItem.value = await db.getAllHistoryItem();
  }
}
