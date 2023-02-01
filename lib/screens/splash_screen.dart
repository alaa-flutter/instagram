import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../responsive/mobile.dart';
import '../responsive/responsive_design.dart';
import '../responsive/web.dart';
import '../shared/color.dart';
import '../shared/enums.dart';
import '../shared_prefernces/shared_preferences.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigate() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => (SharedPreferencesController()
                    .getter(type: bool, key: SpKeys.loggedIn)) ==
                true
            ? const ResponsiveDesign(myWebScreen: WebScreen(), myMobileScreen: MobileScreen(),)
            : const Login(),
      ));
    });
  }




  Future<void> init() async {
    await navigate();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/instagram.svg',
          color: primaryColor,
          height: 32.h,
        ),
      ),
    );
  }
}
