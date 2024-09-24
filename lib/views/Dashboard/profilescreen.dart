import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surefix_ai/controller/profile_controller.dart';
import 'package:surefix_ai/models/profilemodel.dart';

import '../../helpers/ProjectResource.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;
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
      body: Center(
        child: SizedBox(
          child: FutureBuilder<ProfileModel>(
            future: profileController.profileData(context: context),
            builder: (BuildContext context,snapshot) {
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text('User photo',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/others/imechanicLogo.png'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text('User name: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
                        Text(
                          snapshot.data!.user!.name!.toString(),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('User Level: ',
                          style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.user!.type!,
                          style: const TextStyle(fontSize: 18, color: Colors.black,fontWeight:FontWeight.w400 ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Specializes in engine repairs and maintenance. Available for emergency roadside assistance.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      snapshot.data!.user!.mobile == null  ? '':snapshot.data!.user!.mobile.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
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
      ),
    );
  }
}
