import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin SnackBarHelper {
  void showSnackBar(
      BuildContext context, {
        required String message,
        required bool error,
        int duration = 4,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor:
        error ? const Color(0xffff4d4f) : const Color(0xff52c41a),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ),
        margin: EdgeInsets.zero,
        elevation: 10,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
