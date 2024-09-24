
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surefix_ai/controller/dashboard_controller.dart';
import 'package:surefix_ai/controller/emailverify_controller.dart';
import 'package:surefix_ai/controller/mechanicregister_controller.dart';
import 'package:surefix_ai/controller/profile_controller.dart';
import 'package:surefix_ai/controller/userregister_controller.dart';
import 'package:surefix_ai/services/data/databasehelper.dart';
import 'package:surefix_ai/services/shared_preference.dart';
import 'package:surefix_ai/utils/app_theme.dart';
import 'package:surefix_ai/views/Dashboard/splashscreen.dart';
import 'package:surefix_ai/views/bottomNavPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controller/chatbox_controller.dart';
import 'controller/resetpassword_controller.dart';
import 'controller/searchhome_controller.dart';
import 'controller/sendpin_controller.dart';
import 'controller/viewownpost_controller.dart';
import 'controller/login_controller.dart';
import 'controller/mechanichome_org_controller.dart';
import 'controller/notification_controller.dart';
import 'controller/register_controller.dart';
import 'controller/requestDetailsController.dart';
import 'controller/request_controller.dart';
import 'helpers/ProjectResource.dart';
import 'helpers/restartWidget.dart';
import 'models/userModel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDB();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,

  ]);
  runApp(RestartWidget(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterController(),
        ),
        ChangeNotifierProvider(
          create: (_) => RequestController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchHomeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => MechanicRegisterController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchHomeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewOwnPostController(),
        )/*,ChangeNotifierProvider(
          create: (_) => MechanicOrgHomeController(),
        )*/,ChangeNotifierProvider(
          create: (_) => RequestDetailsController(),
        ),ChangeNotifierProvider(
          create: (_) => ChatBoxController(),
        ),ChangeNotifierProvider(
          create: (_) => UserRegisterController(),
        ),ChangeNotifierProvider(
          create: (_) => DashBoardController(),
        ),ChangeNotifierProvider(
          create: (_) => NotificationController(),
  ),ChangeNotifierProvider(
          create: (_) => EmailVerifyController(),
        ),ChangeNotifierProvider(
          create: (_) => SendPinCodeVerifyController(),
        ),ChangeNotifierProvider(
          create: (_) => ResetPasswordController(),
        ),ChangeNotifierProvider(
          create: (_) => ProfileController(),
        )
      ],
      // child: DevicePreview(
      //     enabled: !kReleaseMode,
      //   builder: (context) => MyApp()
      //
      // ),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    ProjectResource.navigatorKey = new GlobalKey<NavigatorState>();
    checkSettings();
    getCloudNotification();
    getDeviceInfo();
    super.initState();
  }

  checkSettings() {
    SharedPref.contain('settings').then((val) {
      if (val) {
        SharedPref.read('settings').then((val) {
          print(val);
          print(val['showOnBoard']);
          print(val['loggedIn']);
          print(val['language']);
          print(val['currency']);
          print(val['is_online']);

          setState(() {
            ProjectResource.settings = val;
            ProjectResource.showOnBoard = val['showOnBoarding'];
            ProjectResource.loggedIn = val['loggedIn'];
            ProjectResource.isOnline = val['is_online'];
            ProjectResource.selectedCurrency = val['currency'];

            if (val['user'] != null) {
              var userDatas = UserModel.fromJson(val['user']['data']);
              ProjectResource.token = val['user']['token'];
              ProjectResource.userDataGlobal = userDatas;

              ///---------user data log-----------//

              print(ProjectResource.userDataGlobal);
              print(ProjectResource.userDataGlobal?.userProfile?.frontEndUser?.email);
              print("ProjectResource.token");
            }
          });
          print(ProjectResource.settings);
        });
      } else {
        setState(() {
          // _languages = ProjectResource.selectedLanguage;
        });
      }
    });
  }

  getCloudNotification() {
    print("here push notification");
    try {
      // CloudMessagingHandler.firebaseCloudMessagingListeners(this, context);
    } catch (e) {
      print(e);
    }

  }

  getDeviceInfo() async {
    /* FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    var token = await firebaseMessaging.getToken();
    print('Ftoken: $token');
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        Provider.of<SignInController>(context, listen: false).postDeviceInfo(
            token: token,
            androidDeviceInfo: androidDeviceInfo,
            iosDeviceInfo: null,
            userId: ProjectResource.userDataGlobal?.id ?? 0);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        Provider.of<SignInController>(context, listen: false).postDeviceInfo(
            token: token,
            androidDeviceInfo: null,
            iosDeviceInfo: iosDeviceInfo,
            userId: ProjectResource.userDataGlobal?.id ?? 0);
      }
    } on PlatformException {
      print('Failed to get platform version.');
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'surefix_ai',
        navigatorKey: ProjectResource.navigatorKey,
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', ''),
        supportedLocales: const <Locale>[
          Locale('en', ''),
          //  Locale('bn', ''),
        ],
        theme: appTheme,
        // themeMode: ThemeMode.dark,
        // darkTheme: ThemeData.dark(),
        home:
        ProjectResource.loggedIn
            ?
        BottomNavPage()
            :
        const SplashScreen()
      //RegisterGeneralInfoScreen()

    );
  }
}
// Email: rukucse11@gmail.com
// Pass: 11Csesrant2019@