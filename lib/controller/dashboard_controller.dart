

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:surefix_ai/models/bannerModel.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/dialogs.dart';
import '../helpers/restartWidget.dart';
import '../helpers/snackbars.dart';
import '../models/mechanicregisterModel.dart';
import '../models/multidropdownModel.dart';
import '../models/usernameModel.dart';
import '../services/network_manager.dart';
import '../utils/api_urls.dart';


class   DashBoardController extends ChangeNotifier {
  late String token;
  late int statusCodes;
  BannerModel  bannerModel = BannerModel();
  bool loading = false;




  Future<BannerModel>bannerData({context,String? token}) async {
    loading = true;

    var response = await http.get(Uri.parse(ApiEnd.noticeGetUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });


    var datas = jsonDecode(response.body.toString());


   try{
     if(response.statusCode == 200){
       loading = false;
       bannerModel  = BannerModel.fromJson(datas);

     }else{
       loading = false;
       SnackBars.showSnackBar(
           context: context,
           content: bannerModel.message.toString(),
           durationSec: 3,
           success: false,
           routeAction: null);
     }
   }catch(e){
     throw SnackBars.showSnackBar(
         context: context,
         content: e.toString(),
         durationSec: 3,
         success: false,
         routeAction: null);
   }
    return bannerModel;
    }


  }



