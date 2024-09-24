/// request : {"id":1,"name":"VW Golf R, Engine Warning light flashing","description":"The engine warning light on my 2018 Golf R is flashing intermittently when I go over 80 mph.","requestedby":3,"created_at":null,"updated_at":null,"requestFile":null}
/// issueResponses : [{"Resolved":1,"ResolvingResponse":1,"responseIdOut":43,"id":9,"responseText":"This is response text","requestId":1,"stars":0,"created_at":"2024-02-18 18:23:23","updated_at":"2024-02-18 18:23:23","userId":9,"respondedBy":9,"name":"Noman","email":"noman@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":44,"id":14,"responseText":"This is test response text","requestId":1,"stars":0,"created_at":"2024-02-18 20:15:11","updated_at":"2024-02-18 20:15:11","userId":14,"respondedBy":14,"name":"Ismail Hossain","email":"ismail@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":48,"id":25,"responseText":"rtrtrwetwerqt","requestId":1,"stars":0,"created_at":"2024-03-07 17:23:56","updated_at":"2024-03-07 17:23:56","userId":25,"respondedBy":25,"name":"ArifHossain 22","email":"arif@gmail.com","type":3,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":49,"id":25,"responseText":"ragadfhdjafg","requestId":1,"stars":0,"created_at":"2024-03-07 17:25:43","updated_at":"2024-03-07 17:25:43","userId":25,"respondedBy":25,"name":"ArifHossain 22","email":"arif@gmail.com","type":3,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":55,"id":34,"responseText":"this is good test","requestId":1,"stars":0,"created_at":"2024-03-14 06:05:56","updated_at":"2024-03-14 06:05:56","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":57,"id":34,"responseText":"this is good test","requestId":1,"stars":0,"created_at":"2024-03-14 06:11:44","updated_at":"2024-03-14 06:11:44","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":67,"id":34,"responseText":"This is good test fdsg","requestId":1,"stars":0,"created_at":"2024-03-16 11:38:15","updated_at":"2024-03-16 11:38:15","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":70,"id":14,"responseText":"this is good","requestId":1,"stars":0,"created_at":"2024-03-16 19:51:55","updated_at":"2024-03-16 19:51:55","userId":14,"respondedBy":14,"name":"Ismail Hossain","email":"ismail@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":78,"id":34,"responseText":"Hi i have some problem","requestId":1,"stars":0,"created_at":"2024-03-17 08:55:18","updated_at":"2024-03-17 08:55:18","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":91,"id":14,"responseText":"jhgjjhl","requestId":1,"stars":0,"created_at":"2024-03-19 06:43:28","updated_at":"2024-03-19 06:43:28","userId":14,"respondedBy":14,"name":"Ismail Hossain","email":"ismail@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":92,"id":34,"responseText":"Hi i have some problem","requestId":1,"stars":0,"created_at":"2024-03-20 05:06:38","updated_at":"2024-03-20 05:06:38","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":94,"id":34,"responseText":"hvhvhvvuvuv","requestId":1,"stars":0,"created_at":"2024-03-23 06:58:33","updated_at":"2024-03-23 06:58:33","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":95,"id":34,"responseText":"this is good test","requestId":1,"stars":0,"created_at":"2024-03-23 14:01:14","updated_at":"2024-03-23 14:01:14","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6},{"Resolved":1,"ResolvingResponse":1,"responseIdOut":96,"id":34,"responseText":"this is good test","requestId":1,"stars":0,"created_at":"2024-03-23 15:12:07","updated_at":"2024-03-23 15:12:07","userId":34,"respondedBy":34,"name":"faysal2","email":"faysal1@gmail.com","type":0,"issue_responses_count":6}]
/// triages : [{"id":39,"issue":"This is save triage issue","description":"This is save triage issue","created_at":"2024-02-18T22:27:10.000000Z","updated_at":"2024-02-18T22:27:10.000000Z","requestId":1},{"id":40,"issue":"This is save triage issue 2","description":"This is save triage issue 2","created_at":"2024-02-18T22:29:10.000000Z","updated_at":"2024-02-18T22:29:10.000000Z","requestId":1}]

class ChatrequestviewModel {
  ChatrequestviewModel({
      Request? request, 
      List<IssueResponses>? issueResponses, 
      List<Triages>? triages,}){
    _request = request;
    _issueResponses = issueResponses;
    _triages = triages;
}

  ChatrequestviewModel.fromJson(dynamic json) {
    _request = json['request'] != null ? Request.fromJson(json['request']) : null;
    if (json['issueResponses'] != null) {
      _issueResponses = [];
      json['issueResponses'].forEach((v) {
        _issueResponses?.add(IssueResponses.fromJson(v));
      });
    }
    if (json['triages'] != null) {
      _triages = [];
      json['triages'].forEach((v) {
        _triages?.add(Triages.fromJson(v));
      });
    }
  }
  Request? _request;
  List<IssueResponses>? _issueResponses;
  List<Triages>? _triages;
ChatrequestviewModel copyWith({  Request? request,
  List<IssueResponses>? issueResponses,
  List<Triages>? triages,
}) => ChatrequestviewModel(  request: request ?? _request,
  issueResponses: issueResponses ?? _issueResponses,
  triages: triages ?? _triages,
);
  Request? get request => _request;
  List<IssueResponses>? get issueResponses => _issueResponses;
  List<Triages>? get triages => _triages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_request != null) {
      map['request'] = _request?.toJson();
    }
    if (_issueResponses != null) {
      map['issueResponses'] = _issueResponses?.map((v) => v.toJson()).toList();
    }
    if (_triages != null) {
      map['triages'] = _triages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 39
/// issue : "This is save triage issue"
/// description : "This is save triage issue"
/// created_at : "2024-02-18T22:27:10.000000Z"
/// updated_at : "2024-02-18T22:27:10.000000Z"
/// requestId : 1

class Triages {
  Triages({
      num? id, 
      String? issue, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      num? requestId,}){
    _id = id;
    _issue = issue;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _requestId = requestId;
}

  Triages.fromJson(dynamic json) {
    _id = json['id'];
    _issue = json['issue'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _requestId = json['requestId'];
  }
  num? _id;
  String? _issue;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  num? _requestId;
Triages copyWith({  num? id,
  String? issue,
  String? description,
  String? createdAt,
  String? updatedAt,
  num? requestId,
}) => Triages(  id: id ?? _id,
  issue: issue ?? _issue,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  requestId: requestId ?? _requestId,
);
  num? get id => _id;
  String? get issue => _issue;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get requestId => _requestId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['issue'] = _issue;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['requestId'] = _requestId;
    return map;
  }

}

/// Resolved : 1
/// ResolvingResponse : 1
/// responseIdOut : 43
/// id : 9
/// responseText : "This is response text"
/// requestId : 1
/// stars : 0
/// created_at : "2024-02-18 18:23:23"
/// updated_at : "2024-02-18 18:23:23"
/// userId : 9
/// respondedBy : 9
/// name : "Noman"
/// email : "noman@gmail.com"
/// type : 0
/// issue_responses_count : 6

class IssueResponses {
  IssueResponses({
      num? resolved, 
      num? resolvingResponse, 
      num? responseIdOut, 
      num? id, 
      String? responseText, 
      num? requestId, 
      num? stars, 
      String? createdAt, 
      String? updatedAt, 
      num? userId, 
      num? respondedBy, 
      String? name, 
      String? email, 
      num? type, 
      num? issueResponsesCount,}){
    _resolved = resolved;
    _resolvingResponse = resolvingResponse;
    _responseIdOut = responseIdOut;
    _id = id;
    _responseText = responseText;
    _requestId = requestId;
    _stars = stars;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _userId = userId;
    _respondedBy = respondedBy;
    _name = name;
    _email = email;
    _type = type;
    _issueResponsesCount = issueResponsesCount;
}

  IssueResponses.fromJson(dynamic json) {
    _resolved = json['Resolved'];
    _resolvingResponse = json['ResolvingResponse'];
    _responseIdOut = json['responseIdOut'];
    _id = json['id'];
    _responseText = json['responseText'];
    _requestId = json['requestId'];
    _stars = json['stars'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userId = json['userId'];
    _respondedBy = json['respondedBy'];
    _name = json['name'];
    _email = json['email'];
    _type = json['type'];
    _issueResponsesCount = json['issue_responses_count'];
  }
  num? _resolved;
  num? _resolvingResponse;
  num? _responseIdOut;
  num? _id;
  String? _responseText;
  num? _requestId;
  num? _stars;
  String? _createdAt;
  String? _updatedAt;
  num? _userId;
  num? _respondedBy;
  String? _name;
  String? _email;
  num? _type;
  num? _issueResponsesCount;
IssueResponses copyWith({  num? resolved,
  num? resolvingResponse,
  num? responseIdOut,
  num? id,
  String? responseText,
  num? requestId,
  num? stars,
  String? createdAt,
  String? updatedAt,
  num? userId,
  num? respondedBy,
  String? name,
  String? email,
  num? type,
  num? issueResponsesCount,
}) => IssueResponses(  resolved: resolved ?? _resolved,
  resolvingResponse: resolvingResponse ?? _resolvingResponse,
  responseIdOut: responseIdOut ?? _responseIdOut,
  id: id ?? _id,
  responseText: responseText ?? _responseText,
  requestId: requestId ?? _requestId,
  stars: stars ?? _stars,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  userId: userId ?? _userId,
  respondedBy: respondedBy ?? _respondedBy,
  name: name ?? _name,
  email: email ?? _email,
  type: type ?? _type,
  issueResponsesCount: issueResponsesCount ?? _issueResponsesCount,
);
  num? get resolved => _resolved;
  num? get resolvingResponse => _resolvingResponse;
  num? get responseIdOut => _responseIdOut;
  num? get id => _id;
  String? get responseText => _responseText;
  num? get requestId => _requestId;
  num? get stars => _stars;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get userId => _userId;
  num? get respondedBy => _respondedBy;
  String? get name => _name;
  String? get email => _email;
  num? get type => _type;
  num? get issueResponsesCount => _issueResponsesCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Resolved'] = _resolved;
    map['ResolvingResponse'] = _resolvingResponse;
    map['responseIdOut'] = _responseIdOut;
    map['id'] = _id;
    map['responseText'] = _responseText;
    map['requestId'] = _requestId;
    map['stars'] = _stars;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['userId'] = _userId;
    map['respondedBy'] = _respondedBy;
    map['name'] = _name;
    map['email'] = _email;
    map['type'] = _type;
    map['issue_responses_count'] = _issueResponsesCount;
    return map;
  }

}

/// id : 1
/// name : "VW Golf R, Engine Warning light flashing"
/// description : "The engine warning light on my 2018 Golf R is flashing intermittently when I go over 80 mph."
/// requestedby : 3
/// created_at : null
/// updated_at : null
/// requestFile : null

class Request {
  Request({
      num? id, 
      String? name, 
      String? description, 
      num? requestedby, 
      dynamic createdAt, 
      dynamic updatedAt, 
      dynamic requestFile,}){
    _id = id;
    _name = name;
    _description = description;
    _requestedby = requestedby;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _requestFile = requestFile;
}

  Request.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _requestedby = json['requestedby'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _requestFile = json['requestFile'];
  }
  num? _id;
  String? _name;
  String? _description;
  num? _requestedby;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _requestFile;
Request copyWith({  num? id,
  String? name,
  String? description,
  num? requestedby,
  dynamic createdAt,
  dynamic updatedAt,
  dynamic requestFile,
}) => Request(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  requestedby: requestedby ?? _requestedby,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  requestFile: requestFile ?? _requestFile,
);
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get requestedby => _requestedby;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get requestFile => _requestFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['requestedby'] = _requestedby;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['requestFile'] = _requestFile;
    return map;
  }

}