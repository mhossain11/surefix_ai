
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/snackbars.dart';
import 'package:http/http.dart' as http;
import '../models/userentityModel.dart';
import '../models/usersRequestModel.dart';
import '../services/shared_preference.dart';
import '../utils/api_urls.dart';

class ChatBoxController extends ChangeNotifier{
  bool loading = false;
  String? requestId;
  var datarespons;
  var data;
  UserEntityModel entityModel = UserEntityModel();
  void setValue(String value) {
    requestId = value;
    //notifyListeners();
  }
  get dataResponseGet => datarespons;
 final TextEditingController messageController = TextEditingController();

  //scroll controller

Future<void>  getChatDataFromApis({context})async{
    print("Start");
    SharedPreferences sp =await SharedPreferences.getInstance();
    var usertoken  = sp.getString('tokenSP');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $usertoken',
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiEnd.imechChatUserResponsePostUrlfull));

    request.fields.addAll({
          "responseText":messageController.text,
          "postId":requestId.toString(),
        });


    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();


    var result= await response.stream.bytesToString();
   // var response = await http.Response.fromStream(streamedResponse);
   // var result = jsonDecode(utf8.decode(response.bodyBytes));
    // loading = false;

    if(response.statusCode== 200){

     messageController.clear();
     // entityModel = UserEntityModel.fromJson(result);
     // return entityModel;

    }else{
      loading = false;
      SnackBars.showSnackBar(
          context: context,
          content: 'Something is wrong',
          durationSec: 3,
          success: false,
          routeAction: null);

    }


  }

}