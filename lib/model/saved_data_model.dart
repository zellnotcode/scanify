// To parse this JSON data, do
//
//     final savedModel = savedModelFromJson(jsonString);

import 'dart:convert';

SavedModel savedModelFromJson(String str) =>
    SavedModel.fromJson(json.decode(str));

String savedModelToJson(SavedModel data) => json.encode(data.toJson());

class SavedModel {
  String status;
  List<Datum> data;
  double avgDaily;

  SavedModel({
    required this.status,
    required this.data,
    required this.avgDaily,
  });

  factory SavedModel.fromJson(Map<String, dynamic> json) => SavedModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        avgDaily: json["AvgDaily"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "AvgDaily": avgDaily,
      };
}

class Datum {
  int id;
  String objectName;
  DateTime createdAt;
  String firebaseId;
  Users users;
  Main main;

  Datum({
    required this.id,
    required this.objectName,
    required this.createdAt,
    required this.firebaseId,
    required this.users,
    required this.main,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        objectName: json["objectName"],
        createdAt: DateTime.parse(json["createdAt"]),
        firebaseId: json["firebaseId"],
        users: Users.fromJson(json["users"]),
        main: Main.fromJson(json["main"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "objectName": objectName,
        "createdAt": createdAt.toIso8601String(),
        "firebaseId": firebaseId,
        "users": users.toJson(),
        "main": main.toJson(),
      };
}

class Main {
  String objectName;
  String representativeImage;
  String? recommendedId;
  String dampakProduksi;
  String dampakKonsumsi;
  String dampakDisposal;
  double avgEnergy;
  String shortDp;
  String shortDk;
  String shortDd;
  String lokasi;
  String sumber;

  Main({
    required this.objectName,
    required this.representativeImage,
    required this.recommendedId,
    required this.dampakProduksi,
    required this.dampakKonsumsi,
    required this.dampakDisposal,
    required this.avgEnergy,
    required this.shortDp,
    required this.shortDk,
    required this.shortDd,
    required this.lokasi,
    required this.sumber,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        objectName: json["Object_Name"],
        representativeImage: json["Representative_Image"],
        recommendedId: json["Recommended_ID"],
        dampakProduksi: json["Dampak_Produksi"],
        dampakKonsumsi: json["Dampak_Konsumsi"],
        dampakDisposal: json["Dampak_Disposal"],
        avgEnergy: json["avg_Energy"]?.toDouble(),
        shortDp: json["short_DP"],
        shortDk: json["short_DK"],
        shortDd: json["short_DD"],
        lokasi: json["lokasi"],
        sumber: json["Sumber"],
      );

  Map<String, dynamic> toJson() => {
        "Object_Name": objectName,
        "Representative_Image": representativeImage,
        "Recommended_ID": recommendedId,
        "Dampak_Produksi": dampakProduksi,
        "Dampak_Konsumsi": dampakKonsumsi,
        "Dampak_Disposal": dampakDisposal,
        "avg_Energy": avgEnergy,
        "short_DP": shortDp,
        "short_DK": shortDk,
        "short_DD": shortDd,
        "lokasi": lokasi,
        "Sumber": sumber,
      };
}

class Users {
  String firebaseId;
  int kwhId;
  String name;

  Users({
    required this.firebaseId,
    required this.kwhId,
    required this.name,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        firebaseId: json["firebaseId"],
        kwhId: json["kwhId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "firebaseId": firebaseId,
        "kwhId": kwhId,
        "name": name,
      };
}
