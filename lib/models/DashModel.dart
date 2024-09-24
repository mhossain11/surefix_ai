// To parse this JSON data, do
//
//     final dashModel = dashModelFromJson(jsonString);


/*import 'dart:convert';

import 'package:hive/hive.dart';
//part 'dashModel.g.dart';

DashModel dashModelFromJson(String str) => DashModel.fromJson(json.decode(str));

String dashModelToJson(DashModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class DashModel {
  @HiveField(1)
  bool? success;
  @HiveField(2)
  Data? data;
  @HiveField(3)
  String? message;

  DashModel({
    this.success,
    this.data,
    this.message,
  });

  factory DashModel.fromJson(Map<String, dynamic> json) => DashModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

@HiveType(typeId: 2)
class Data {
  @HiveField(1)
  List<Request> requests;

  Data({
    required this.requests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    requests: List<Request>.from(json["requests"].map((x) => Request.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 3)
class Request {
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? descriptionOld;
  @HiveField(4)
  String? description;
  @HiveField(5)
  int? requestedby;
  @HiveField(6)
  String? createdAt;
  @HiveField(7)
  String? updatedAt;
  @HiveField(8)
  String? requestFile;
  @HiveField(9)
  String? attachFile;
  @HiveField(10)
  String? make;
  @HiveField(11)
  String? model;
  @HiveField(12)
  int? yearofmake;
  @HiveField(13)
  String? registrationnumber;
  @HiveField(14)
  String? faultCode;
  @HiveField(15)
  int? isSolved;

  Request({
    this.id,
    this.title,
    this.descriptionOld,
    this.description,
    this.requestedby,
    this.createdAt,
    this.updatedAt,
    this.requestFile,
    this.attachFile,
    this.make,
    this.model,
    this.yearofmake,
    this.registrationnumber,
    this.faultCode,
    this.isSolved,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["id"],
    title: json["title"],
    descriptionOld: json["description_old"],
    description: json["description"],
    requestedby: json["requestedby"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    requestFile: json["requestFile"],
    attachFile: json["attachFile"],
    make: json["make"],
    model: json["model"],
    yearofmake: json["yearofmake"],
    registrationnumber: json["registrationnumber"],
    faultCode: json["faultCode"],
    isSolved: json["isSolved"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description_old": descriptionOld,
    "description": description,
    "requestedby": requestedby,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "requestFile": requestFile,
    "attachFile": attachFile,
    "make": make,
    "model": model,
    "yearofmake": yearofmake,
    "registrationnumber": registrationnumber,
    "faultCode": faultCode,
    "isSolved": isSolved,
  };
}*/






import 'dart:convert';

DashModel dashModelFromJson(String str) => DashModel.fromJson(json.decode(str));

String dashModelToJson(DashModel data) => json.encode(data.toJson());
class DashModel {
  bool? success;
  Data? data;
  String? message;

  DashModel({this.success, this.data, this.message});

 factory DashModel.fromJson(Map<String, dynamic> json) =>
 DashModel(
   success: json["success"],
   data: json["data"] == null ? null : Data.fromJson(json["data"]),
   message: json["message"],
 );

  Map<String, dynamic> toJson() => {
    "success" :success,
    "data" :  data!.toJson(),
    "message": message,
  };
}

class Data {
  List<dynamic>? requests;

  Data({
    this.requests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    requests: json["requests"] == null
        ? []
        : List<dynamic>.from(json["requests"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "requests":
    requests == null ? [] : List<dynamic>.from(requests!.map((x) => x)),
  };
}

class Requests {
  int? id;
  String? title;
  dynamic descriptionOld;
  String? description;
  int? requestedby;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? requestFile;
  dynamic attachFile;
  String? make;
  String? model;
  int? yearofmake;
  String? registrationnumber;
  dynamic faultCode;
  int? isSolved;

  Requests(
      { this.id,
        this.title,
        this.descriptionOld,
        this.description,
        this.requestedby,
        this.createdAt,
        this.updatedAt,
        this.requestFile,
        this.attachFile,
        this.make,
        this.model,
        this.yearofmake,
        this.registrationnumber,
        this.faultCode,
        this.isSolved,
      });

  factory Requests.fromJson(Map<String, dynamic> json) => Requests(
    id: json["id"],
    title: json["title"],
    descriptionOld: json["description_old"],
    description: json["description"],
    requestedby: json["requestedby"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    requestFile: json["requestFile"],
    attachFile: json["attachFile"],
    make: json["make"],
    model: json["model"],
    yearofmake: json["yearofmake"],
    registrationnumber: json["registrationnumber"],
    faultCode: json["faultCode"],
    isSolved: json["isSolved"],
  );



  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description_old": descriptionOld,
    "description": description,
    "requestedby": requestedby,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "requestFile": requestFile,
    "attachFile": attachFile,
    "make": make,
    "model": model,
    "yearofmake": yearofmake,
    "registrationnumber": registrationnumber,
    "faultCode": faultCode,
    "isSolved": isSolved,
  };
}
