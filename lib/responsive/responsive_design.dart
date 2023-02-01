import 'package:flutter/cupertino.dart';

class ResponsiveDesign extends StatefulWidget {
  final myWebScreen;
  final myMobileScreen;
  const ResponsiveDesign(
      {Key? key, required this.myWebScreen, required this.myMobileScreen})
      : super(key: key);

  @override
  State<ResponsiveDesign> createState() => _ResponsiveDesignState();
}

class _ResponsiveDesignState extends State<ResponsiveDesign> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext p0, BoxConstraints p1) {
        if (p1.maxWidth > 600) {
          return widget.myWebScreen;
        } else {
          return widget.myMobileScreen;
        }
      },
    );
  }
}
