import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surefix_ai/views/Dashboard/homepage.dart';

import '../../helpers/ProjectResource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double>animation;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds:5 ),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage()));
    });
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 7));
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.repeat();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
                color: Colors.white,
                child: Image.asset('assets/animations/SurefixAICarAnimation.gif')),
          ),
        ],
      ),
    );
  }
}
