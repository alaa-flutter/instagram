import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta/shared/snackbar.dart';

import '../../shared/color.dart';
import '../../shared/elevated_button.dart';
import '../../shared/text_field.dart';
import 'login_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with SnackBarHelper{

  late final TextEditingController emailEditingController;
  bool isLoading = false;

  @override
  void initState() {
    emailEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.resetPassword),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding:widthScreen>600 ? EdgeInsets.symmetric(horizontal: widthScreen*.3): const EdgeInsets.all(33.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.enterYourEmailToRestYourPassword,
                  style: TextStyle(fontSize: 18.sp)),
              SizedBox(
                height: 33.h,
              ),
              MyTextField(
                controller: emailEditingController,
                hint: AppLocalizations.of(context)!.enterYourEmail,
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
              ),
               SizedBox(
                height: 33.h,
              ),

              MyElevatedButton(
                isLoading: isLoading,
                onPressed: ()async {
                await performResetPassword();
                },
                text: AppLocalizations.of(context)!.resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performResetPassword() async {
    if (checkData()) {
      await resetPassword();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Login()));
    }
  }
  Future<void> resetPassword() async{
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailEditingController.text);
      showSnackBar(context, message: AppLocalizations.of(context)!.doneCheckYourEmail, error: false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, message: e.toString(), error: true);
    }catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, message: e.toString(), error: true);
    }
    setState(() {
      isLoading = false;
    });


  }

  bool checkData() {
    if (emailEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The email address must be not empty.', error: true);
      return false;
    }
    return true;
  }
}