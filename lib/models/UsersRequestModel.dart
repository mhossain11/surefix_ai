class UsersRequestModel {
  Request? request;
  List<Triages>? triages;

  UsersRequestModel({this.request, this.triages});

  UsersRequestModel.fromJson(Map<String, dynamic> json) {
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
    if (json['triages'] != null) {
      triages = <Triages>[];
      json['triages'].forEach((v) {
        triages!.add(new Triages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.triages != null) {
      data['triages'] = this.triages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Request {
  int? id;
  String? title;
  Null? descriptionOld;
  String? description;
  int? requestedby;
  String? createdAt;
  String? updatedAt;
  String? requestFile;
  Null? attachFile;
  String? make;
  String? model;
  int? yearofmake;
  String? registrationnumber;
  String? faultCode;
  int? isSolved;

  Request(
      {this.id,
        this.title,
        this.descriptionOld,
        this.description,
        this.requestedby,
        this.createdAt,
        this.updatedAt,
        this.requestFile,
        this.attachFile,
        this.make,
        this.model,
        this.yearofmake,
        this.registrationnumber,
        this.faultCode,
        this.isSolved});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descriptionOld = json['description_old'];
    description = json['description'];
    requestedby = json['requestedby'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    requestFile = json['requestFile'];
    attachFile = json['attachFile'];
    make = json['make'];
    model = json['model'];
    yearofmake = json['yearofmake'];
    registrationnumber = json['registrationnumber'];
    faultCode = json['faultCode'];
    isSolved = json['isSolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description_old'] = this.descriptionOld;
    data['description'] = this.description;
    data['requestedby'] = this.requestedby;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['requestFile'] = this.requestFile;
    data['attachFile'] = this.attachFile;
    data['make'] = this.make;
    data['model'] = this.model;
    data['yearofmake'] = this.yearofmake;
    data['registrationnumber'] = this.registrationnumber;
    data['faultCode'] = this.faultCode;
    data['isSolved'] = this.isSolved;
    return data;
  }
}

class Triages {
  int? id;
  String? possibleissue;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? postId;
  num? isSolution;

  Triages(
      {this.id,
        this.possibleissue,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.postId,
        this.isSolution});

  Triages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    possibleissue = json['possibleissue'];
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
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['postId'] = this.postId;
    data['isSolution'] = this.isSolution;
    return data;
  }
}
