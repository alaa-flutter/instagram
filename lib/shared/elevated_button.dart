import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool isLoading;
  const MyElevatedButton({
    Key? key, required this.onPressed, required this.text, required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding:
        MaterialStateProperty.all(const EdgeInsets.all(12)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r))),
      ),
      child:  isLoading
          ? const CircularProgressIndicator()
          : Text(
        text,
        style: TextStyle(fontSize: 19.sp),
      ),
    );
  }
}