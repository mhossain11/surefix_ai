import 'dart:convert';

//import 'dashboardModel.dart';

// ChatgtpResponseModel allChatGPTResponseModelFromJson(String str) =>
//     ChatgtpResponseModel.fromJson(json.decode(str));
//
// String allChatGPTModelToJson(ChatgtpResponseModel data) => json.encode(data.toJson());
//
// class ChatgtpResponseModel {
//  List<AllItems> allItems;
//
//  ChatgtpResponseModel({
//    required this.allItems,
//  });
//
//  factory ChatgtpResponseModel.fromJson(Map<String, dynamic> json) {
//    print(json);
//    print(json["alldata"]);
//    return ChatgtpResponseModel(
//
//      allItems: json["alldata"] == null ? [] : List<AllItems>.from(json["alldata"].map((x) => AllItems.fromJson(x))),
//
//    );
//  }
//
//
//  Map<String, dynamic> toJson() => {
//
//    "alldata": allItems == null ? [] : List<dynamic>.from(allItems.map((x) => x.toJson())),
//
//  };
// }
//
// class AllItems {
//   String? name;
//   String? description;
//   AllItems({
//     required this.name,
//     required this.description,
// });
//
//   factory AllItems.fromJson(Map<String, dynamic> json) => AllItems(
//     name: json["name"],
//     description: json["description"],
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "description": description,
//
//   };
// }

class ChatgtpResponseModel3 {
  bool success;
  DataChat? data;
  String message;

  ChatgtpResponseModel3({
    required this.success,
    required this.data,
    required this.message,
  });

  ChatgtpResponseModel3.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool,
        data = json["data"] == null ? null : DataChat.fromJson(json["data"]),
        message = json['message'] as String;

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data,
    'message': message,
  };
}

class DataChat {
  List<Alldatum> alldata;

  DataChat({
    required this.alldata,
  });
  DataChat.fromJson(Map<String, dynamic> json)
      : alldata = json["alldata"] == null ? [] : List<Alldatum>.from(json["alldata"].map((x) => Alldatum.fromJson(x)));

  Map<String, dynamic> toJson() => {
    'alldata': alldata == null ? [] : List<dynamic>.from(alldata.map((x) => x.toJson())),
  };
}

class Alldatum {
  String name;
  String description;

  Alldatum({
    required this.name,
    required this.description,
  });

  Alldatum.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        description = json['description'] as String;

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
  };

}

