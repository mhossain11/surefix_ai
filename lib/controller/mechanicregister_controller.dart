

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';
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
import '../views/Auth/register/registerpage.dart';


class  MechanicRegisterController extends ChangeNotifier {
  late String token;
  late int statusCodes;

  bool loading = false;

  final MultiSelectController controller = MultiSelectController();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();
  final TextEditingController conformPasswordController = TextEditingController();
  final List<String> selectedOption = [];
  bool loadingAccounts = false;


  String dropdownValue ='';
  UsernameModel usernameModel = UsernameModel();
  List<String>nameList=[];
  File? image;
  File? profileImage;


  clear() {
    loading = false;
    image = null;
    profileImage=null;
  }





  Future<void>performCreateAccount({context}) async {
    loading = true;
    notifyListeners();
    bool internetOn = await ProjectResource.internetConnection();

   if(internetOn){
     var headers= {
       'Connection': 'keep-alive',
       'Accept': '*/*',
       'Accept-Encoding':'gzip, deflate, br'
     };
     var request =http.MultipartRequest('POST', Uri.parse(ApiEnd.imechmechanicRegisterUrlfull));
     request.fields.addAll(
         {
           'emailAddress':emailAddressController.text.toString(),
           'password':passwordController.text.toString(),
           'confirmPassword':conformPasswordController.text.toString(),
           'mechanic_fullname':fullNameController.text.toString(),
           'experienceLevel':dropdownValue.toString(),
           'statusId':'0',
           'mobile':numberController.text.toString() ,
           'userName':userNameController.text.toString(),

         });

     print('S1:${selectedOption.length.toString()}');
     print('S1:${selectedOption.toString()}');
     request.files.add(http.MultipartFile.fromString(
       'specialistmakes',selectedOption.toString(),
     ));


     if (image != null) {
       request.files.add(await http.MultipartFile.fromPath(
           'evidenceexperience', image!.path.toString()));
     }


     if (profileImage != null) {
       request.files.add(await http.MultipartFile.fromPath(
           'userImage', profileImage!.path.toString()));
     }
     http.StreamedResponse response = await request.send();


/*     print('yes: ${response.statusCode.toString()}');
     print('dropdownValue:${dropdownValue.toString()}');
     print('experienceImage:${image?.path.toString()}');
     print('profileImage:${profileImage?.path.toString()}');
     print('email:${emailAddressController.text.toString()}');
     print('password:${passwordController.text.toString()}');
     print('conformPassword:${conformPasswordController.text.toString()}');
     print('fullName:${fullNameController.text.toString()}');
     print('userName:${userNameController.text.toString()}');
     print('number:${numberController.text.toString()}');*/
     if (response.statusCode == 200) {
       loading = false;

       // mechanicRegisterModel = MechanicRegisterModel.fromJson(response);
       AnimatedDialogs.successDialog(context,
           title: "Registration",
           subtitle: "Registration Complete,you will receive an email once access has been approved",
           buttonText: "Ok",
           onResponse: () {
             // RestartWidget.restartApp(context);
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterPage()));
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

  Future<UsernameModel>userNameList({context}) async {
    SharedPreferences sp =await SharedPreferences.getInstance();
    var usertoken  = sp.getString('tokenSP');

    var response = await http.get(Uri.parse(ApiEnd.usernamelist),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Connection':'keep-alive',
          'Accept-Encoding':'gzip, deflate, br',
          'Authorization': 'Bearer $usertoken ',
        });

    print('Data show');
    var datas = jsonDecode(response.body.toString());
    loading = false;

    if(response.statusCode == 200){
      print(response.body.toString());


      print('lenth:${nameList.length}');
      usernameModel  = UsernameModel.fromJson(datas);
      nameList.clear();
      for(int i=0;i<usernameModel.data!.userName!.length;i++){
        var name = usernameModel.data!.userName![i].name;
        nameList.add(name.toString());
      }
      // nameList = jsonDecode(response.body.toString());
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
