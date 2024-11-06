/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/ProjectResource.dart';
import '../helpers/snackbars.dart';
import '../services/shared_preference.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../views/Dashboard/dashboard.dart';

class LoginController extends ChangeNotifier {
  bool loading = false;
  bool loadingError = false;
  bool passwordVisible = true;
  TextEditingController emailController = TextEditingController();
  FocusNode emailControllerNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordControllerNode = FocusNode();
  late String token;
  late String userID;

  String? name;
  String? message;
  String? usertype;
  String? userImage;
  static String loginUserEmail="";
  late int statusCodes;
  late Map mapResponse;
  late Map dataResponse;
  passVisibleChange() {
    passwordVisible = !passwordVisible;
    print(passwordVisible);
    notifyListeners();
  }

  clear() {

    passwordVisible = true;
    emailController.clear();
    passwordController.clear();
    //emailController.text = "user2@gmail.com";
    //emailController.text = "jonuser@gmail.com";
    //emailController.text = "testuser@surefix_ai.com";
    //emailController.text = "mohamed@imechanic.com";
    //emailController.text = "technician1@gmail.com";
    //passwordController.text = "Technician1@123";
    //passwordController.text = "12345678";
    //emailController.text = "";
    //passwordController.text = "";
  }


  userLogin({context}) async {
    loading = true;
    notifyListeners();
    bool internetOn = await ProjectResource.internetConnection();
    if(internetOn){
      var response = await http.post(Uri.parse(ApiEnd.imechLoginUrlfull),
          body: {
            "email": emailController.text.toString(),
            "password": passwordController.text.toString(),
          });
      print(response.statusCode);
      print('login Screen');
      if (response.statusCode == 200) {

        loadingError = false;
        mapResponse = json.decode(response.body);
        dataResponse =mapResponse['data'];
        token = dataResponse['token'];
        usertype = dataResponse['type'];
        userID = dataResponse['id'].toString();
        name = dataResponse['name'];
        userImage = dataResponse['userImage'];
        message = mapResponse['data']["error"];
        loginUserEmail = emailController.text.toString();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('usertype', usertype!);
        prefs.setString('userid', userID);
        prefs.setString('name', name!);
        SharedPreferences sp =await SharedPreferences.getInstance();
        sp.setString('tokenSP',token);
        sp.setString('userImage',userImage!);
        sp.setString('UserEmail', emailController.text.toString());
       // print('Image: ${userImage.toString()}');
        if (usertype.toString() == 'mechanic') {
          ProjectResource.showToast(
              "Signed In successfully!".toString().toUpperCase(),
              false, 'willpop');
          print(token.toString());
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              Dashboard()), (Route<dynamic> route) => false);


        } else {
          ProjectResource.showToast(
              "Signed In successfully!".toString().toUpperCase(),
              false,
              'willpop');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const Dashboard()), (Route<dynamic> route) => false);

        }
      }else{
        notifyListeners();
        loading = false;
        SnackBars.showSnackBar(
            context: context,
            content: "Incorrect Username or Password Entered or Please Contact with Admin for Approval",
            durationSec: 2,
            success: false,
            routeAction: null);
      }

    } else {
      notifyListeners();
      loading = false;
      SnackBars.showSnackBar(
          context: context,
          content: "Check internet connection",
          durationSec: 2,
          success: false,
          routeAction: null);
    }

  }
}
