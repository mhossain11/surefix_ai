// import 'package:surefix_ai/utils/api_urls.dart';
// import 'package:surefix_ai/utils/colors.dart';
// import 'package:surefix_ai/views/Auth/login/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:surefix_ai/webview_flutter.dart';
//
// import '../utils/images.dart';
// import 'auth/register/register_general_info.dart';
//
//
// class WebViewPage extends StatefulWidget {
//   @override
//   _WebViewPageState createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _webViewController;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool _loading = true;
//   @override
//   void initState() {
//     super.initState();
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {
//             _loading = true;
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               _loading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onUrlChange: (UrlChange url) {
//             // Check if the loaded URL matches the one you want to intercept
//             if (url.url!.contains('/User/Login')) {
//               // Navigate to a new route when the specific URL is loaded
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => LoginScreen(), // Replace with your route
//               ));
//             }else if (url.url!.contains('/User/Registration')) {
//               // Navigate to a new route when the specific URL is loaded
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => RegisterGeneralInfoScreen(), // Replace with your route
//               ));
//             }
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.contains('/User/Login')) {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => LoginScreen(), // Replace with your route
//               ));
//               return NavigationDecision.prevent;
//             }else if (request.url.contains('/User/Registration')) {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => RegisterGeneralInfoScreen(), // Replace with your route
//               ));
//               return NavigationDecision.prevent;
//             } else {
//               return NavigationDecision.navigate;
//             }
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(ApiEnd.baseUrl));
//   }
//
//   // Function to handle the back button press
//   Future<bool> _handleBack() async {
//     if (await _webViewController.canGoBack()) {
//       // Navigate back in the WebView's history
//        _webViewController.goBack();
//       return Future.value(true);// Consumes the back button press
//     } else {
//       // No more pages in the WebView's history
//       // You can handle this case as needed (e.g., show a dialog, exit the app)
//       //ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Incremented"), duration: Duration(milliseconds: 300), ), );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No more pages to go back.'),
//           duration: Duration(seconds: 2),
//           action: SnackBarAction(label: "EXIT APP",onPressed: (){
//             SystemNavigator.pop();
//           },),
//         ),
//       );
//       return Future.value(false); // Allows the back button press to exit the app
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset(Images.appLogo, height: 120,width: 140,),
//         leading: BackButton(),
//         elevation: 0,
//         centerTitle: true,
//         foregroundColor: colorTheme,
//         actions: [
//           IconButton(onPressed: (){
//             // Reload the WebView
//             _webViewController.reload();
//             _loading = true;
//             setState(() {
//
//             });
//           }, icon: Icon(Icons.refresh))
//         ],
//       ),
//       body: WillPopScope(
//           onWillPop: _handleBack,
//           child: Stack(
//             children: [
//               // SizedBox(height: 15,),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: WebViewWidget(controller: _webViewController),
//               ),
//               if (_loading)
//                 LinearProgressIndicator(
//                   backgroundColor: Colors.grey,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                 ),
//             ],
//           )),
//
//     );
//   }
// }
