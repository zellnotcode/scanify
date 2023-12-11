import 'package:scanify/model/saved_data_model.dart';

class ItemInfoDB {
  int? id;
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
  bool isSaved;

  ItemInfoDB({
    this.id,
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
    this.isSaved = false,
  });

  factory ItemInfoDB.fromJson(Map<String, dynamic> json) => ItemInfoDB(
        id: json["id"],
        averageEnergy: json["averageEnergy"]?.toDouble(),
        dampakDisposalPanjang: json["dampakDisposalPanjang"],
        dampakDisposalPendek: json["dampakDisposalPendek"],
        dampakKonsumsiPanjang: json["dampakKonsumsiPanjang"],
        dampakKonsumsiPendek: json["dampakKonsumsiPendek"],
        dampakProduksiPanjang: json["dampakProduksiPanjang"],
        dampakProduksiPendek: json["dampakProduksiPendek"],
        image: json["image"],
        lokasi: json["lokasi"],
        sumber: json["sumber"],
        name: json["name"],
        recommendations: json["recommendations"],
        result: json["result"],
        time: DateTime.parse(json["time"]),
        isSaved: false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "averageEnergy": averageEnergy,
        "dampakDisposalPanjang": dampakDisposalPanjang,
        "dampakDisposalPendek": dampakDisposalPendek,
        "dampakKonsumsiPanjang": dampakKonsumsiPanjang,
        "dampakKonsumsiPendek": dampakKonsumsiPendek,
        "dampakProduksiPanjang": dampakProduksiPanjang,
        "dampakProduksiPendek": dampakProduksiPendek,
        "image": image,
        "lokasi": lokasi,
        "sumber": sumber,
        "name": name,
        "recommendations": recommendations,
        "result": result,
        "time": time.toIso8601String(),
        "isSaved": isSaved ? 1 : 0, // Convert bool to integer for SQLite
      };

  factory ItemInfoDB.fromMap(Map<String, dynamic> map) => ItemInfoDB(
        id: map["id"],
        averageEnergy: map["averageEnergy"],
        dampakDisposalPanjang: map["dampakDisposalPanjang"],
        dampakDisposalPendek: map["dampakDisposalPendek"],
        dampakKonsumsiPanjang: map["dampakKonsumsiPanjang"],
        dampakKonsumsiPendek: map["dampakKonsumsiPendek"],
        dampakProduksiPanjang: map["dampakProduksiPanjang"],
        dampakProduksiPendek: map["dampakProduksiPendek"],
        image: map["image"],
        lokasi: map["lokasi"],
        sumber: map["sumber"],
        name: map["name"],
        recommendations: map["recommendations"],
        result: map["result"],
        time: DateTime.parse(map["time"]),
        isSaved: map["isSaved"] == 1, // Convert integer to bool for Dart
      );

  ItemInfoDB copy({
    int? id,
    double? averageEnergy,
    String? dampakDisposalPanjang,
    String? dampakDisposalPendek,
    String? dampakKonsumsiPanjang,
    String? dampakKonsumsiPendek,
    String? dampakProduksiPanjang,
    String? dampakProduksiPendek,
    String? image,
    String? lokasi,
    String? sumber,
    String? name,
    String? recommendations,
    String? result,
    DateTime? time,
    bool? isSaved,
  }) =>
      ItemInfoDB(
        averageEnergy: averageEnergy ?? this.averageEnergy,
        dampakDisposalPanjang:
            dampakDisposalPanjang ?? this.dampakDisposalPanjang,
        dampakDisposalPendek: dampakDisposalPendek ?? this.dampakDisposalPendek,
        dampakKonsumsiPanjang:
            dampakKonsumsiPanjang ?? this.dampakKonsumsiPanjang,
        dampakKonsumsiPendek: dampakKonsumsiPendek ?? this.dampakKonsumsiPendek,
        dampakProduksiPanjang:
            dampakProduksiPanjang ?? this.dampakProduksiPanjang,
        dampakProduksiPendek: dampakProduksiPendek ?? this.dampakProduksiPendek,
        image: image ?? this.image,
        lokasi: lokasi ?? this.lokasi,
        sumber: sumber ?? this.sumber,
        name: name ?? this.name,
        recommendations: recommendations ?? this.recommendations,
        result: result ?? this.result,
        time: time ?? this.time,
        isSaved: isSaved ?? this.isSaved,
      );

  factory ItemInfoDB.fromDatum(Datum datum) {
    return ItemInfoDB(
      averageEnergy: datum.main.avgEnergy,
      dampakDisposalPanjang: datum.main.dampakDisposal,
      dampakDisposalPendek: datum.main.shortDd,
      dampakKonsumsiPanjang: datum.main.dampakKonsumsi,
      dampakKonsumsiPendek: datum.main.shortDk,
      dampakProduksiPanjang: datum.main.dampakProduksi,
      dampakProduksiPendek: datum.main.shortDp,
      image: datum.main.representativeImage,
      lokasi: datum.main.lokasi,
      sumber: datum.main.sumber,
      name: datum.objectName,
      recommendations: 'Tidak ada rekomendasi',
      result: '',
      time: datum.createdAt,
      isSaved: true,
    );
  }
}

class ItemInfoDBFields {
  static final List<String> values = [
    "id",
    "averageEnergy",
    "dampakDisposalPanjang",
    "dampakDisposalPendek",
    "dampakKonsumsiPanjang",
    "dampakKonsumsiPendek",
    "dampakProduksiPanjang",
    "dampakProduksiPendek",
    "image",
    "lokasi",
    "sumber",
    "name",
    "recommendations",
    "result",
    "time",
    "isSaved"
  ];

  static const id = 'id';
  static const averageEnergy = 'averageEnergy';
  static const dampakDisposalPanjang = 'dampakDisposalPanjang';
  static const dampakDisposalPendek = 'dampakDisposalPendek';
  static const dampakKonsumsiPanjang = 'dampakKonsumsiPanjang';
  static const dampakKonsumsiPendek = 'dampakKonsumsiPendek';
  static const dampakProduksiPanjang = 'dampakProduksiPanjang';
  static const dampakProduksiPendek = 'dampakProduksiPendek';
  static const image = 'image';
  static const lokasi = 'lokasi';
  static const sumber = 'sumber';
  static const name = 'name';
  static const recommendations = 'recommendations';
  static const result = 'result';
  static const time = 'time';
  static const isSaved = 'isSaved';
}

const String tableInfoItem = 'infoitem';
