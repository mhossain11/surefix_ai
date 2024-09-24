

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:surefix_ai/models/bannerModel.dart';
import 'package:surefix_ai/models/notificationmodel.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/ProjectResource.dart';
import '../helpers/dialogs.dart';
import '../helpers/restartWidget.dart';
import '../helpers/snackbars.dart';
import '../models/mechanicregisterModel.dart';
import '../models/multidropdownModel.dart';
import '../models/usernameModel.dart';
import '../services/network_manager.dart';
import '../utils/api_urls.dart';


class  NotificationController extends ChangeNotifier {
  late String token;
  late int statusCodes;
  NotificationModel notificationModel = NotificationModel();

  bool loading = false;


  Future<NotificationModel> notificationData({context, token}) async {
    loading = true;

    SharedPreferences sp = await SharedPreferences.getInstance();
    bool internetOn = await ProjectResource.internetConnection();
    var user = sp.getString('usertype');
    var usertoken = sp.getString('tokenSP');
    if (internetOn) {
      var response = await http.get(Uri.parse(ApiEnd.notificationGetUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $usertoken',
          });
      // print('Token : $token');
      print('Data show');
      var datas = jsonDecode(response.body.toString());
      try {
        if (response.statusCode == 200) {
          loading = false;
          notifyListeners();
          // print(response.body.toString());
          notificationModel = NotificationModel.fromJson(datas);
          //bannerList.add(bannerModel.success!.allnotification!);
          print(notificationModel.toString());
          return notificationModel;
        } else {
          loading = false;
          notifyListeners();
          SnackBars.showSnackBar(
              context: context,
              content: 'Internet error',
              durationSec: 3,
              success: false,
              routeAction: null);
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      SnackBars.showSnackBar(
          context: context,
          content: 'Check internet connection',
          durationSec: 3,
          success: false,
          routeAction: null);
    }

    notifyListeners();
    return notificationModel;
  }


}
