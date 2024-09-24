
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:surefix_ai/utils/colors.dart';
import 'package:surefix_ai/views/Auth/login/login.dart';

import '../../../controller/resetpassword_controller.dart';
import '../../../helpers/ProjectResource.dart';
import '../../../helpers/snackbars.dart';



class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ResetPasswordController resetPasswordController;
  late ResetPasswordController resetPasswordControllerVar;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      resetPasswordController.clear();
      setState(() {
        resetPasswordController.loading = false;
      });
    });

  }
  @override
  void didChangeDependencies() {
    resetPasswordController = Provider.of<ResetPasswordController>(context, listen: false);
    resetPasswordControllerVar = Provider.of<ResetPasswordController>(context, listen: true);
    super.didChangeDependencies();
  }

   String? _validateConfirmPassword(String? value) {
     if (value == null || value.isEmpty) {
       return 'Please confirm your password';
     }
     if (value.length < 6) {
       return 'Password must be at least 6 characters long';
     }
     return null;
   }

   void _submit() {
       if (_formKey.currentState?.validate() == true) {
         resetPasswordController.resetPassword(context: context);
       }else{
         SnackBars.showSnackBar(
             context: context,
             content: 'please enter confirm password',
             durationSec: 3,
             success: false,
             routeAction: null);
       }
   }



  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 65,
          backgroundColor:Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back,color: themeColor,))
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(100),
                Text('Reset Password', style: theme.textTheme.titleLarge),
                const Gap(5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Password must have 8 letters with number combination',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                const Gap(16),
                TextFormField(
                  controller: resetPasswordController.passwordController,
                  obscureText: resetPasswordController.passwordVisible,
                  decoration:  InputDecoration(hintText: 'Your new password',
                    suffix: InkWell(
                      child: Icon(
                        // Based on passwordVisible state choose the icon
                        resetPasswordController.passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: colorSubtitle,
                      ),
                      onTap: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                         setState(() {
                           resetPasswordController.passwordVisible =! resetPasswordController.passwordVisible;
                         });

                      },
                    ), ),
                  validator: _validateConfirmPassword,
                ),
                const Gap(24),
                TextFormField(
                  controller: resetPasswordController.confirmPasswordController,
                  obscureText: resetPasswordController.confirmPasswordVisible,
                  decoration:  InputDecoration(
                      hintText: 'Re-type Your password',
                      suffix: InkWell(
                        child: Icon(
                          // Based on passwordVisible state choose the icon
                          resetPasswordController.confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: colorSubtitle,
                        ),
                        onTap: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            resetPasswordController.confirmPasswordVisible =! resetPasswordController.confirmPasswordVisible;
                          });

                        },
                      )),
                  validator: _validateConfirmPassword,
                ),
                const Gap(24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      _submit();
                    },
                    child: resetPasswordController.loading == false?
                      const Center(child: Text('Reset Password')):
                      const CircularProgressIndicator(color: Colors.blue,)

                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>  LoginScreen(),
                            ),
                                //(route) => false,
                          );
                        },
                        child: const Text('Sign In')),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
