class MechanicRegisterModel {
  bool? success;
  Data? data;
  String? message;

  MechanicRegisterModel({this.success, this.data, this.message});

  MechanicRegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? mechanicFullname;
  String? emailAddress;
  String? password;
  String? confirmPassword;
  String? mobile;
  String? userName;
  String? experienceLevel;
  String? specialistmakes;
  int? statusId;
  String? evidenceexperience;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  Data(
      {this.mechanicFullname,
        this.emailAddress,
        this.password,
        this.confirmPassword,
        this.mobile,
        this.userName,
        this.experienceLevel,
        this.specialistmakes,
        this.statusId,
        this.evidenceexperience,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    mechanicFullname = json['mechanic_fullname'];
    emailAddress = json['emailAddress'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    mobile = json['mobile'];
    userName = json['userName'];
    experienceLevel = json['experienceLevel'];
    specialistmakes = json['specialistmakes'];
    statusId = json['statusId'];
    evidenceexperience = json['evidenceexperience'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanic_fullname'] = this.mechanicFullname;
    data['emailAddress'] = this.emailAddress;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['mobile'] = this.mobile;
    data['userName'] = this.userName;
    data['experienceLevel'] = this.experienceLevel;
    data['specialistmakes'] = this.specialistmakes;
    data['statusId'] = this.statusId;
    data['evidenceexperience'] = this.evidenceexperience;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
