class ProfileModel {
  User? user;

  ProfileModel({this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? userImage;
  dynamic mobile;
  String? userName;
  int? status;
  int? otp;
  String? otpExpiry;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.userImage,
        this.mobile,
        this.userName,
        this.status,
        this.otp,
        this.otpExpiry});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    userImage = json['userImage'];
    mobile = json['mobile'];
    userName = json['userName'];
    status = json['status'];
    otp = json['otp'];
    otpExpiry = json['otp_expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    data['userImage'] = userImage;
    data['mobile'] = mobile;
    data['userName'] = userName;
    data['status'] = status;
    data['otp'] = otp;
    data['otp_expiry'] = otpExpiry;
    return data;
  }
}
