
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/ProjectResource.dart';
import '../helpers/dialogs.dart';
import '../helpers/snackbars.dart';
import '../models/createrequestModssel.dart';
import '../models/registrationNumberModel.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../views/iMech_screen/requestDetails.dart';


class RequestController extends ChangeNotifier {
  bool loading = false;
  bool loadingCreate = false;
  bool loadingAdmin = false;
  bool loadingError = false;
  String? token;
  int? statusCodes;
  ChatgtpResponseModel allChatGPTDataModel=ChatgtpResponseModel();

  File? documentsImage;
  final List<String> selectedOption = [];

  RegistrationNumberModel registrationNumberModel = RegistrationNumberModel();

  clear() {
    loading = false;
    loadingError = false;
    documentsImage = null ;
  }

  clearUpload() {

     loadingCreate = false;
     loadingAdmin = false;
     notifyListeners();
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
  selectFileByCamera() async{
    final result = await ImagePicker().pickImage(source: ImageSource.camera);

    if (result != null) {
      documentsImage = File(result.path);
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


  Future<ChatgtpResponseModel> getChatGPTData({context,registrationController,usernameController, descriptionController, titleController, makeController, modelController,
    yearController,faultController,dropdownValue}) async{
    loading = true;
    notifyListeners();
    SharedPreferences sp =await SharedPreferences.getInstance();
    bool internetOn = await ProjectResource.internetConnection();
    if(internetOn){
      var user = sp.getString('usertype');
      var tokensd  = sp.getString('tokenSP');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokensd',
      };
      var request = http.MultipartRequest('POST', Uri.parse(ApiEnd.imechCreateRequestUrlfull));
      request.fields.addAll({
        'title':titleController.text,
        'description':descriptionController.text,
        'faultCode':faultController.text,
        'model':modelController.text,
        'make':makeController.text,
        'yearofmake':yearController.text,
        'commenttochatgpt': descriptionController.text,
        'registrationnumber': registrationController.text
      });

      request.headers.addAll(headers);
      if (documentsImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'requestFile', documentsImage!.path.toString()));
      }

      http.StreamedResponse response = await request.send();
      var result= await response.stream.bytesToString();
      print('title: ${titleController.text.toString()}');
      print('description:${descriptionController.text.toString()}');
      print('faultCode:${faultController.text.toString()}');
      print('model:${modelController.text.toString()}');
      print('yearofmake:${yearController.text.toString()}');
      print('commenttochatgpt:${descriptionController.text.toString()}');
      print('registrationnumber:${registrationController.text.toString()}');
      print('requestFile:${documentsImage?.path.toString()}');
      print('request click 1');
      print(response.statusCode);
      var data = json.decode(result);
      if (response.statusCode == 200) {
        notifyListeners();
        loading = false;

        print('chatgpt data');
        allChatGPTDataModel = ChatgtpResponseModel.fromJson(data);
        /*ProjectResource.showToast(
          "Save successfully!".toString().toUpperCase(),
          false,
          'center');*/
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  RequestDetails(requestId: data["success"]["alldata"][0]["postId"].toString(),
          descriptionData:data["success"]["description"].toString() , nameData: data["success"]["title"].toString(), make: data["success"]["alldata"][0]["make"].toString(), model: data["success"]["alldata"][0]["model"].toString(), year: data["success"]["alldata"][0]["yearofmake"].toString(),)));

        return allChatGPTDataModel;
      }
      else {
        print('request click 2');
        notifyListeners();
        loading = false;
        AnimatedDialogs.successDialog(context,
            title: "Save Failed",
            subtitle: 'message.toString()',
            buttonText: "Ok",
            onResponse: () {
              //RestartWidget.restartApp(context);
              Navigator.pop(context);

            });
      }
    }else{
      SnackBars.showSnackBar(
          context: context,
          content: 'Check internet connection',
          durationSec: 3,
          success: false,
          routeAction: null);
    }

   // notifyListeners();
    return allChatGPTDataModel;




  }

  Future<RegistrationNumberModel>registrationNumberData({context}) async {
    print('nameStart');

  /*  var response = await http.get(Uri.parse(ApiEnd.registationNumberlist+textController.text),
        headers: {
          'Content-Type': 'application/json',
        });

    print('Data show');
    var datas = jsonDecode(response.body.toString());
    loading = false;

    if(response.statusCode == 200){
      loading = true;
      print(response.body.toString());

      registrationNumberModel  = RegistrationNumberModel.fromJson(datas);
      print('Data Uploaded');
      print('nameEnd');
      return registrationNumberModel;

    }else{
      loading = false;
      loading = true;

      throw SnackBars.showSnackBar(
          context: context,
          content: 'Name not exist',
          durationSec: 3,
          success: false,
          routeAction: null);

    }*/
    return registrationNumberModel;
  }




}
