import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename;
import "dart:math";
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/shared/snackbar.dart';

import '../../firebase/controllers/user_fb_controller.dart';
import '../../models/user_model.dart';
import '../../shared/color.dart';
import '../../shared/elevated_button.dart';
import '../../shared/text_field.dart';
import 'forgot_password.dart';
import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with SnackBarHelper {
  late final TextEditingController usernameEditingController;
  late final TextEditingController titleEditingController;
  late final TextEditingController emailEditingController;
  late final TextEditingController passwordEditingController;

  bool isLoading = false;

  @override
  void initState() {
    usernameEditingController = TextEditingController();
    titleEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameEditingController.dispose();
    titleEditingController.dispose();
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
        title: Text(AppLocalizations.of(context)!.register),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 71.r,
                              backgroundImage:
                                  const AssetImage("assets/images/avatar.png"),
                            )
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        left: 99,
                        bottom: -10,
                        child: IconButton(
                          onPressed: ()async {
                           await uploadImage();
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: const Color.fromARGB(255, 208, 218, 224),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                MyTextField(
                  controller: usernameEditingController,
                  hint: AppLocalizations.of(context)!.enterYourUsername,
                  icon: Icons.person,
                  inputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 22,
                ),
                MyTextField(
                  controller: titleEditingController,
                  hint: AppLocalizations.of(context)!.enterYourTitle,
                  icon: Icons.person_outline,
                  inputType: TextInputType.text,
                ),
                SizedBox(
                  height: 22.h,
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
                    await performRegister();
                  },
                  text: AppLocalizations.of(context)!.register,
                ),
                SizedBox(
                  height: 33.h,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPassword()),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.forgotPassword,
                      style: TextStyle(
                          fontSize: 18.sp,
                          decoration: TextDecoration.underline)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.noAccount,
                        style: TextStyle(fontSize: 18.sp)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Login(),
                          ));
                        },
                        child: Text(AppLocalizations.of(context)!.signIn,
                            style: TextStyle(
                                fontSize: 18.sp,
                                decoration: TextDecoration.underline),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  File? imgPath;
  String? imgName;
  String? urlImg;
  uploadImage2Screen(ImageSource source) async {
    Navigator.of(context).pop();
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        showSnackBar(context,
            message: "NO img selected", error: true);
        print("NO img selected");
      }
    } catch (e) {
      showSnackBar(context,
          message: e.toString(), error: true);
      print("Error => $e");
    }


  }
  uploadImage() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20.sp),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              InkWell(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children:  [
                    const Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20.sp),
                    )
                  ],
                ),
              ),
        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18.sp),
                          ))
            ],
          ),
        );
      },
    );
  }


  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  late UserCredential userCredential;

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailEditingController.text,
        password: passwordEditingController.text,
      );

      if (imgPath != null) {
        final storageRef = FirebaseStorage.instance.ref("avatar/$imgName");
        await storageRef.putFile(imgPath!);
        urlImg = await storageRef.getDownloadURL();
      }

      await createNewUser();
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'weak-password') {
        showSnackBar(context,
            message: 'The password provided is too weak.', error: true);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context,
            message: 'The account already exists for that email.', error: true);
      } else {
        showSnackBar(context,
            message: 'Error , Please try again late', error: true);
      }
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

  Future<void> createNewUser() async {
    await UserFbController().createUser(getUser);
    showSnackBar(
      context,
      message: AppLocalizations.of(context)!.createAccountHasSuccessfully,
      error: false,
    );
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }

  UserModel get getUser {
    UserModel userModel = UserModel();
    userModel.uId = userCredential.user!.uid;
    userModel.username = usernameEditingController.text;
    userModel.title = titleEditingController.text;
    userModel.email = emailEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.avatar = urlImg ?? '';
    userModel.fcmToken = '';
    return userModel;
  }

  bool checkData() {
    if (usernameEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The username must be not empty.', error: true);
      return false;
    } else if (emailEditingController.text.isEmpty) {
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

