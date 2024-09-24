import 'package:flutter/material.dart';
import '../../helpers/ProjectResource.dart';
import '../../helpers/buttons.dart';
import '../../utils/colors.dart';
import '../Auth/login/login.dart';
import '../Auth/register/registerpage.dart';
import '../iMech_screen/aobutusscreen.dart';
import '../iMech_screen/contactscreen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(

      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButton(
                  height: 50,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUsScreen()));
                  },
                  color: Colors.white,
                  child: const Text('About Us',style: TextStyle(color: Colors.grey),)),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: CustomButton(
                  height: 50,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactUsScreen()));
                  },
                  color: Colors.white,
                  child: const Text('Contact Us',style: TextStyle(color: Colors.grey),)),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
          width: 300,
          child: Image.asset('assets/images/others/surefix.png'
          ,fit: BoxFit.fitWidth)),


          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(

                onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const RegisterPage()));
                },
                style: ElevatedButton.styleFrom(
                 // maximumSize: const Size(340, 50),
                  minimumSize: const Size(300, 50),
                  backgroundColor: themeColor,
                  elevation: 4,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                child: const Text('Register',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),)
          ],),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.black,
                  side:  const BorderSide(color: themeColor,width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                child: const Text('Log In',style: TextStyle(color: themeColor,fontWeight: FontWeight.bold),),),
            ],
          ),
          const SizedBox(height: 10,),


        ],
      ),
    );
  }
}
