/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/images.dart';
import 'ProjectResource.dart';
import 'clipers.dart';


class CommonWidgets {
  static getLogo({required double heights}) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        width: ProjectResource.screenWidth,
        height: heights,
        color: white,
        child: SafeArea(
          child: Column(
            children: [
              getGapVertical(value: ProjectResource.screenHeight * .13),
              Image.asset(
                Images.appLogo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static getLogoAppBar({context}) {
    return AppBar(
      elevation: 1,
      leading: null,
      toolbarHeight: 65,
      title: Image.asset(
        Images.appLogo,
        fit: BoxFit.contain,
        height: 50,
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: colorTheme,
            ))
      ],
    );
  }

  static getCommonAppBar({context, title}) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 65,
      title: Text(
        title,
        style: TextStyle(color: black),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: colorTheme,
            ))
      ],
    );
  }

  static getHomeAppBar({context, title}) {
    return AppBar(
      elevation: 1,
      toolbarHeight: 65,
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: TextStyle(color: black),
      ),
      actions: [
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.notifications,
        //       color: colorTheme,
        //     ))
      ],
    );
  }

  static getAppBar({context, title, isBack}) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 65,
      title: Text(
        title,
        style: const TextStyle(color: black),
      ),
      leading: isBack == null? InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pop(context);
          },
          child: Image.asset(Images.backIcon)):Container(),
    );
  }

  static getCommonPadding() {
    return EdgeInsets.fromLTRB(ProjectResource.screenWidth * .04, 20,
        ProjectResource.screenWidth * .04, 20);
  }

  static getTitle(
      {required String value,  TextAlign? textAligns, required Color colors,  double? fontSizes}) {
    return Text(
      value,
      textAlign: textAligns,
      style: TextStyle(
          color: colors ?? black,
          fontSize: fontSizes ?? ProjectResource.headerFontSize! * 1.1,
          fontWeight: FontWeight.bold),
    );
  }

  static getSubTitle({required String value, required Color colors, required TextAlign textAligns}) {
    return Text(
      value,
      textAlign: textAligns,
      style: TextStyle(
          color: colors ?? white.withOpacity(.8),
          fontSize: ProjectResource.headerFontSize! * .9,
          fontWeight: FontWeight.normal),
    );
  }

  static getGapVertical({required double value}) {
    return SizedBox(
      height: value,
    );
  }

  static getGapHorizontal({required double value}) {
    return SizedBox(
      width: value,
    );
  }

  static getErrorView() {
    return Center(
      child: Text(
        "Something went wrong",
        style: TextStyle(
            fontSize: ProjectResource.bodyFontSize! * .9, color: black),
      ),
    );
  }

  static getNoItemView(
      {context,
      required String title,
      dynamic route,
      required String routeText,
      String type = 'none'}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          type == 'none'
              ? Container()
              : type == 'noItem'
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Icon(
                        Icons.search_outlined,
                        color: colorTheme,
                        size: ProjectResource.headerFontSize! * 2,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Icon(
                        Icons.error_outline_outlined,
                        color: colorTheme,
                        size: ProjectResource.headerFontSize! * 2,
                      ),
                    ),
          Text(
            title.toString(),
            style: TextStyle(
                fontSize: ProjectResource.bodyFontSize! * .96, color: black),
          ),
          const SizedBox(
            height: 10,
          ),
          route == null
              ? Container()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () {
                 //   Navigator.push(context, SlideRightRoute(page: route));
                  },
                  child: Text(
                    routeText,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ProjectResource.bodyFontSize! * .9),
                    textAlign: TextAlign.center,
                  )),
        ],
      ),
    );
  }

  /*static getTimer({required int second, context}) {
    return TweenAnimationBuilder<Duration>(
        duration: Duration(seconds: second),
        tween: Tween(begin: Duration(seconds: second), end: Duration.zero),
        onEnd: () {
          print('--------Timer ended------');
          // Provider.of<RegisterController>(context, listen: false)
          //     .resendSwitch(val: true);
        },
        builder: (BuildContext context, Duration value, Widget child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text('$seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: ProjectResource.headerFontSize)));
        });
  }*/

  static getSubscriptionBubble() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(shape: BoxShape.circle, color: black),
      child: const Text(
        'S',
        style: TextStyle(color: white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
