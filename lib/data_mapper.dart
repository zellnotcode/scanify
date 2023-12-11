import 'package:scanify/local/entity/predict_entity.dart';
import 'package:scanify/model/predict_model.dart';

class ItemInfoMapper {
  static ItemInfoDB fromItemInfo(ItemInfo itemInfo) {
    return ItemInfoDB(
      averageEnergy: itemInfo.averageEnergy,
      dampakDisposalPanjang: itemInfo.dampakDisposalPanjang,
      dampakDisposalPendek: itemInfo.dampakDisposalPendek,
      dampakKonsumsiPanjang: itemInfo.dampakKonsumsiPanjang,
      dampakKonsumsiPendek: itemInfo.dampakKonsumsiPendek,
      dampakProduksiPanjang: itemInfo.dampakProduksiPanjang,
      dampakProduksiPendek: itemInfo.dampakProduksiPendek,
      image: itemInfo.image,
      lokasi: itemInfo.lokasi,
      sumber: itemInfo.sumber,
      name: itemInfo.name,
      recommendations: itemInfo.recommendations,
      result: itemInfo.result,
      time: itemInfo.time,
      isSaved: false,
    );
  }

  static List<ItemInfoDB> listFromItemInfoList(List<ItemInfo> itemInfoList) {
    return itemInfoList.map((itemInfo) => fromItemInfo(itemInfo)).toList();
  }
}
