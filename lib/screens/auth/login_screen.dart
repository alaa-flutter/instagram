import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta/screens/auth/register_screen.dart';
import 'package:insta/shared/snackbar.dart';
import 'package:provider/provider.dart';
import '../../firebase/controllers/user_fb_controller.dart';
import '../../providers/auth_provider.dart';
import '../../responsive/mobile.dart';
import '../../responsive/responsive_design.dart';
import '../../responsive/web.dart';
import '../../shared/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../shared/elevated_button.dart';
import '../../shared/enums.dart';
import '../../shared/text_field.dart';
import '../../shared_prefernces/shared_preferences.dart';
import '../home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SnackBarHelper {
  late final TextEditingController emailEditingController;
  late final TextEditingController passwordEditingController;
  bool isLoading = false;

  @override
  void initState() {
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.signIn,
          ),
        ),
        body: Center(
            child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 64,
              ),
              MyTextField(
                controller: emailEditingController,
                hint: AppLocalizations.of(context)!.enterYourEmail,
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 22.h,
              ),
              MyTextField(
                controller: passwordEditingController,
                hint: AppLocalizations.of(context)!.enterYourPassword,
                icon: Icons.lock,
                inputType: TextInputType.text,
              ),
              SizedBox(
                height: 33.h,
              ),
              MyElevatedButton(
                isLoading: isLoading,
                onPressed: () async {
                  await performLogin();
                },
                text: AppLocalizations.of(context)!.signIn,
              ),
              SizedBox(
                height: 33.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.noAccount,
                      style: TextStyle(fontSize: 18.sp)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Register(),
                        ));
                      },
                      child: Text(AppLocalizations.of(context)!.register,
                          style: TextStyle(
                              fontSize: 18.sp,
                              decoration: TextDecoration.underline))),
                ],
              ),
            ]),
          ),
        )));
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  late UserCredential userCredential;
  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailEditingController.text,
        password: passwordEditingController.text,
      );

      /// Get User Data
      await saveUserData(userCredential.user!.uid);
      await SharedPreferencesController()
          .setter(type: bool, key: SpKeys.loggedIn, value: true);

      setState(() {
        isLoading = false;
      });
      showSnackBar(context,
          message: AppLocalizations.of(context)!.haveSuccessfullyLoggedIn,
          error: false);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ResponsiveDesign(myWebScreen: WebScreen(), myMobileScreen: MobileScreen(),)));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        showSnackBar(context,
            message: 'No user found for that email.', error: true);
      } else if (e.code == 'wrong-password') {
        showSnackBar(context,
            message: 'Wrong password provided for that user.', error: true);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, message: e.toString(), error: true);
    }
    setState(() {
      isLoading = false;
    });
  }

  CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserData(String uId) async {
    await userCollectionReference.doc(uId).get().then((doc) async {
      if (doc.exists) {
        await SharedPreferencesController()
            .setter(type: String, key: SpKeys.uId, value: doc.get('uId'));
        Provider.of<AuthProvider>(context, listen: false)
            .setName_(doc.get('username'));
        Provider.of<AuthProvider>(context, listen: false)
            .setAvatar_(doc.get('avatar'));
        Provider.of<AuthProvider>(context, listen: false)
            .setTitle_(doc.get('title'));
        var fcmToken = await FirebaseMessaging.instance.getToken();
        await SharedPreferencesController()
            .setter(type: String, key: SpKeys.fcmToken, value: fcmToken ?? '');
        await UserFbController().updateFCMToken(
          uId,
          fcmToken ?? '',
        );
      }
    });
  }

  bool checkData() {
    if (emailEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The email address must be not empty.', error: true);
      return false;
    } else if (passwordEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The password must be not empty.', error: true);
      return false;
    }
    return true;
  }
}
