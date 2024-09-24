/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surefix_ai/views/Dashboard/homepage.dart';

import 'package:provider/provider.dart';
import '../../../controller/login_controller.dart';
import '../../../helpers/ProjectResource.dart';
import '../../../helpers/buttons.dart';
import '../../../helpers/common.dart';
import '../../../helpers/shadows.dart';
import '../../../helpers/textfields.dart';
import '../../../services/route_manager.dart';
import '../../../services/validators.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../passwordRecovery/email_verify_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginController loginController;
  late LoginController loginControllerVar;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     setState(() {
       loginController.loading=false;
     });
      loginController.clear();
    });
  }

  @override
  void didChangeDependencies() {
    loginController = Provider.of<LoginController>(context, listen: false);
    loginControllerVar = Provider.of<LoginController>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    loginController.clear();
    super.dispose();
  }

  //logo with name //
  getLogo() {
    return Hero(
      tag: 'logoArea',
      child: CommonWidgets.getLogo(heights: ProjectResource.screenHeight * .45),
    );
  }

//auth choices
  getAuthField(double screenWidth, double screenHeight) {
    getEmailField() {
      return CustomTextField(
        controller: loginControllerVar.emailController,
        focusNode: loginControllerVar.emailControllerNode,
        hasBorder: 'true',
        nextNode: loginController.passwordControllerNode,
        hint: "User name/email",
        prefixIcon: Icons.email_outlined,
        validator: (String value) {
          return value != null ? null : "Invalid";
        },
      );
    }

    getPasswordField() {
      return CustomTextField(
        controller: loginControllerVar.passwordController,
        focusNode: loginControllerVar.passwordControllerNode,
        textInputType: TextInputType.text,
        nextNode: FocusNode(),
        hasBorder: 'true',
        hint: "password ",
        prefixIcon: Icons.lock_open_outlined,
        obscure: loginControllerVar.passwordVisible,
        suffix: InkWell(
          child: Icon(
            // Based on passwordVisible state choose the icon
            loginControllerVar.passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: colorSubtitle,
          ),
          onTap: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            loginController.passVisibleChange();
          },
        ),
        validator: (String value) {
          return Validators.validatePassword(value) == null ? null : "Invalid";
        },
      );
    }

    getForgotPassword() {
      return Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
             Navigator.push(
                 context, SlideRightRoute(page: const EmailVerifyScreen()));
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              "Forgot password?",
              style: TextStyle(color: black, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }

    //Login
    getLoginButton() {
      return CustomButton(
          color: themeColor,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              loginController.userLogin(context: context);
            } else {

            }
          },

          child: loginControllerVar.loading
              ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : const Text(
            "Login",
            style: TextStyle(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ));
    }



    return Container(
      padding: CommonWidgets.getCommonPadding(),
      width: ProjectResource.screenWidth,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.getGapVertical(
                  value: ProjectResource.screenHeight * .05),
              CommonWidgets.getGapVertical(
                  value: ProjectResource.screenHeight * .05),
              const Padding(
                padding: EdgeInsets.only(left: 15.0,top: 10),
                child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),

              Container(height: 10,),
              Container(
                padding: const EdgeInsets.only(left: 10,right: 10),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(height: 10,),
                    getEmailField(),
                    CommonWidgets.getGapVertical(
                        value: ProjectResource.screenHeight * .025),
                    getPasswordField(),
                    CommonWidgets.getGapVertical(
                        value: ProjectResource.screenHeight * .04),
                    getForgotPassword(),
                    CommonWidgets.getGapVertical(
                        value: ProjectResource.screenHeight * .04),
                    getLoginButton(),
                    CommonWidgets.getGapVertical(
                        value: ProjectResource.screenHeight * .04),

                  ],
                ),
              ),

              CommonWidgets.getGapVertical(
                  value: ProjectResource.screenHeight * .05),
              // getExploreGuest()
            ],
          ),
        ),
      )

    );
  }


  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 65,
          backgroundColor:Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage()));

              },
              child: const Icon(Icons.arrow_back,color: themeColor,))
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                getAuthField(
                    ProjectResource.screenWidth, ProjectResource.screenHeight),
              ],
            )
          )

      ),
    );
  }
}
