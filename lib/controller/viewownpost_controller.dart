import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surefix_ai/models/DashModel.dart';


import '../helpers/ProjectResource.dart';
import '../helpers/snackbars.dart';
import '../services/data/databasehelper.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;


class ViewOwnPostController extends ChangeNotifier {
  bool loading = false;
  bool loadingError = false;
 List<Requests> userList=[];
  Requests requestData = Requests();
  TextEditingController searchController = TextEditingController();
  DashModel  dashboardModeldata =DashModel();


  clear() {
    loading = false;
    loadingError = false;

  }

  initRegister() {
    searchController.clear();
  }




Future<Requests> getOrgDashboardData({context})async{
  loading = true;
  notifyListeners();
  SharedPreferences sp =await SharedPreferences.getInstance();
  bool internetOn = await ProjectResource.internetConnection();

  if(internetOn){
    var tokensd  = sp.getString('tokenSP');


    try{
      var response = await http.get(Uri.parse(ApiEnd.ownpostsurl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $tokensd',

          });
      //print('Token : $tokensd');
      print(response.statusCode);
      var convertData =jsonDecode(response.body);
      if(response.statusCode == 200){


        var dbRequestData= DashModel.fromJson(convertData);

        for (var data in dbRequestData.data!.requests!) {
          requestData = Requests.fromJson(data);
          DatabaseHelper.insertItem(requestData);
          return requestData;
        }
      }else{
        loading = false;
        loadingError = true;
        SnackBars.showSnackBar(
            context: context,
            content: "Something is wrong",
            durationSec: 3,
            success: false,
            routeAction: null);



      }

    }catch(e){
      print('Error: $e');
    }finally{
      notifyListeners();
      loading = false;
      return requestData;


    }
  }else{
    SnackBars.showSnackBar(
        context: context,
        content: 'Check internet connection',
        durationSec: 3,
        success: false,
        routeAction: null);
  }

  return requestData;

 }
 


 Future<List<Requests>> loadLocalData() async{
    final dataList =await DatabaseHelper.getUserData();
    SharedPreferences sp =await SharedPreferences.getInstance();

    userList.clear();
     userList = dataList.map((json)=> Requests.fromJson(json)).toList();
   print('Length:${userList.length.toString()}');
    return userList;

 }



}
