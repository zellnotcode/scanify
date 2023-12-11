// To parse this JSON data, do
//
//     final dataUserModel = dataUserModelFromJson(jsonString);

import 'dart:convert';

DataUserModel dataUserModelFromJson(String str) =>
    DataUserModel.fromJson(json.decode(str));

String dataUserModelToJson(DataUserModel data) => json.encode(data.toJson());

class DataUserModel {
  String status;
  User data;

  DataUserModel({
    required this.status,
    required this.data,
  });

  factory DataUserModel.fromJson(Map<String, dynamic> json) => DataUserModel(
        status: json["status"],
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class User {
  String firebaseId;
  int kwhId;
  String name;
  Kwh kwh;

  User({
    required this.firebaseId,
    required this.kwhId,
    required this.name,
    required this.kwh,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firebaseId: json["firebaseId"],
        kwhId: json["kwhId"],
        name: json["name"],
        kwh: Kwh.fromJson(json["kwh"]),
      );

  Map<String, dynamic> toJson() => {
        "firebaseId": firebaseId,
        "kwhId": kwhId,
        "name": name,
        "kwh": kwh.toJson(),
      };
}

class Kwh {
  int id;
  String jenis;
  int kVa;

  Kwh({
    required this.id,
    required this.jenis,
    required this.kVa,
  });

  factory Kwh.fromJson(Map<String, dynamic> json) => Kwh(
        id: json["id"],
        jenis: json["jenis"],
        kVa: json["kVA"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "kVA": kVa,
      };
}
