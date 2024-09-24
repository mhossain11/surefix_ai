import 'package:surefix_ai/controller/viewownpost_controller.dart';
import 'package:surefix_ai/helpers/ProjectResource.dart';
import 'package:surefix_ai/services/route_manager.dart';
import 'package:surefix_ai/services/shared_preference.dart';
import 'package:surefix_ai/utils/colors.dart';
import 'package:surefix_ai/views/Auth/login/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'iMech_screen/newpostRequest.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  getHome(context) {
    return ListTile(
      leading: Icon(
        Icons.home,

      ),
      title: Text(
        "Dashboard",

      ),
      onTap: () {
        Navigator.pop(context);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) {
        //       return OrgDashboardScreen(
        //         organization: Provider.of<OrgHomeController>(context, listen: false).selectedOrganization,
        //       );
        //     }));
      },
    );
  }

  getUserDrawer(context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        SafeArea(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (BuildContext context) {
              //       return DashboardScreen();
              //     }));
            },
            child: Container(
              color: white,
              height: ProjectResource.screenHeight * .16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ProjectResource.screenWidth * .03,
                  ),
                  CircleAvatar(
                    backgroundColor: black.withOpacity(.5),
                    radius: ProjectResource.screenHeight * .04,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png',
                        imageBuilder: (context, imageProvider) => Container(
                          width: ProjectResource.screenWidth * .1,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          width: ProjectResource.screenWidth * .2,
                          height: ProjectResource.screenHeight * .1,
                        ),
                        errorWidget: (context, url, error) =>
                            Container(child: const Center(child: Icon(Icons.error))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ProjectResource.screenWidth * .03,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'surefix_ai',
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w500,
                              fontSize: ProjectResource.headerFontSize),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '01719721908',
                          style: TextStyle(
                              color: colorSubtitle,
                              fontSize: ProjectResource.headerFontSize! * .8),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(),
        // getHome(context),
        // ListTile(
        //   minVerticalPadding: 0,
        //   leading: Icon(Icons.list),
        //   title: Text("All Documents"),
        //   onTap: () {
        //     Navigator.pop(context);
        //
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (BuildContext context) {
        //           return DocumentsScreen( organization: Provider.of<OrgHomeController>(context, listen: false).selectedOrganization);
        //         }));
        //   },
        // ),
        ListTile(
          minVerticalPadding: 0,
          leading: Icon(Icons.document_scanner_rounded),
          title: Text("New Request"),
          onTap: () {
            Navigator.pop(context);

            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return NewPostRequest(tokensp: '',);
                }));
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle_rounded),
          title: Text("Account"),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return LoginScreen();
                }));
          },
        ),

        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
          onTap: () {
            ProjectResource.settings['loggedIn'] = false;
            ProjectResource.loggedIn = false;
            ProjectResource.settings['user'] = null;
            print(ProjectResource.settings);
            SharedPref.save('settings', ProjectResource.settings);
            Navigator.popUntil(context, (route) => false);
            Navigator.push(context, SlideRightRoute(page: LoginScreen()));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: white,
          child: getUserDrawer(context),
    ));
  }
}
