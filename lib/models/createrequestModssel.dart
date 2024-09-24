class ChatgtpResponseModel {
  Success? success;
  String? message;

  ChatgtpResponseModel({this.success, this.message});

  ChatgtpResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Alldata>? alldata;
  String? title;
  String? description;
  int? requestedby;
  String? requestFile;
  Notification? notification;

  Success(
      {this.alldata,
        this.title,
        this.description,
        this.requestedby,
        this.requestFile,
        this.notification});

  Success.fromJson(Map<String, dynamic> json) {
    if (json['alldata'] != null) {
      alldata = <Alldata>[];
      json['alldata'].forEach((v) {
        alldata!.add(new Alldata.fromJson(v));
      });
    }
    title = json['title'];
    description = json['description'];
    requestedby = json['requestedby'];
    requestFile = json['requestFile'];
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alldata != null) {
      data['alldata'] = this.alldata!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['requestedby'] = this.requestedby;
    data['requestFile'] = this.requestFile;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    return data;
  }
}

class Alldata {
  String? possibleissue;
  int? postId;
  String? description;

  Alldata({this.possibleissue, this.postId, this.description});

  Alldata.fromJson(Map<String, dynamic> json) {
    possibleissue = json['possibleissue'];
    postId = json['postId'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['possibleissue'] = this.possibleissue;
    data['postId'] = this.postId;
    data['description'] = this.description;
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
