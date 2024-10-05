import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surefix_ai/controller/profile_controller.dart';
import 'package:surefix_ai/models/profilemodel.dart';

import '../../helpers/ProjectResource.dart';
import '../../services/route_manager.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../widget/profilefield.dart';
import '../Auth/login/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;
  bool userNameVisible = true;
  @override
  void initState() {
    super.initState();
    profileController =  Provider.of<ProfileController>(context, listen: false);
    profileController.profileData(context: context);
    setState(() {
      profileController.loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: themeColor,
        leading:IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(Images.backIcon,color: Colors.white,),
        ),
      ),

      body: SizedBox(
        child: FutureBuilder<ProfileModel>(
          future: profileController.profileData(context: context),
          builder: (BuildContext context,snapshot) {
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(snapshot.data!.user!.userImage!),
                        ),
                      ),
                    ),
                      Text(

                        snapshot.data!.user!.name!.toString(),
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400,color: themeColor),
                      ),
                    Text(
                      snapshot.data!.user!.type!,
                      style: const TextStyle(fontSize: 18, color: Colors.black,fontWeight:FontWeight.w400 ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Specializes in engine repairs and maintenance. Available for emergency roadside assistance.',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text('User Name',style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ProfileField(
                          icon: Icons.person,
                          hintText: snapshot.data!.user!.userName.toString() ?? "User name",
                        ),
                      ),

                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text('Email',style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                
                      Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: ProfileField(
                         icon: Icons.email,
                         hintText: snapshot.data!.user!.email.toString(),
                       ),
                     ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text('Phone Number',style: TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ProfileField(
                        icon: Icons.phone,
                        hintText: snapshot.data!.user!.mobile.toString() ?? 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: 20,),
                    
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed:() {
                            Navigator.popUntil(context, (route) => false);
                            Navigator.push(
                                context, SlideRightRoute(page: LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,

                          ),
                          child: const Text('Log out',style: TextStyle(color: Colors.white),)
                      ),
                    )





                  ],
                ),
              );
            }else{
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );;
        },

        ),
      ),
    );
  }
}
