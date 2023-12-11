// To parse this JSON data, do
//
//     final objectModel = objectModelFromJson(jsonString);

import 'dart:convert';

ObjectModel objectModelFromJson(String str) =>
    ObjectModel.fromJson(json.decode(str));

String objectModelToJson(ObjectModel data) => json.encode(data.toJson());

class ObjectModel {
  String status;
  List<ObjectData> data;

  ObjectModel({
    required this.status,
    required this.data,
  });

  factory ObjectModel.fromJson(Map<String, dynamic> json) => ObjectModel(
        status: json["status"],
        data: List<ObjectData>.from(
            json["data"].map((x) => ObjectData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ObjectData {
  String objectName;
  double avgEnergy;
  List<Type> type;

  ObjectData({
    required this.objectName,
    required this.avgEnergy,
    required this.type,
  });

  factory ObjectData.fromJson(Map<String, dynamic> json) => ObjectData(
        objectName: json["Object_Name"],
        avgEnergy: json["avg_Energy"]?.toDouble(),
        type: List<Type>.from(json["type"].map((x) => Type.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Object_Name": objectName,
        "avg_Energy": avgEnergy,
        "type": List<dynamic>.from(type.map((x) => x.toJson())),
      };
}

class Type {
  String objectName;
  String typeId;
  DetailedType? detailedType;
  Lumens? lumens;

  Type({
    required this.objectName,
    required this.typeId,
    required this.detailedType,
    required this.lumens,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        objectName: json["Object_Name"],
        typeId: json["Type_ID"],
        detailedType: json["detailed_type"] == null
            ? null
            : DetailedType.fromJson(json["detailed_type"]),
        lumens: json["lumens"] == null ? null : Lumens.fromJson(json["lumens"]),
      );

  Map<String, dynamic> toJson() => {
        "Object_Name": objectName,
        "Type_ID": typeId,
        "detailed_type": detailedType?.toJson(),
        "lumens": lumens?.toJson(),
      };
}

class DetailedType {
  String typeId;
  String typeDesc;

  DetailedType({
    required this.typeId,
    required this.typeDesc,
  });

  factory DetailedType.fromJson(Map<String, dynamic> json) => DetailedType(
        typeId: json["Type_ID"],
        typeDesc: json["Type_Desc"],
      );

  Map<String, dynamic> toJson() => {
        "Type_ID": typeId,
        "Type_Desc": typeDesc,
      };
}

class Lumens {
  String typeId;
  int lw;

  Lumens({
    required this.typeId,
    required this.lw,
  });

  factory Lumens.fromJson(Map<String, dynamic> json) => Lumens(
        typeId: json["Type_ID"],
        lw: json["LW"],
      );

  Map<String, dynamic> toJson() => {
        "Type_ID": typeId,
        "LW": lw,
      };
}
