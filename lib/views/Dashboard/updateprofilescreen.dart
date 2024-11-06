import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controller/updateprofile_controller.dart';
import '../../helpers/textformfield.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../widget/imagepick.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late UpdateProfileController updateProfileController;
  late UpdateProfileController updateProfileControllerVar;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Uint8List _image;



  @override
  void initState() {
    super.initState();

  }
  @override
  void didChangeDependencies() {
    updateProfileController =
        Provider.of<UpdateProfileController>(context, listen: false);
    updateProfileControllerVar =
        Provider.of<UpdateProfileController>(context, listen: true);
    super.didChangeDependencies();
  }


  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: themeColor,
        leading:IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(Images.backIcon,color: Colors.white,),
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
             Stack(
               children: [
                 /*_image != null ?  CircleAvatar(
                   radius: 100,
                   backgroundImage: MemoryImage(_image),
                 ):*/
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/others/imechanicLogo.png'),
                                   ),
                 ),
                Positioned(
                    right: 50,
                    bottom: 2,
                    child: InkWell(
                        onTap: (){
                          updateProfileController.selectFile();
                        },
                        child: const Icon(Icons.add_a_photo)))
               ],
             ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormFields(
                  controller:nameController,
                  minLines: 1,
                  maxLines: 1,
                  cursorColor: themeColor,
                  keyboardType: TextInputType.text,
                  levelText: const Text('User Name'),
                  validators: (String? value) {
                    if(value!.isEmpty){
                      return 'Please enter a user name';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormFields(
                  controller:mobileController,
                  minLines: 1,
                  maxLines: 1,
                  cursorColor: themeColor,
                  keyboardType: TextInputType.text,
                  levelText: const Text('Mobile Number'),
                  validators: (String? value) {
                    if(value!.isEmpty){
                      return 'Please enter a mobile number';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormFields(
                  controller:passwordController,
                  minLines: 1,
                  maxLines: 1,
                  obscureText: true,
                  cursorColor: themeColor,
                  keyboardType: TextInputType.text,
                  enabledBorderSide: const BorderSide(color: Colors.grey),
                  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
                  levelText: const Text('Confirm Password'),
                  validators: (String? value) {
                    if(value!.isEmpty){
                      return 'Please enter a password';
                    }else if(value != passwordController.text){
                      return ("Password not match ");
                    }
                    else{
                      return null;
                    }
                  },
                ),
              ),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed:() {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,

                    ),
                    child: const Text('Update',style: TextStyle(color: Colors.white),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


 /* imageGallery() async{

    try{
      XFile? result = await imagePickers.pickImage(source: ImageSource.gallery);
      if(result == null) return;
      setState(() {
        updateProfileController.image = File(result.path);
      });
    }catch(e){
      print(e.toString());
    }

  }*/
  deletesImage() async{
    if(updateProfileController.image != null && await updateProfileController.image!.exists()) {
      await updateProfileController.image!.delete();
      setState(() {
        updateProfileController.image = null;
      });

    }
  }
}


