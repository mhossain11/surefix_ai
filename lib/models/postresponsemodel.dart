class PostResponseModel {
  List<PostResponse>? postResponse;

  PostResponseModel({this.postResponse});

  PostResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['postResponse'] != null) {
      postResponse = <PostResponse>[];
      json['postResponse'].forEach((v) {
        postResponse!.add(new PostResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postResponse != null) {
      data['postResponse'] = this.postResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostResponse {
  int? id;
  String? responseText;
  int? postId;
  int? stars;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? viewed;

  PostResponse(
      {this.id,
        this.responseText,
        this.postId,
        this.stars,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.viewed});

  PostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    responseText = json['responseText'];
    postId = json['postId'];
    stars = json['stars'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['userId'];
    viewed = json['viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['responseText'] = this.responseText;
    data['postId'] = this.postId;
    data['stars'] = this.stars;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['userId'] = this.userId;
    data['viewed'] = this.viewed;
    return data;
  }
}
