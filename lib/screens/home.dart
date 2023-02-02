import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/lang_provider.dart';
import '../shared/color.dart';
import '../shared/enums.dart';
import '../shared_prefernces/shared_preferences.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
          widthScreen > 600 ? webBackgroundColor : mobileBackgroundColor,
      appBar: widthScreen > 600
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              title: SvgPicture.asset(
                'assets/images/instagram.svg',
                color: primaryColor,
                height: 32.h,
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      await Provider.of<LangProviders>(context, listen: false)
                          .changeLanguage();
                    },
                    icon: const Icon(Icons.language)),
              ],
            ),
      body: Container(
        decoration: BoxDecoration(
            color: mobileBackgroundColor,
            borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: widthScreen > 600 ? widthScreen / 4 : 0.w,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    child: Provider.of<AuthProvider>(context, listen: false)
                        .avatar_
                        .isNotEmpty
                        ? CircleAvatar(
                        radius: 20.w,
                        backgroundImage: NetworkImage(
                            Provider.of<AuthProvider>(context).avatar_))
                        : CircleAvatar(
                        radius: 20.w,
                        backgroundImage:
                        const AssetImage('assets/images/avatar.png')),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    ' ${SharedPreferencesController().getter(type: String, key: SpKeys.username)}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 17.sp,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
            Image.network(
              'https://imgs.search.brave.com/Yob7hRfgDKPDc04OyWfuk-7Sn6LRqn3eCflVvvHn9AY/rs:fit:844:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5S/RGMycHRrMXNFUi1j/YS04MEpIdTlnSGFF/SyZwaWQ9QXBp',
              height: heightScreen / 3,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 3.h,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.messenger_outline,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.save,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              width: double.infinity,
              child: const Text(
                '10 likes',
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              child: Row(
                children: [
                  Text(
                    'Aliaa noor',
                    style: TextStyle(fontSize: 14.sp, color: primaryColor),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    'Good Job',
                    style: TextStyle(fontSize: 12.sp, color: primaryColor),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                ///ToDo
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'view all 100 comment',
                  style: TextStyle(fontSize: 12.sp, color: primaryColor),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Text(
                '27 January 2023',
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
