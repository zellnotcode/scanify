// To parse this JSON data, do
//
//     final predictModel = predictModelFromJson(jsonString);

import 'dart:convert';

PredictModel predictModelFromJson(String str) =>
    PredictModel.fromJson(json.decode(str));

String predictModelToJson(PredictModel data) => json.encode(data.toJson());

class PredictModel {
  ItemInfo itemInfo;

  PredictModel({
    required this.itemInfo,
  });

  factory PredictModel.fromJson(Map<String, dynamic> json) => PredictModel(
        itemInfo: ItemInfo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "item_info": itemInfo.toJson(),
      };
}

class ItemInfo {
  double averageEnergy;
  String dampakDisposalPanjang;
  String dampakDisposalPendek;
  String dampakKonsumsiPanjang;
  String dampakKonsumsiPendek;
  String dampakProduksiPanjang;
  String dampakProduksiPendek;
  String image;
  String lokasi;
  String sumber;
  String name;
  String recommendations;
  String result;
  DateTime time;

  ItemInfo({
    required this.averageEnergy,
    required this.dampakDisposalPanjang,
    required this.dampakDisposalPendek,
    required this.dampakKonsumsiPanjang,
    required this.dampakKonsumsiPendek,
    required this.dampakProduksiPanjang,
    required this.dampakProduksiPendek,
    required this.image,
    required this.lokasi,
    required this.sumber,
    required this.name,
    required this.recommendations,
    required this.result,
    required this.time,
  });

  factory ItemInfo.fromJson(Map<String, dynamic> json) => ItemInfo(
        averageEnergy: json["Average Energy"]?.toDouble(),
        dampakDisposalPanjang: json["Dampak Disposal Panjang"],
        dampakDisposalPendek: json["Dampak Disposal Pendek"],
        dampakKonsumsiPanjang: json["Dampak Konsumsi Panjang"],
        dampakKonsumsiPendek: json["Dampak Konsumsi Pendek"],
        dampakProduksiPanjang: json["Dampak Produksi Panjang"],
        dampakProduksiPendek: json["Dampak Produksi Pendek"],
        image: json["Image"],
        lokasi: json["Lokasi"],
        sumber: json["Sumber"],
        name: json["name"],
        recommendations: json["recommendations"],
        result: json["result"],
        time: DateTime.parse(
          json["time"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "Average Energy": averageEnergy,
        "Dampak Disposal Panjang": dampakDisposalPanjang,
        "Dampak Disposal Pendek": dampakDisposalPendek,
        "Dampak Konsumsi Panjang": dampakKonsumsiPanjang,
        "Dampak Konsumsi Pendek": dampakKonsumsiPendek,
        "Dampak Produksi Panjang": dampakProduksiPanjang,
        "Dampak Produksi Pendek": dampakProduksiPendek,
        "Image": image,
        "Lokasi": lokasi,
        "Sumber": sumber,
        "name": name,
        "recommendations": recommendations,
        "result": result,
        "time": time.toIso8601String(),
      };
}
