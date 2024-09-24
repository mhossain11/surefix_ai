/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../helpers/dialogs.dart';
import '../helpers/restartWidget.dart';
import '../helpers/snackbars.dart';
import '../services/network_manager.dart';
import '../utils/api_urls.dart';
class RegisterController extends ChangeNotifier {
  late String token;
  late int statusCodes;

  bool loading = false;
  bool loadingOTP = false;
  bool loadingOTPError = false;
  bool loadingOTPVerify = false;
  bool loadingOTPVerifyError = false;
  bool loadingPasswordSetup = false;
  bool loadingPasswordSetupError = false;
  bool loadingDivision = false;
  bool loadingDivisionError = false;
  bool loadingDistrict = false;
  bool loadingDistrictError = false;
  bool loadingZipCode = false;
  bool loadingZipCodeError = false;
  bool loadingAccount = false;
  bool loadingAccountError = false;
  bool passwordVisible = true;
  bool passwordRetypeVisible = true;

  TextEditingController phoneController = TextEditingController();

  TextEditingController otpController = TextEditingController();
  String otpCode = "";

  late String? appSignature;
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordControllerNode = FocusNode();
  TextEditingController passwordRetypeController = TextEditingController();
  FocusNode passwordRetypeControllerNode = FocusNode();

  //mechanicRegister
  TextEditingController  mechanicNameController = TextEditingController();
   FocusNode mechanicNameControllerNode = FocusNode();
  TextEditingController  emailAddressController = TextEditingController();
  FocusNode emailAddressControllerNode = FocusNode();
  TextEditingController  passwordMechanicController = TextEditingController();
  FocusNode passwordMechanicControllerNode = FocusNode();
  TextEditingController  confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordControllerNode = FocusNode();
  TextEditingController  garageNameController = TextEditingController();
  FocusNode garageNameControllerNode = FocusNode();
  TextEditingController  garagePostCodeController = TextEditingController();
  FocusNode garagePostCodeControllerNode = FocusNode();
  TextEditingController  garageLocationController = TextEditingController();
  FocusNode garageLocationControllerNode = FocusNode();
  TextEditingController  experienceLevelController = TextEditingController();
  FocusNode experienceLevelControllerNode = FocusNode();
  TextEditingController  evidenceExperienceController = TextEditingController();
  FocusNode evidenceExperienceControllerNode = FocusNode();


  //General information screen
  TextEditingController firstNameController = TextEditingController();
  FocusNode firstNameControllerNode = FocusNode();
  TextEditingController lastNameController = TextEditingController();
  FocusNode lastNameControllerNode = FocusNode();
  TextEditingController addressLine1Controller = TextEditingController();
  FocusNode addressLine1ControllerNode = FocusNode();
  TextEditingController addressLine2Controller = TextEditingController();
  FocusNode addressLine2ControllerNode = FocusNode();
  TextEditingController postOfficeController = TextEditingController();
  FocusNode postOfficeControllerNode = FocusNode();
  TextEditingController zipCodeController = TextEditingController();
  FocusNode zipCodeControllerNode = FocusNode();
  TextEditingController sectionController = TextEditingController();
  FocusNode sectionControllerNode = FocusNode();
  TextEditingController roadController = TextEditingController();
  FocusNode roadControllerNode = FocusNode();
  TextEditingController houseController = TextEditingController();
  FocusNode houseControllerNode = FocusNode();
  TextEditingController nearByController = TextEditingController();
  FocusNode nearByControllerNode = FocusNode();
  TextEditingController houseNameController = TextEditingController();
  FocusNode houseNameControllerNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailControllerNode = FocusNode();
  bool resend = false;
   File? dpImage;
  //Phone screen
  initRegisterMobile() {
    phoneController.clear();
    loadingOTP = false;
    loadingOTPError = false;
    appSignature = null;
  }

  //OTP screen
  initRegisterOTP() {
    otpCode = '';
    loadingOTPVerify = false;
    loadingOTPVerifyError = false;
  }

  resendSwitch({required bool val}) {
    resend = val;
    notifyListeners();
  }


  //Password screen
  initRegisterPassword() {
    passwordController.clear();
    passwordRetypeController.clear();
    passwordVisible = true;
    passwordRetypeVisible = true;
    loadingPasswordSetup = false;
    loadingPasswordSetupError = false;
    notifyListeners();
  }

  //register info
  initRegisterGeneralInfo() {
    firstNameController.clear();
    lastNameController.clear();
    addressLine1Controller.clear();
    addressLine2Controller.clear();
    zipCodeController.clear();
    postOfficeController.clear();
    zipCodeController.clear();
    loadingDivision = false;
    loadingDivisionError = false;
    loadingDistrict = false;
    loadingDistrictError = false;
    loadingZipCode = false;
    loadingZipCodeError = false;
    loadingAccount = false;
    loadingAccountError = false;
  }

  passVisibleChange() {
    passwordVisible = !passwordVisible;
    print(passwordVisible);
    notifyListeners();
  }

  passRetypeVisibleChange() {
    passwordRetypeVisible = !passwordRetypeVisible;
    print(passwordRetypeVisible);
    notifyListeners();
  }
  performCreateAccount({context}) async {
    loadingAccount = true;
    notifyListeners();

    var response = await http.post(Uri.parse(ApiEnd.imechUserRegistationUrlfull),
        body: {
          'name': firstNameController.text.toString(),
          'email': emailController.text.toString(),
          'password': passwordController.text.toString(),
          'confirm_password': passwordRetypeController.text.toString(),
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      loadingAccount = false;
      // print('Response Body: ${await response.stream.bytesToString()}');
      // String body = await response.stream.bytesToString();
      AnimatedDialogs.successDialog(context,
          title: "Registration",
          subtitle: "Registration Successful",
          buttonText: "Ok",
          onResponse: () {
            RestartWidget.restartApp(context);
          });
    } else {
      print('Response Status Code: ${response.statusCode}');
      print('Response Reason Phrase: ${response.reasonPhrase}');
      loadingAccount = false;
      loadingAccountError = true;
      SnackBars.showSnackBar(
          context: context,
          content: "Something went wrong",
          durationSec: 3,
          success: false,
          routeAction: null);
    }
    notifyListeners();
  }


}
