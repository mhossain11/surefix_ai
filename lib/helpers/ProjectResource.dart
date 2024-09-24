/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surefix_ai/helpers/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/userModel.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;

// ignore: file_names
class ProjectResource {
  static GlobalKey<NavigatorState>? navigatorKey;

  static String baseUrl = ""; // Live

  static double screenWidth = 0;
  static double screenHeight = 0;
  static BuildContext? currentContext;
  static BuildContext? loaderContext;

  static UserModel? userDataGlobal;
  static String? token;
  static bool showOnBoard = false;
  static Map<String, dynamic> settings = {
    'language': 'bn',
    'currency': 'BDT',
    'balance': 0,
    'is_online': 0,
    'showOnBoarding': false,
    'loggedIn': false,
    'user': null
  };
  static bool loggedIn = false;
  static int isOnline = 0;
  static int accountStatus = 0; //0-under review //1-approved //2-suspended
  // static DataUser userDataGlobal;
  //
  // static List<Languages> languages = [
  //   Languages(language: "Bangla", languageCode: 'bn'),
  //   Languages(language: "English", languageCode: 'en')
  // ];

  static List<String> currencies = ['BDT'];

  //static Languages selectedLanguage = languages[0];
  static String selectedCurrency = currencies[0];

  static dynamic notificationData;

  static FontWeight fontSemiBold = FontWeight.w500;
  static double? bodyFontSize;
  static double? headerFontSize;
  static double? appBarFontSize;
  static double? dialogBoxFontSize;

  static Lock lock = Lock();

  //static List<CategoryData> drawerCategoryList = List();

  static int cartElementCount = 0;
//  static User currentValidUser;
//  static List<ItemModel> items=[];

  static var pagePadding;
  // static DrawerMenu drawer = DrawerMenu();

  static var deviceModel;
  static var systemOS;

  static var pageState;

  static Color fontColors = Colors.black54;
  static Color h3FontColors = Colors.black38;
  static Color h4FontColors = Colors.black12;
  static Color h2FontColors = Colors.black;
  static Color hFontColors = Colors.lightGreenAccent;
  static Color iconColors = Colors.pinkAccent;
  static Color bodyColors = Colors.white;
  static bool mode = true;

  static Color statusBarColor = Colors.transparent;
  static int currentActivePosition = 0;

  static void statusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: Brightness.dark));
  }

  static CrossAxisAlignment alignmentLang = CrossAxisAlignment.start;
  static MainAxisAlignment alignmentMainLang = MainAxisAlignment.start;
  static Alignment alignLang = Alignment.center;
  static TextAlign textAlignLang = TextAlign.left;
  static TextDirection textDirection = TextDirection.ltr;

  static void setScreenSize(BuildContext context, [var state]) {
    if (ModalRoute.of(context)!.isCurrent) {
      currentContext = context;
      //pageState = state;
    }

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    pagePadding = EdgeInsets.only(
        top: 5, left: screenWidth * 0.04, right: screenWidth * 0.04);
    screenHeight = screenWidth < screenHeight
        ? screenHeight
        : (screenWidth / screenHeight) * screenWidth;
    bodyFontSize = screenWidth * 0.035;
    headerFontSize = screenWidth * 0.04;
    appBarFontSize = screenWidth * 0.05;
    dialogBoxFontSize = screenWidth * 0.03;
    alignmentLang = CrossAxisAlignment.start;
    alignmentMainLang = MainAxisAlignment.start;
    alignLang = Alignment.centerLeft;
    textAlignLang = TextAlign.left;
    textDirection = TextDirection.ltr;
  }

  static DateTime? currentBackPressTime;
  static Future<bool> onWillPop({required BuildContext context}) {
    DateTime now = DateTime.now();

    if (Platform.isIOS) {
      print("IOS platform");
      return Future.value(false);
    } else {
      print("Android platform");
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        ProjectResource.showToast("Press again to Exit", true, "willpop");
        return Future.value(false);
      }
      SystemNavigator.pop();
      return Future.value(true);
    }
  }

  static Future<bool> onWillPopBack() {

    if (Platform.isIOS) {
      print("IOS platform");
      return Future.value(false);
    } else {
      print("Android platform");
      return Future.value(true);
    }
  }

  static Future<bool> onWillPopToHome() {

    if (Platform.isIOS) {
      print("IOS platform");
      return Future.value(false);
    } else {
      print("Android platform");
      //  Navigator.of(currentContext).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MenuCategory()), (Route<dynamic> route) => false);
      return Future.value(true);
    }
  }

  //Result Not Found View

  static notFoundView() {
    var margin = SizedBox(
      height: 10,
    );
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/error.png",
            scale: 6,
          ),
          margin,
          const Text(
            "No Result Found",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black, fontSize: 20),
            textAlign: TextAlign.justify,
          ),
          margin,
          const Text(
            "We can't find any item matching your search",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black54,
                fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  static getImageView(
      {required BuildContext context, required String imgUrl, required Alignment alignments, required bool isUrl}) {
    return showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return SafeArea(child:
            StatefulBuilder(// You need this, notice the parameters below:
                builder: (BuildContext context, StateSetter setState) {
          return Material(
            child: Container(
              height: ProjectResource.screenHeight,
              width: ProjectResource.screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  InteractiveViewer(
                    child: isUrl
                        ? CachedNetworkImage(
                            imageUrl: imgUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.contain),
                              ),
                            ),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                                height: ProjectResource.screenHeight * .3,
                                child:
                                    const Center(child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) => Container(
                                height: ProjectResource.screenHeight * .3,
                                child: const Center(child: Icon(Icons.error))),
                          )
                        : Image.file(
                            File(imgUrl),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      top: 13,
                      left: 10,
                      child: ProjectResource.getBackButton(context))
                ],
              ),
            ),
          );
        }));
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          alignment: alignments ?? Alignment.center,
          child: child,
        );
      },
    );
  }

  static getBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
          child: Icon(Icons.arrow_back_ios_rounded),
          onTap: () {
            Navigator.pop(context);
          }),
    );
  }

  static showToast(String text, bool isError, [String? gravity]) {
    Color textColor = white;
    Color backColor = teal;
    ToastContext().init(ProjectResource.currentContext!);
    if (isError) {
      textColor = white;
      backColor = red;
    }
    if (gravity == "top") {
      Toast.show(text,
          duration: 2,
          gravity: Toast.top,
          backgroundColor: backColor,
          webTexColor: textColor);
    }
    if (gravity == "center") {
      Toast.show(text,
          duration: 2,
          gravity: Toast.center,
          backgroundColor: backColor,
          webTexColor: textColor);
    } else if (gravity == "willpop") {
      Toast.show(
        text,
        duration: 2,
        gravity: Toast.bottom,
        backgroundColor: Colors.black54,
        webTexColor: Colors.white,
      );
    } else if (gravity == "switch") {
      Toast.show(
        text,
        duration: 2,
        gravity: Toast.center,
        backgroundColor: Colors.black54,
        webTexColor: Colors.white,
      );
    } else {
      Toast.show(
        text,
        duration: 2,
        gravity: Toast.center,
        backgroundColor: Colors.black54,
        webTexColor: Colors.white,
      );
    }
  }

  static launchURL(String _url) async {

   final Uri url = Uri.parse(_url);
   print(url.toString());
   if (!await launchUrl(url)) {
     throw Exception('Could not launch $_url');
   }
  }

  static checkInternet() async {
    var internetStatus = true;
    var serverStatus = true;

    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 15));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internetStatus = true;
        print('connected');
      }
    } on SocketException catch (_) {
      print(_);
      internetStatus = false;
    } on TimeoutException catch (_) {
      internetStatus = false;
    }
    if (internetStatus == true) {
      return 'all_connected';
    } else if (internetStatus == false) {
      return "no_internet";
    }
  }

  static internetConnection() async {
    try {
      //final result = await InternetAddress.lookup('www.google.com');
      final result = await http.get(Uri.parse('https://www.google.com'));
      print(result);
      if(result.statusCode==200){
        return true;
      }
      else{
        return false;
      }
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   return true;
      // } else {
      //   return false;
      // }
    } on SocketException catch (_) {
      return false;
    }
  }

  // Blocking ios swipe back
  static bool willPopAction() {
    if (Platform.isIOS) {
      return false;
    } else {
      return true;
    }
  }
}

class Lock {
  bool _isLocked = false;

  void lock() {
    _isLocked = true;
  }

  void release() {
    _isLocked = false;
  }

  bool isLocked() {
    return _isLocked;
  }
}
