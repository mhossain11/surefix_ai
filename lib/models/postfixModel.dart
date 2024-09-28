class PostFixModel {
  Success? success;
  String? message;

  PostFixModel({this.success, this.message});

  PostFixModel.fromJson(Map<String, dynamic> json) {
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
  String? possibleissue;
  String? description;
  int? requestedby;
  Notification? notification;

  Success(
      {this.possibleissue,
        this.description,
        this.requestedby,
        this.notification});

  Success.fromJson(Map<String, dynamic> json) {
    possibleissue = json['possibleissue'];
    description = json['description'];
    requestedby = json['requestedby'];
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['possibleissue'] = this.possibleissue;
    data['description'] = this.description;
    data['requestedby'] = this.requestedby;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    return data;
  }
}

class Notification {
  String? notificationText;
  int? postId;
  int? userId;

  Notification({this.notificationText, this.postId, this.userId});

  Notification.fromJson(Map<String, dynamic> json) {
    notificationText = json['notification_text'];
    postId = json['postId'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_text'] = this.notificationText;
    data['postId'] = this.postId;
    data['user_id'] = this.userId;
    return data;
  }
}
