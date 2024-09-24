class BannerModel {
  Success? success;
  String? message;

  BannerModel({this.success, this.message});

  BannerModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new Success.fromJson(json['success']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Success {
  int? allnotification;
  List<Notices>? notices;

  Success({this.allnotification, this.notices});

  Success.fromJson(Map<String, dynamic> json) {
    allnotification = json['allnotification'];
    if (json['notices'] != null) {
      notices = <Notices>[];
      json['notices'].forEach((v) {
        notices!.add(new Notices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allnotification'] = this.allnotification;
    if (this.notices != null) {
      data['notices'] = this.notices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notices {
  int? id;
  String? title;
  String? description;
  String? expirationDate;
  String? createdAt;
  String? updatedAt;

  Notices(
      {this.id,
        this.title,
        this.description,
        this.expirationDate,
        this.createdAt,
        this.updatedAt});

  Notices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    expirationDate = json['expirationDate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['expirationDate'] = this.expirationDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
