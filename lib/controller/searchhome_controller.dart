import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/ProjectResource.dart';
import '../helpers/snackbars.dart';
import '../models/DashModel.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

class SearchHomeController extends ChangeNotifier {
  bool loading = false;
  bool loadingError = false;
  late var data;
  TextEditingController searchController = TextEditingController();
  late int statusCodes;
  late DashModel dashboardModel = DashModel();
  List<Requests> allDataList = [];

  clear() {
    loadingError = false;
  }

  initRegister() {
    searchController.clear();
  }

  Future<DashModel> getOrgDashboardData({context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool internetOn = await ProjectResource.internetConnection();

    if(internetOn){
      var tokensd = sp.getString('tokenSP');

      var data = await http.get(Uri.parse(ApiEnd.allpostsurl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokensd',
      });

      var datarespons = json.decode(data.body.toString());
      loading = false;
      print(data.statusCode);
      print('SearchAllPost');
      if (data.statusCode == 200) {
        loadingError = false;
        dashboardModel = DashModel.fromJson(datarespons);
        allDataList.clear();
        for (var data in dashboardModel.data!.requests!) {
          final dbRequestData = Requests.fromJson(data);
          allDataList.add(dbRequestData);

        }
        return dashboardModel;
      } else {
        loading = false;
        loadingError = true;
        notifyListeners();

         SnackBars.showSnackBar(
            context: context,
            content: datarespons['message'].toString().toUpperCase(),
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
    return dashboardModel;
  }
}
