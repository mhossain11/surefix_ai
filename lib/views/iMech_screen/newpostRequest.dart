

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:surefix_ai/models/registrationNumberModel.dart';
import 'package:provider/provider.dart';
import '../../controller/request_controller.dart';
import '../../helpers/ProjectResource.dart';
import '../../helpers/buttons.dart';
import '../../helpers/common.dart';
import '../../helpers/dialogs.dart';
import '../../helpers/restartWidget.dart';
import '../../helpers/snackbars.dart';
import '../../helpers/textfields.dart';
import '../../helpers/textformfield.dart';
import '../../models/DashModel.dart';
import '../../models/createrequestModel3.dart';
import '../../models/createrequestModssel.dart';
import '../../models/foultcodeData.dart';
import '../../services/data/databasehelper.dart';
import '../../services/route_manager.dart';
import '../../utils/api_urls.dart';
import '../../utils/colors.dart';
import 'package:http/http.dart' as http;

import '../../utils/images.dart';
import '../Auth/login/login.dart';
import '../Dashboard/dashboard.dart';
import '../customDrawer.dart';

class NewPostRequest extends StatefulWidget {
   String tokensp = '';
  String? noDrawer;
  //CreateRequest({super.key,  this.noDrawer});
   NewPostRequest( {super.key,required this.tokensp});

  @override
  State<NewPostRequest> createState() => _NewPostRequestState();
}

class _NewPostRequestState extends State<NewPostRequest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final  TextEditingController registrationController = TextEditingController();
  final  TextEditingController usernameController = TextEditingController();
  final  TextEditingController faultController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController typeAheadController = TextEditingController();
  FocusNode titleControllerNode = FocusNode();
  FocusNode descriptionControllerNode = FocusNode();
  String dropdownValue ="";
  final List<FaultCodeData> dataCode =[];
  late DatabaseHelper? dbHelper;
  var data='';
  late RequestController requestController;
  late RequestController requestControllerVar;
  File? documentsImage;
  bool isVisible = false;
  String? userSelected ='';

  var alldata ='';
  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dataCode.clear();
      for(var item in dataFaultCode){
        dataCode.add(item);
      }

      requestController.clear();
      setState(() {
      //  titleController.selection = TextSelection.fromPosition(TextPosition(offset: titleController.text.length));
        requestController.loading =false;

      });
      // documentController.getChatGPTData(
      //     context: context);
    });
  }




  @override
  void didChangeDependencies() {
    requestController =
        Provider.of<RequestController>(context, listen: false);
    requestControllerVar =
        Provider.of<RequestController>(context, listen: true);
    super.didChangeDependencies();


  }

  @override
  void dispose() {
    requestController.clear();
    requestControllerVar.clear();
    registrationController.dispose();
    usernameController.dispose();
    descriptionController.dispose();
    titleController.dispose();
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    faultController.dispose();
    super.dispose();
  }

  getSpacer() {
    return SizedBox(
      height: ProjectResource.screenHeight * .01,
    );
  }

  getSpacer2x() {
    return SizedBox(
      height: ProjectResource.screenHeight * .02,
    );
  }

  final ImagePicker  _picker =ImagePicker();
  XFile? pickedImage;
  late Map mapResponse;
  late Map dataResponse;
  bool loadingAccount = false;
  bool loadingAccountError = false;

  getUserNameField(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: TextFormField(
          controller: usernameController,
          decoration:  const InputDecoration(
            hintText: 'Enter your Name',
            label: Text('Request Name'),
            // icon: Icon(),
            prefixIcon: Icon(Icons.person),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: .5)
            ),
            enabledBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey,width: .4)
            ),
          ),
          validator:(String? value){
            if(value!.isEmpty){
              return 'Please enter your Name';
            }else{
              return null;
            }
          } ,
      ),
    );
  }

  getDescriptionField(){
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      child: TextFormField(

          controller: descriptionController,
          maxLines: 2,
          keyboardType: TextInputType.text,
          decoration:  const InputDecoration(
            hintText: 'Write some description',
            helperStyle: TextStyle(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.blue,)
            ),
            enabledBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey,)
            ),
          ),
        validator: (String? value){
          if(value!.isEmpty){
            return 'Please enter a description';
          }else{
            return null;
          }
        },
      ),
    );
  }

  getFileInforamtionField(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: WCMaterialButton(
            sides: 2,
              color: Colors.white,
              onPressed: () {
                requestController.selectFile();
              },

              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(Icons.upload, color: colorTheme,),
                    SizedBox(height: 4,),
                    Text('Import file',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorTheme),
                    ),
                  ],
                ),
              )),
        ),
        const SizedBox(width: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 220,
              child: requestControllerVar.documentsImage != null?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("File: ${requestControllerVar.documentsImage?.path.toString().split("/")[requestControllerVar.documentsImage!.path.toString().split("/").length-1]} Addd.",overflow: TextOverflow.ellipsis,),
              ):Container(),
            ),
            Visibility(
              visible: requestControllerVar.documentsImage != null,
              child: IconButton(onPressed: (){
               setState(() {
                 requestControllerVar.deleteImage();
               });
              }, icon: const Icon(Icons.clear,color: Colors.grey)),
            )
          ],
        )
      ],
    );
  }
  getSaveButton() {
    return  Center(
        child: SizedBox(
          width: 150,
          height: 55,
          child: WCMaterialButton(

              onPressed: () {
                if (_formKey.currentState!.validate() ) {

                    requestController.getChatGPTData(context: context,
                      registrationController:registrationController,
                      usernameController: usernameController,
                      descriptionController: descriptionController,
                      titleController: titleController,
                      makeController: makeController,
                      modelController: modelController,
                      yearController: yearController,
                      faultController:typeAheadController,);



                }else if(faultController.text.isEmpty){
                  SnackBars.showSnackBar(
                      context: context,
                      content: 'please enter FaultCode',
                      durationSec: 3,
                      success: false,
                      routeAction: null);
                }
                else {
                  SnackBars.showSnackBar(
                      context: context,
                      content: 'please complete register',
                      durationSec: 3,
                      success: false,
                      routeAction: null);

                }
              },

              color: themeColor,

              child: requestController.loading == false ?
              const Center(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.save,color: Colors.white,),
                    SizedBox(width: 5,),
                    Text('Post', style: TextStyle(fontSize: 16,color: Colors.white))
                  ],
                ),
              ):
              const CircularProgressIndicator(color: Colors.white,)
          ),
        )
    );
  }



  getHomeView() {

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //input Text
            const Row(children: [
              SizedBox(height: 5,),
              Padding(
                padding: EdgeInsets.only(left: 10.0,top: 10),
                child: Icon(Icons.app_registration),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Registration number',style: TextStyle(fontWeight:FontWeight.bold),),
              ),
            ],),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,top: 5),
                child: Row(
                        children: [

                          const SizedBox(width: 5,),
                          Expanded(
                            flex: 4,
                            child: TextFormFields(
                              controller: registrationController,
                              //hint: 'Registration number',
                              minLines: 1,
                              maxLines: 1,
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    isVisible =false;
                                  });
                                  registrationController.clear();
                                },
                                icon:registrationController.text.isNotEmpty? const Icon(Icons.clear,color: Colors.black12,):const SizedBox(),

                              ),
                              keyboardType: TextInputType.text,
                              enabledBorderSide: const BorderSide(color: Colors.grey),
                              focusedBorderSide: const BorderSide(color: Colors.blue),
                              validators: (String? value) {
                                if(value!.isEmpty){
                                  return 'Please enter a registration number';
                                }else{
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                         Expanded(
                           flex: 1,
                           child: Padding(
                             padding: const EdgeInsets.only(top:8,bottom: 15.0),
                             child: Container(
                                height: 50.0,
                                width: 40.0,
                                decoration: const BoxDecoration(
                                   // border: Border.all(color: Colors.blue),
                                  color: themeColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0) //                 <--- border radius here
                                  ),


                                ),

                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                    if(registrationController.text.isNotEmpty){
                                      isVisible = !isVisible;
                                      makeController.clear();
                                      modelController.clear();
                                      yearController.clear();
                                      print('isVisible:$isVisible');
                                    } else{
                                      print('Not Work');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Enter your Registration Number!"),
                                        ),
                                      );
                                    }
                                  });}, icon: const Icon(Icons.search,color: Colors.white,),
                                ),
                              ),
                           ),
                         ),


                        ],
                      ),
              ),
              Column(children: [
               Visibility(visible: isVisible, child: const Text('Could not find any data, please add details!',style: TextStyle(color: themeColor),)),
               Row(
                 children: [
                   Expanded(
                     flex: 1,
                     child: Padding(
                       padding: const EdgeInsets.all(10),
                       child: TextFormField(
                           controller: makeController,
                           maxLines: 1,
                           decoration:  const InputDecoration(
                             hintText: 'Make',
                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color:Colors.blue,)
                             ),
                             enabledBorder:OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey,)
                             ),
                           )
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     child: Padding(
                       padding: const EdgeInsets.all(10),
                       child: TextFormField(
                           controller: modelController,
                           maxLines: 1,
                           decoration:  const InputDecoration(
                             hintText: 'Model',
                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color:Colors.blue,)
                             ),
                             enabledBorder:OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey,)
                             ),
                           )
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     child: Padding(
                       padding: const EdgeInsets.all(10),
                       child: TextFormField(
                           controller: yearController,
                           maxLines: 1,
                           decoration:  const InputDecoration(
                             hintText: 'Year',
                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color:Colors.blue,)
                             ),
                             enabledBorder:OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey,)
                             ),
                           )
                       ),
                     ),
                   ),

                 ],
               )
                         ],),
             const SizedBox(height: 10,),

            const SizedBox(height: 10,),
            const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
              //Text('Request Description',style: TextStyle(fontSize: 16),)
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.description),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Fault code/s',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
            ]),
                  /*Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                    controller: faultController,
                    maxLines: 1,
                    decoration:  const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue,)
                    ),
                    enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,)
                    ),
                    )
                    ),
                  ),*/
            /*Padding(
              padding: const EdgeInsets.all(10.0),
              child: dropDownButtons(),
            ),*/
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TypeAheadField(
                  controller: typeAheadController,
                  suggestionsCallback: (search) {
                    var a= dataCode.where((item)=>item.faultCode!.toLowerCase().contains(search.toLowerCase())).toList();
                    return a;
                  },

                  builder: (context, controller, focusNode) {
                    return TextField(
                        scrollPhysics: const BouncingScrollPhysics(),
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fault code/s',

                        )
                    );
                  },
                  itemBuilder: (context, item) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          shape: BoxShape.rectangle
                      ),
                      width: 350,
                      height: 50,
                      child: ListTile(
                        selectedTileColor: Colors.grey[100],
                        title: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(item.faultCode.toString()),
                        ),
                      ),
                    );
                  },
                  autoFlipDirection: false,
                  onSelected: (FaultCodeData value) {
                    setState(() {
                      typeAheadController.text = value.faultCode.toString();
                      int index = int.parse(value.id.toString());
                    //  print('typeAheadController:${typeAheadController.text}');
                      if(typeAheadController.text.isEmpty){
                        titleController.clear();
                      }else{
                      //  print(index.toString());
                        titleController.text =  dataCode[index].title.toString();
                      //  print(dataCode[index].title.toString());
                      }


                    });
                  },



                ),
              ),
            ),
            const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  //Text('Request Description',style: TextStyle(fontSize: 16),)
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.description_outlined),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Title',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller:titleController ,
                  focusNode: titleControllerNode,
                  maxLines: 1,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                  hintText: 'Write title',
                  helperStyle: TextStyle(color: Colors.grey[900]),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.blue,)
                  ),
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,)
                  ),
                ),
                validator: (String? value){
                  if(value!.isEmpty){
                    faultController.text.isEmpty;
                    return 'Please enter a title';
                  }else{
                    return null;
                  }
                },
              ),
            ),
            const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
              //Text('Request Description',style: TextStyle(fontSize: 16),)
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.description),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Description',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
            ]),
            getDescriptionField(),
            const SizedBox(height: 10,),
            //Image picker
           // getFileInforamtionField(),
            const Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.upload_file_sharp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Upload photos or video',style: TextStyle(fontWeight:FontWeight.bold),),
              ),
            ],),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 370,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1,color: Colors.black12)

                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(

                        child: getFileInforamtionField(),
                      ),

                      const SizedBox(height: 20,),
                      const Center(child: Text('Please Upload your video or image now.\n .mp4, .jpg',
                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            //Button
            getSaveButton(),
            //Text


           //getChatGPTResult(),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    print('Range ${dataCode.length.toString()}');
    print(dataFaultCode.length.toString());

    return Scaffold(

      appBar: AppBar(
        title: const Text('New Post',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: themeColor,
        leading:IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
            //Navigator.of(context).pop();
          },
          icon: Image.asset(Images.backIcon,color: Colors.white,),
        ),

        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            iconColor: Colors.white,
              itemBuilder: (context){
                return [
                  PopupMenuItem(
                      onTap: (){},
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 8,),
                          Text('Profile',)
                        ],
                      )),
                  PopupMenuItem(
                      onTap: (){
                        Navigator.popUntil(context, (route) => false);
                        Navigator.push(context, SlideRightRoute(page: LoginScreen()));
                      },
                      value: '1',
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8,),
                          Text('Logout')
                        ],
                      )),
                ];
              })
        ],
      ),
      body: getHomeView(),
    );
  }
  Widget dropDownButtons(){
    return DropdownButtonFormField(

        icon: const Icon(Icons.arrow_drop_down),
        value:dropdownValue,
        //style: const TextStyle(height: 40),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          // labelText: 'experience level'
        ),
        items: dataFaultCode.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(value: value.id.toString(),child: Text(value.faultCode.toString()));

        }
        ).toList(),
        onChanged: (String? newValue){
          setState(() {
            dropdownValue = newValue!;
            int index = int.parse(newValue);
            titleController.text =  dataCode[index].title.toString();
          });

        });
  }
}
