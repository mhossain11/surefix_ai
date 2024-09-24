import 'package:flutter/material.dart';
import 'package:surefix_ai/views/Auth/register/nomechanic.dart';
import 'package:surefix_ai/views/Auth/register/yesmechanic.dart';
import '../../../helpers/ProjectResource.dart';
import '../../../helpers/app_text_style.dart';
import '../../../helpers/buttons.dart';
import '../../../helpers/common.dart';
import '../../../utils/colors.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        iconTheme: const IconThemeData(color: themeColor,),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidgets.getGapVertical(value: ProjectResource.screenHeight * .30),
          const Center(child: Text('Are you a professional mechanic?',style: h3Style,textAlign: TextAlign.center,)),
          const SizedBox(height: 10,),
          ElevatedButtons(
            fixedSize: const Size(300,50),
            side: const BorderSide(color: themeColor),
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const YesMechanic()));
          }, child:const Text('Yes',style: TextStyle(color: Colors.black)) ,
          ),
          const SizedBox(height: 5,),
          ElevatedButtons(
            fixedSize: const Size(300,50),
            side: const BorderSide(color: themeColor),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
              onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> const NoMechanic()));
          }, child: const Text('No',style: TextStyle(color: Colors.black))
          ),

        ],
      ),
    );

  }
}
