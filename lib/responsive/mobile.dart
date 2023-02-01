import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../screens/add_post.dart';
import '../screens/favourite.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../screens/search.dart';
import '../shared/color.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int currentPage=0;
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CupertinoTabBar(
        onTap: (index){
          print('-------------- $index');
          _pageController.jumpToPage(index);
          setState(() {
            currentPage = index;
          });
        },
        backgroundColor: mobileBackgroundColor,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color:currentPage==0 ? primaryColor :secondaryColor,
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: currentPage==1 ? primaryColor :secondaryColor,
              ),
              label: AppLocalizations.of(context)!.search),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: currentPage==2 ? primaryColor :secondaryColor,
              ),
              label: AppLocalizations.of(context)!.add),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color:currentPage==3 ? primaryColor :secondaryColor,
              ),
              label: AppLocalizations.of(context)!.favourite),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: currentPage==4 ? primaryColor :secondaryColor,
              ),
              label: AppLocalizations.of(context)!.profile),
        ],
      ),
      body: PageView(
        onPageChanged: (index) {
          print("------- $index");
        },
      //  physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          HomePage(),
          Search(),
          AddPost(),
          Favourite(),
          Profile(),
        ],
      ),
    );
  }
}
