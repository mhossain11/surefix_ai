import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/ProjectResource.dart';
import 'package:http/http.dart'as http;

import '../helpers/dialogs.dart';
import '../helpers/snackbars.dart';
import '../models/profilemodel.dart';
import '../models/updateprofileModel.dart';
import '../utils/api_urls.dart';
import '../views/iMech_screen/requestDetails.dart';

class UpdateProfileController extends ChangeNotifier{
 bool loading = false;
 UpdateProfileModel updateProfileModel  = UpdateProfileModel();
 File? image;
 File? documentsImage;
 clear() {
   loading = false;
   documentsImage = null ;
 }

 selectFile() async{
   FilePickerResult? result = await FilePicker.platform.pickFiles();

   if (result != null) {
     documentsImage = File(result.files.single.path!);
     if (kDebugMode) {
       print(documentsImage?.path.toString());
     }
     notifyListeners();
   } else {
     // User canceled the picker
   }
 }
 deleteImage() async{
   if(documentsImage != null && await documentsImage!.exists()) {
     await documentsImage!.delete();
     documentsImage = null;
     notifyListeners();
   }
 }


 Future<void> updateProfileData({context,nameController,mobileController, passwordController}) async{
   loading = true;
   notifyListeners();
   SharedPreferences sp =await SharedPreferences.getInstance();
   bool internetOn = await ProjectResource.internetConnection();
   if(internetOn){
     var tokensd  = sp.getString('tokenSP');
     var headers = {
       'Content-Type': 'application/json',
       'Authorization': 'Bearer $tokensd',
     };
     var request = http.MultipartRequest('POST', Uri.parse(ApiEnd.updateProfile));
     request.fields.addAll({
       'name':nameController.text,
       'mobile':mobileController.text,
       'password':passwordController.text,
     });

     request.headers.addAll(headers);
     if (documentsImage != null) {
       request.files.add(await http.MultipartFile.fromPath(
           'userImage', documentsImage!.path.toString()));
     }

     http.StreamedResponse response = await request.send();
     var result= await response.stream.bytesToString();


     print('name: ${nameController.text.toString()}');
     print('mobile:${mobileController.text.toString()}');
     print('password:${passwordController.text.toString()}');
     print('userImage:${documentsImage?.path.toString()}');
     print(response.statusCode);


     var data = json.decode(result);
     if (response.statusCode == 200) {
       notifyListeners();
       loading = false;
       AnimatedDialogs.successDialog(context,
           title: "Save Failed",
           subtitle: '$data["success"]',
           buttonText: "Ok",
           onResponse: () {
             //RestartWidget.restartApp(context);
             Navigator.pop(context);

           });
     }
     else {
       print('request click 2');
       notifyListeners();
       loading = false;

     }
   }else{
     SnackBars.showSnackBar(
         context: context,
         content: 'Check internet connection',
         durationSec: 3,
         success: false,
         routeAction: null);
   }
 }
}