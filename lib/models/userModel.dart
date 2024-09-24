// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  dynamic totalPurchaseInvoice;
  dynamic totalSalessInvoice;
  dynamic totalFiles;
  List<Allunprocesseddocument> allunprocesseddocuments;
  dynamic message;
  UserProfile? userProfile ;

  UserModel({
    this.totalPurchaseInvoice,
    this.totalSalessInvoice,
    this.totalFiles,
    required this.allunprocesseddocuments,
    this.message,
    required this.userProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    totalPurchaseInvoice: json["TotalPurchaseInvoice"],
    totalSalessInvoice: json["TotalSalessInvoice"],
    totalFiles: json["TotalFiles"],
    allunprocesseddocuments: json["allunprocesseddocuments"] == null ? [] : List<Allunprocesseddocument>.from(json["allunprocesseddocuments"].map((x) => Allunprocesseddocument.fromJson(x))),
    message: json["Message"],
    userProfile: json["UserProfile"] == null ? null : UserProfile.fromJson(json["UserProfile"]),
  );

  Map<String, dynamic> toJson() => {
    "TotalPurchaseInvoice": totalPurchaseInvoice,
    "TotalSalessInvoice": totalSalessInvoice,
    "TotalFiles": totalFiles,
    "allunprocesseddocuments": allunprocesseddocuments == null ? [] : List<dynamic>.from(allunprocesseddocuments.map((x) => x.toJson())),
    "Message": message,
    "UserProfile": userProfile?.toJson(),
  };
}

class Allunprocesseddocument {
  String administratorName;
  int administratorId;
  int totalfiles;

  Allunprocesseddocument({
    required this.administratorName,
    required this.administratorId,
    required this.totalfiles,
  });

  factory Allunprocesseddocument.fromJson(Map<String, dynamic> json) => Allunprocesseddocument(
    administratorName: json["AdministratorName"],
    administratorId: json["AdministratorId"],
    totalfiles: json["Totalfiles"],
  );

  Map<String, dynamic> toJson() => {
    "AdministratorName": administratorName,
    "AdministratorId": administratorId,
    "Totalfiles": totalfiles,
  };
}

class UserProfile {
  FrontEndUser? frontEndUser;
  String message;
  dynamic allAdministration;
  int administrationId;
  dynamic administrations;
  dynamic createadministration;

  UserProfile({
    required this.frontEndUser,
    required this.message,
    this.allAdministration,
    required this.administrationId,
    this.administrations,
    this.createadministration,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    frontEndUser: json["FrontEndUser"] == null ? null : FrontEndUser.fromJson(json["FrontEndUser"]),
    message: json["message"],
    allAdministration: json["AllAdministration"],
    administrationId: json["AdministrationId"],
    administrations: json["Administrations"],
    createadministration: json["createadministration"],
  );

  Map<String, dynamic> toJson() => {
    "FrontEndUser": frontEndUser?.toJson(),
    "message": message,
    "AllAdministration": allAdministration,
    "AdministrationId": administrationId,
    "Administrations": administrations,
    "createadministration": createadministration,
  };
}

class FrontEndUser {
  int pkUserId;
  String fullName;
  String firstName;
  String lastName;
  String email;
  String profileImage;
  String gender;
  String mobile;
  String password;
  int userTypeId;
  Usertype? usertype;
  String userTokenConfirmation;
  bool status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String deletedBy;
  String updatedBy;
  String createdBy;

  FrontEndUser({
    required this.pkUserId,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImage,
    required this.gender,
    required this.mobile,
    required this.password,
    required this.userTypeId,
    required this.usertype,
    required this.userTokenConfirmation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedBy,
    required this.updatedBy,
    required this.createdBy,
  });

  factory FrontEndUser.fromJson(Map<String, dynamic> json) => FrontEndUser(
    pkUserId: json["PkUserId"],
    fullName: json["FullName"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    email: json["Email"],
    profileImage: json["ProfileImage"],
    gender: json["Gender"],
    mobile: json["Mobile"],
    password: json["Password"],
    userTypeId: json["UserTypeID"],
    usertype: json["usertype"] == null ? null : Usertype.fromJson(json["usertype"]),
    userTokenConfirmation: json["UserTokenConfirmation"],
    status: json["Status"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedBy: json["DeletedBy"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "PkUserId": pkUserId,
    "FullName": fullName,
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "ProfileImage": profileImage,
    "Gender": gender,
    "Mobile": mobile,
    "Password": password,
    "UserTypeID": userTypeId,
    "usertype": usertype?.toJson(),
    "UserTokenConfirmation": userTokenConfirmation,
    "Status": status,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedBy": deletedBy,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
  };
}

class Usertype {
  int pkUserTypelId;
  String userTypeName;
  bool status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String deletedBy;
  String updatedBy;
  String createdBy;

  Usertype({
    required this.pkUserTypelId,
    required this.userTypeName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedBy,
    required this.updatedBy,
    required this.createdBy,
  });

  factory Usertype.fromJson(Map<String, dynamic> json) => Usertype(
    pkUserTypelId: json["PkUserTypelId"],
    userTypeName: json["UserTypeName"],
    status: json["Status"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedBy: json["DeletedBy"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "PkUserTypelId": pkUserTypelId,
    "UserTypeName": userTypeName,
    "Status": status,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedBy": deletedBy,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
  };
}
