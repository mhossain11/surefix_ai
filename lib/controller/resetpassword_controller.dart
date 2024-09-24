/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surefix_ai/views/Auth/login/login.dart';

import '../helpers/ProjectResource.dart';
import '../helpers/snackbars.dart';
import '../services/shared_preference.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../views/Auth/passwordRecovery/pincode_verify_screen.dart';
import '../views/Dashboard/dashboard.dart';

class ResetPasswordController extends ChangeNotifier {
  bool loading = false;
  bool loadingError = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  var datarespons;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  clear() {
    passwordController.clear();
    confirmPasswordController.clear();
  }



  resetPassword({context}) async {
    loading = true;
    notifyListeners();
    print(passwordController.text.toString());
    print(confirmPasswordController.text.toString());
    SharedPreferences sp = await SharedPreferences.getInstance();
    var email =sp.getString('emailReset');

    var response = await http.post(Uri.parse(ApiEnd.resetPasswordPostUrl),
        body: {
          "password":passwordController.text.toString(),
          "password_confirmation":confirmPasswordController.text.toString(),
          "email":email.toString()
        });
    print(response.statusCode);
    datarespons =json.decode(response.body.toString());
    if (response.statusCode == 200) {

      loading = false;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    } else {
      loading = false;
      notifyListeners();
      SnackBars.showSnackBar(
          context: context,
          content: datarespons['message'].toString(),
          //content: "Incorrect password, Please check again!!!",
          durationSec: 3,
          success: false,
          routeAction: null
      );
    }
    notifyListeners();
  }

/*  performCreateAccount({context}) async {
    loading = true;
    notifyListeners();

    var response = await http.post(Uri.parse(ApiEnd.resetPasswordPostUrl),
        body: {
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        });
    if (response.statusCode == 200) {
      loadingError = false;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    } else {
      notifyListeners();
      loading = false;
      SnackBars.showSnackBar(
          context: context,
          content: "Incorrect password, Please check again!!!",
          durationSec: 3,
          success: false,
          routeAction: null);
    }

  }*/
}
