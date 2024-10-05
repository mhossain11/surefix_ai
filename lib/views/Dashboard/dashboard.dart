import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:surefix_ai/helpers/buttons.dart';
import 'package:surefix_ai/views/Dashboard/profilescreen.dart';
import 'package:surefix_ai/views/Dashboard/searchallpost.dart';
import 'package:surefix_ai/views/Dashboard/viewownpost.dart';
import 'package:surefix_ai/views/iMech_screen/termsscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/dashboard_controller.dart';
import '../../helpers/ProjectResource.dart';
import '../../models/bannerModel.dart';
import '../../services/route_manager.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../Auth/login/login.dart';
import '../iMech_screen/newpostRequest.dart';
import 'package:badges/badges.dart' as badges;
import '../iMech_screen/postfixscreen.dart';
import 'notificationscreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DashBoardController dashBoardController;
  late DashBoardController dashBoardControllerVar;
  String? userType;
  String? token;
  String? name;
  String? userImage;

  @override
  void initState() {
    super.initState();
    dashBoardController =
        Provider.of<DashBoardController>(context, listen: false);
    dashBoardControllerVar =
        Provider.of<DashBoardController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      shareData();
    });
  }

  shareData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userType = sp.getString('usertype');
      token = sp.getString('tokenSP');
      name = sp.getString('name');
      userImage = sp.getString('userImage');
    });
  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(

        centerTitle:false,
        backgroundColor: themeColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12,),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
            },
            child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(userImage!),
                      ),
          ),
        ),
        title: Text(name.toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Colors.white),),

        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert_outlined),
              iconColor: Colors.white,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Profile',
                          )
                        ],
                      )),
                  PopupMenuItem(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TermsScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.description_outlined),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Term and Conditions')
                        ],
                      )),
                  PopupMenuItem(
                      onTap: () {
                        Navigator.popUntil(context, (route) => false);
                        Navigator.push(
                            context, SlideRightRoute(page: LoginScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Logout')
                        ],
                      )),
                ];
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              FutureBuilder<BannerModel>(
                  future: dashBoardController.bannerData(
                      context: context, token: token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        SizedBox(
                            height: ProjectResource.screenHeight * .30,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 2, right: 2),
                              child: ClipRect(
                                child: Container(
                                  height: 100,
                                  color: Colors.teal[200],
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child: Text(
                                        snapshot.data!.success!.notices![0]
                                            .description
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ))),
                                ),
                              ),
                            )),
                        const SizedBox(height: 80),
                        Center(
                          child: badges.Badge(
                            badgeAnimation: const badges.BadgeAnimation.fade(),
                            badgeContent: Text(
                              snapshot.data!.success!.allnotification
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.white),
                            ),
                            position: badges.BadgePosition.topEnd(),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: themeColor,
                              shape: badges.BadgeShape.circle,
                              padding: const EdgeInsets.all(10),
                              borderRadius: BorderRadius.circular(4),
                              elevation: 0,
                            ),
                            child: ElevatedButtons(
                                fixedSize:
                                    Size(ProjectResource.screenWidth * .75, 50),
                                side: const BorderSide(color: themeColor),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationScreen()));
                                },
                                child: const Text(
                                  'Notifications',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        )
                      ]);
                    } else {
                      return Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, left: 2, right: 2),
                          child: ClipRect(
                            child: Container(
                              height: ProjectResource.screenHeight * .30,
                              color: Colors.teal[200],
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Center(
                                      child: Text(
                                    'Loading...',
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Center(
                          child: badges.Badge(
                            badgeAnimation: const badges.BadgeAnimation.fade(),
                            badgeContent: const Text(
                              '0',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            position: badges.BadgePosition.topEnd(),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: themeColor,
                              shape: badges.BadgeShape.circle,
                              padding: const EdgeInsets.all(10),
                              borderRadius: BorderRadius.circular(4),
                              elevation: 0,
                            ),
                            child: ElevatedButtons(
                                fixedSize: Size(
                                    ProjectResource.screenWidth * .75, 50),
                                side: const BorderSide(color: themeColor),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationScreen()));
                                },
                                child: const Text(
                                  'Notifications',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        )
                      ]);
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              ElevatedButtons(
                fixedSize: Size(ProjectResource.screenWidth * .75, 50),
                side: const BorderSide(color: themeColor),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreatePost()));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewPostRequest(
                                tokensp: '',
                              )));
                },
                child: const Text('New Post',
                    style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButtons(
                fixedSize: Size(ProjectResource.screenWidth * .75, 50),
                side: const BorderSide(color: themeColor),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewOwnPost()));
                },
                child: const Text('View own posts',
                    style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(
                height: 10,
              ),
              if (userType != 'user')
                ElevatedButtons(
                  fixedSize: Size(ProjectResource.screenWidth * .75, 50),
                  side: const BorderSide(color: themeColor),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchAllPost()));
                  },
                  child: const Text('Search all posts',
                      style: TextStyle(color: Colors.black)),
                ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButtons(
                fixedSize: Size(ProjectResource.screenWidth * .75, 50),
                side: const BorderSide(color: themeColor),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostFixScreen(tokensp: '',)));
                },
                child: const Text('Post a fix / Tip box', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
