import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../screens/add_post.dart';
import '../screens/favourite.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../screens/search.dart';
import '../shared/color.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final PageController _pageController = PageController();
  int page =0;
navigateToScreen(int index){
  _pageController.jumpToPage(index);
  setState(() {
    page = index;
  });
}
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor:
      widthScreen > 600 ? webBackgroundColor : mobileBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                navigateToScreen(0);
              },
              icon:  Icon(
                Icons.home,
                color:page==0?primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                navigateToScreen(1);
              },
              icon:  Icon(
                Icons.search,
                color:page==1?primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                navigateToScreen(2);
              },
              icon:  Icon(
                Icons.add_a_photo,
                color:page==2?primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                navigateToScreen(3);
              },
              icon:  Icon(
                Icons.favorite,
                color:page==3?primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                navigateToScreen(4);
              },
              icon:  Icon(
                Icons.person,
                color:page==4?primaryColor : secondaryColor,
              )),
        ],
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/images/instagram.svg',
          color: primaryColor,
          height: 32,
        ),
      ),
      body: PageView(
       controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
         print(index);
        },
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
