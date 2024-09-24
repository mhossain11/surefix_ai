class UserEntityModel {
  bool? success;
  Data? data;
  String? message;

  UserEntityModel({this.success, this.data, this.message});

  UserEntityModel.fromJson(Map<String, dynamic> json) {
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
  SaveNewRequest? saveNewRequest;

  Data({this.saveNewRequest});

  Data.fromJson(Map<String, dynamic> json) {
    saveNewRequest = json['saveNewRequest'] != null
        ? new SaveNewRequest.fromJson(json['saveNewRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.saveNewRequest != null) {
      data['saveNewRequest'] = this.saveNewRequest!.toJson();
    }
    return data;
  }
}

class SaveNewRequest {
  String? responseText;
  String? requestId;
  int? stars;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  SaveNewRequest(
      {this.responseText,
        this.requestId,
        this.stars,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  SaveNewRequest.fromJson(Map<String, dynamic> json) {
    responseText = json['responseText'];
    requestId = json['requestId'];
    stars = json['stars'];
    userId = json['userId'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseText'] = this.responseText;
    data['requestId'] = this.requestId;
    data['stars'] = this.stars;
    data['userId'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
