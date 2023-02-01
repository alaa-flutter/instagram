import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';

class ElevatedButtonWithIcon extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  const ElevatedButtonWithIcon({Key? key, required this.onPressed, required this.label, required this.backgroundColor, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return ElevatedButton.icon(
      onPressed:onPressed,
      icon:  Icon(
        icon,
        size: 24.0,
      ),
      label: Text(
        label,
        style: TextStyle(fontSize: 17.sp),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            backgroundColor),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
                 vertical:widthScreen>600 ? 16.h : 10.h, horizontal: 33.w)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: const BorderSide(
                color: Color.fromARGB(109, 255, 255, 255),
                // width: 1,
                style: BorderStyle.solid),
          ),
        ),
      ),
    );
  }
}
