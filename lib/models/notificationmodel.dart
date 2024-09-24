class NotificationModel {
  List<Notifications>? notifications;
  String? message;

  NotificationModel({this.notifications, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Notifications {
  int? id;
  String? notificationText;
  int? postId;
  String? postTitle;
  String? postDescription;
  int? userId;
  String? createdAt;

  Notifications({this.id,
    this.notificationText,
    this.postId,
    this.postTitle,
    this.postDescription,
    this.userId,
    this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationText = json['notification_text'];
    postId = json['postId'];
    postTitle = json['post_title'];
    postDescription = json['post_description'];
    userId = json['user_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notification_text'] = notificationText;
    data['postId'] = postId;
    data['post_title'] = postTitle;
    data['post_description'] = postDescription;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    return data;
  }
}
