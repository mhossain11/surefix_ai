/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:surefix_ai/helpers/dialogs.dart';
import 'package:surefix_ai/helpers/restartWidget.dart';
import 'package:surefix_ai/helpers/snackbars.dart';
import 'package:surefix_ai/utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../helpers/ProjectResource.dart';
import '../models/usernameModel.dart';
import '../models/userregisterModel.dart';
import '../views/Auth/login/login.dart';
import '../views/Auth/register/registerpage.dart';



class UserRegisterController extends ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();
  final TextEditingController conformPasswordController = TextEditingController();
  File? profileImage;
  List<String>nameList=[];
  var datasearch='';

  UserRegisterModel userRegisterModel =UserRegisterModel();
  UsernameModel usernameModel = UsernameModel();

  late String token;
  late int statusCodes;
  bool loading = false;

  clear(){
    profileImage= null;
  }


  FocusNode passwordControllerNode = FocusNode();
  TextEditingController passwordRetypeController = TextEditingController();
  FocusNode passwordRetypeControllerNode = FocusNode();



  //General information screen
  TextEditingController firstNameController = TextEditingController();
  FocusNode firstNameControllerNode = FocusNode();




  Future<void>userCreateAccount({context}) async {
    loading = true;
    notifyListeners();
    bool internetOn = await ProjectResource.internetConnection();
    if(internetOn){
      var headers= {
        'Connection': 'keep-alive',
        'Accept': '*/*',
        'Accept-Encoding':'gzip, deflate, br'
      };
      var request =http.MultipartRequest('POST', Uri.parse(ApiEnd.imechUserRegistationUrlfull));
      request.fields.addAll(
          {
            'email':emailAddressController.text.toString(),
            'password':passwordController.text.toString(),
            'confirm_password':conformPasswordController.text.toString(),
            'name':fullNameController.text.toString(),
            'mobile':numberController.text.toString() ,
            'userName':userNameController.text.toString(),
          }
      );

      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'userImage',profileImage!.path.toString(),));
      }
      // request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print('yes: ${response.statusCode.toString()}');
      print('profileImage:${profileImage?.path.toString()}');
      print('email:${emailAddressController.text.toString()}');
      print('password:${passwordController.text.toString()}');
      print('conformPassword:${conformPasswordController.text.toString()}');
      print('fullName:${fullNameController.text.toString()}');
      print('userName:${userNameController.text.toString()}');
      print('number:${numberController.text.toString()}');
      if (response.statusCode == 200) {
        loading = false;
        print('UserRegisterController_userCreateAccount Data Uploaded');
        AnimatedDialogs.successDialog(context,
            title: "Registration",
            subtitle: "Registration Complete,you will receive an email once access has been approved",
            buttonText: "Ok",
            onResponse: () {
              //RestartWidget.restartApp(context);
              Navigator.pop(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
            });

      }else{
        notifyListeners();
        loading = false;
        SnackBars.showSnackBar(
            context: context,
            content: "Something went wrong",
            durationSec: 3,
            success: false,
            routeAction: null);
      }

    } else {
      notifyListeners();
      loading = false;
      SnackBars.showSnackBar(
          context: context,
          content: "Check internet connection",
          durationSec: 3,
          success: false,
          routeAction: null);
    }

  }



  Future<UserRegisterModel>userRegister({context}) async {
    loading =false;
    notifyListeners();
    var headers= {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Accept-Encoding':'gzip, deflate, br'
    };
    var request =http.MultipartRequest('POST', Uri.parse(ApiEnd.imechUserRegistationUrlfull));
    request.fields.addAll(
        {
          'email':emailAddressController.text.toString(),
          'password':passwordController.text.toString(),
          'confirm_password':conformPasswordController.text.toString(),
          'name':fullNameController.text.toString(),
          'mobile':numberController.text.toString() ,
          'userName':userNameController.text.toString(),
        }
    );

    final profileImage = this.profileImage;
    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'userImage',profileImage.path.toString(),));
    }
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var result = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      loading = false;
      print('UserRegisterController_userRegister Data Uploaded');
      userRegisterModel = UserRegisterModel.fromJson(result);
      AnimatedDialogs.successDialog(context,
          title: "Registration",
          subtitle: "Registration Complete,you will receive an email once access has been approved",
          buttonText: "Ok",
          onResponse: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterPage()));
          });
      return userRegisterModel;
    } else {
      loading = false;
      SnackBars.showSnackBar(
          context: context,
          content: "Something went wrong",
          durationSec: 3,
          success: false,
          routeAction: null);
    }
    return userRegisterModel;

  }

  Future<UsernameModel>userNameList({context}) async {
    print('nameStart');

    var response = await http.get(Uri.parse(ApiEnd.usernamelist),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Connection':'keep-alive',
          'Accept-Encoding':'gzip, deflate, br',
          'Authorization': 'Bearer 118|qtTBufTzwKH5va62GwoDP7n83q0Bse21DqXx2NEdca41a0fa',
        });
    // print('Token : $token');
    print('Data show');
    var datas = jsonDecode(response.body.toString());
    loading = false;
    if(response.statusCode == 200){
      loading = false;
      print('UserRegisterController_userNameList Data Uploaded');

      usernameModel  = UsernameModel.fromJson(datas);
      nameList.clear();
      for(int i=0;i<usernameModel.data!.userName!.length;i++){
        var name = usernameModel.data!.userName![i].name;
        nameList.add(name.toString());
      }

      return usernameModel;

    }else{
      loading = false;
      throw SnackBars.showSnackBar(
          context: context,
          content: 'Name not exist',
          durationSec: 3,
          success: false,
          routeAction: null);

    }
  }






}



