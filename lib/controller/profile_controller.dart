import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/ProjectResource.dart';
import 'package:http/http.dart'as http;

import '../helpers/snackbars.dart';
import '../models/profilemodel.dart';
import '../utils/api_urls.dart';

class ProfileController extends ChangeNotifier{
 bool loading = false;
 ProfileModel profileModel = ProfileModel();
  Future<ProfileModel> profileData({context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool internetOn = await ProjectResource.internetConnection();

    if(internetOn){
      var tokensd = sp.getString('tokenSP');
      var userId = sp.getString('userid');
        print(userId.toString());
      var data = await http.get(Uri.parse(ApiEnd.userProfile+userId!), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokensd',
      });

      var datas = json.decode(data.body.toString());
      loading = false;
      print(data.statusCode);
      print('profileScreen');
      if (data.statusCode == 200) {
        loading = false;
        profileModel = ProfileModel.fromJson(datas);
      print(profileModel.user!.name.toString());
  return profileModel;
      } else {
        loading = false;
        notifyListeners();

        SnackBars.showSnackBar(
            context: context,
            content: 'SomeThing is wrong',
            durationSec: 3,
            success: false,
            routeAction: null);
      }
    }else{
      SnackBars.showSnackBar(
          context: context,
          content: 'Check internet connection',
          durationSec: 3,
          success: false,
          routeAction: null);
    }
    return profileModel;
  }
}