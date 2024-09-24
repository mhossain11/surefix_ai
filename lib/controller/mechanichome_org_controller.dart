/*
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import '../helpers/ProjectResource.dart';
import '../helpers/snackbars.dart';
import '../models/DashModel.dart';
import '../services/network_manager.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;


class MechanicOrgHomeController extends ChangeNotifier {
  bool loading = false;
  bool loadingError = false;
  late var data;
  TextEditingController searchController = TextEditingController();
  // List<SubscriptionListData> subscriptionList = [];
  late String token;
  late int statusCodes;
  DashModel? dashboardModeldata;
  //Organization selectedOrganization;


  clear() {
    var bool = loading = false;
    loadingError = false;
    dashboardModeldata = null;
  }

  initRegister() {
    searchController.clear();
  }


  Future<DashModel>getDataFromApis({context})async{
    print("Start");
    // print(token);
    // your endpoint and request method


    var data = await http.get(Uri.parse(ApiEnd.imechRequestGetUrlfull),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer 371|QPn8DTfZxmllHf619uvHEC5vCZhl7SQZczf5mMos3a925701',
        });
    // print('Token : $token');
    print(data);
    var datarespons =json.decode(data.body.toString());
    loading = false;
    if(data.statusCode == 200){
      loadingError = false;
      print('Data Uploaded');

      return DashModel.fromJson(datarespons);

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

}
*/
