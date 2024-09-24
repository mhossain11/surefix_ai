class ProblemSolveModel {
  int? id;
  String? possibleissue;
  String? descriptionOld;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? postId;
  int? isSolution;

  ProblemSolveModel(
      {this.id,
        this.possibleissue,
        this.descriptionOld,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.postId,
        this.isSolution});

  ProblemSolveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    possibleissue = json['possibleissue'];
    descriptionOld = json['description_old'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    postId = json['postId'];
    isSolution = json['isSolution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['possibleissue'] = this.possibleissue;
    data['description_old'] = this.descriptionOld;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['postId'] = this.postId;
    data['isSolution'] = this.isSolution;
    return data;
  }
}
