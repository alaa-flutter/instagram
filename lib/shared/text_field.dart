import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key, required this.controller, required this.icon, required this.hint, this.inputType,
  }) : super(key: key);

   final TextEditingController controller;
   final IconData icon;
   final String hint;
   final TextInputType? inputType;

  /// late final TextInputAction? inputAction;
 /// late final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    ///  onChanged: onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            icon,
            size: 28,
            color: Colors.white,
          ),
        ),
        hintText: hint,
      ),
      keyboardType: inputType,
     /// textInputAction: inputAction,
    );
  }
}
