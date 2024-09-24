

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:surefix_ai/models/usersRequestModel.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/ProjectResource.dart';
import '../helpers/dialogs.dart';
import '../helpers/restartWidget.dart';
import '../helpers/snackbars.dart';
import '../models/postresponsemodel.dart';
import '../models/problemsolveModel.dart';
import '../utils/api_urls.dart';
import '../views/iMech_screen/requestDetails.dart';

class RequestDetailsController extends ChangeNotifier{
  String? requestId;
 void setValue(String value) {
    requestId = value;
  }
  final TextEditingController issueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? requestName;
  String? requestDescription;
  String get getRequestName => requestName!;
  String get getRequestDescription => requestDescription!;
  ProblemSolveModel problemSolveModel = ProblemSolveModel();



  var loading = false;
  var loadingError = false;
  var datarespons;
  Future<UsersRequestModel> userViewRequest({context}) async {
    SharedPreferences sp =await SharedPreferences.getInstance();
    var token  = sp.getString('tokenSP');

    var data = await http.get(Uri.parse(ApiEnd.postDetailsUrl+requestId!),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    datarespons =json.decode(data.body.toString());
    loading = false;
    if(data.statusCode == 200){
      loadingError = false;
      print('RequestDetailsController_userViewRequest Data Uploaded');
        requestName =datarespons["request"]["name"].toString();
        requestDescription =datarespons["request"]["description"].toString();

      return UsersRequestModel.fromJson(datarespons);

    }else{
      loading = false;
      loadingError = true;

      throw SnackBars.showSnackBar(
          context: context,
          content: datarespons['message'].toString().toUpperCase(),
          durationSec: 3,
          success: false,
          routeAction: null);

    }
  }

  Future<PostResponseModel> messageLists({context}) async {
    SharedPreferences sp =await SharedPreferences.getInstance();
    var token  = sp.getString('tokenSP');

    var data = await http.get(Uri.parse(ApiEnd.postResponseUrl+requestId!),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    datarespons =json.decode(data.body.toString());
    loading = false;
    if(data.statusCode == 200){
      loadingError = false;
     // print('2RequestDetailsController_userViewRequest Data Uploaded');

     // print(datarespons.toString());
      var datas= PostResponseModel.fromJson(datarespons);
     // print(datas.toString());
      return datas;

    }else{
      loading = false;
      loadingError = true;

      throw SnackBars.showSnackBar(
          context: context,
          content: datarespons['message'].toString().toUpperCase(),
          durationSec: 3,
          success: false,
          routeAction: null);

    }
  }

  void problemSolve({context,id}) async {
    loading = true;
    notifyListeners();
    SharedPreferences sp =await SharedPreferences.getInstance();
    var token  = sp.getString('tokenSP');

    var response = await http.get(Uri.parse(ApiEnd.problemSolveUrlfull+id),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    //var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print('RequestDetailsController_problemSolve Data Uploaded');
      AnimatedDialogs.successDialog(context,
          title: "The post updated successfully",
          subtitle: '',
          buttonText: "Ok",
          onResponse: () {
            Navigator.pop(context);

          });
    } else {
      notifyListeners();
      loading = false;
      AnimatedDialogs.successDialog(context,
          title: "Failed, Please try again later..",
          subtitle: '',
          buttonText: "Ok",
          onResponse: () {
            Navigator.pop(context);

          });

    }
  }


  Future<void>  addSolutionApis({context})async{
    print("Start");
    loading = true;
    notifyListeners();
    SharedPreferences sp =await SharedPreferences.getInstance();
    var usertoken  = sp.getString('tokenSP');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $usertoken',
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiEnd.addSolutionUrl));
    request.fields.addAll(
        {
          'possibleissue':issueController.text.toString(),
          'description':descriptionController.text.toString(),
          'postId':requestId.toString(),
          'isSolution':'0',
        }
    );
    print('Token : $usertoken');

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // var response = await http.Response.fromStream(streamedResponse);
    // var result = jsonDecode(utf8.decode(response.bodyBytes));
    // loading = false;

    print(requestId.toString());

    print('chat start');
    print(response.statusCode.toString());
    if(response.statusCode== 200 || response.statusCode== 201){
      loading = false;
    issueController.clear();
    descriptionController.clear();
      Navigator.of(context, rootNavigator: true).pop('dialog');
      print('chat End');
      // entityModel = UserEntityModel.fromJson(result);
      // return entityModel;

    }else{
      loading = false;
      notifyListeners();
      SnackBars.showSnackBar(
          context: context,
          content: 'Something is wrong',
          durationSec: 3,
          success: false,
          routeAction: null);

    }


  }





}
