import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared/color.dart';
import '../shared/elevated_button_icon.dart';
import '../shared_prefernces/shared_preferences.dart';
import 'auth/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: const Text('Alaa kakawi'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(start: 16.w),
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: CircleAvatar(
                  radius: 36.w,
                  backgroundImage: const NetworkImage(
                    'https://imgs.search.brave.com/Yob7hRfgDKPDc04OyWfuk-7Sn6LRqn3eCflVvvHn9AY/rs:fit:844:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5S/RGMycHRrMXNFUi1j/YS04MEpIdTlnSGFF/SyZwaWQ9QXBp',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          AppLocalizations.of(context)!.posts,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 17.w,
                    ),
                    Column(
                      children: [
                        Text(
                          "8",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          AppLocalizations.of(context)!.followers,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 17.w,
                    ),
                    Column(
                      children: [
                        Text(
                          "15",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          AppLocalizations.of(context)!.following,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: double.infinity,
              margin: EdgeInsetsDirectional.only(start: 16.w),
              child: Text(
                  'Flutter',
              ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(
            height: 1.h,
            color: Colors.white,
            thickness: 0.05,
          ),
          SizedBox(height: 12.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButtonWithIcon(
                onPressed: () {  },
                label: 'Edit Profile',
                icon: Icons.edit,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 8.w,),
              ElevatedButtonWithIcon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await FirebaseMessaging.instance.deleteToken();
                  await FirebaseMessaging.instance.unsubscribeFromTopic('updates');
                  await SharedPreferencesController().logout();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                label: 'Log Out',
                icon: Icons.logout,
                backgroundColor: const Color.fromARGB(255, 255, 129, 129),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Divider(
            height: 1.h,
            color: Colors.white,
            thickness: 0.05,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: 60,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: Image.network(
                        "https://cdn1-m.alittihad.ae/store/archive/image/2021/10/22/6266a092-72dd-4a2f-82a4-d22ed9d2cc59.jpg?width=1300",
                        // height: 333,
                        // width: 100,

                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          ),

        ],
      ),
    );
  }
}
