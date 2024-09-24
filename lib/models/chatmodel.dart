class ChatModel{
  String? uid;
  String? textMessage;
  String? email;
  DateTime? time ;
  String? pic;
  ChatModel({this.uid ,required this.textMessage,this.email,this.time,this.pic});

  ChatModel.fromMap(Map<String,dynamic>map){
    uid = map['uid'];
    textMessage = map['textMessage'];
    email =map['email'];
    time= map['time'];
    pic = map['pic'];
  }

  Map<String,dynamic> toMap(){
    return {
      'uid':uid,
      'textMessage':textMessage,
      'email':email,
      'time':time,
      'pic':pic

    };
  }
}