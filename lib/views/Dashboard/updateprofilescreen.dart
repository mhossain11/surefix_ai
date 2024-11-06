import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/textformfield.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController controller = TextEditingController();
  late ImagePicker imagePickers ;


  @override
  void initState() {
    super.initState();
    imagePickers = ImagePicker();
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
        child: Column(
          children: [
           Stack(
             children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CircleAvatar(
                        radius: 50,
                        // backgroundImage: NetworkImage(snapshot.data!.user!.userImage!),
                        backgroundImage: AssetImage('assets/images/others/imechanicLogo.png'),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                          onTap: (){
                            imageGallery();
                          },
                          child: const Icon(Icons.add_a_photo)))
                ],
              )
             ],
           ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormFields(
                controller:controller,
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
                controller:controller,
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
    );
  }
  imageGallery() async{

    try{
      XFile? result = await imagePickers.pickImage(source: ImageSource.gallery);
      if(result == null) return;
      setState(() {
       // mechanicController.image = File(result.path);
      });
    }catch(e){
      print(e.toString());
    }

  }
}


