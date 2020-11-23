import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Color color;
  final String value;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String errorText;
  final double fontSize;

  const CustomTextField({
    Key key,
    this.controller,
    this.title,
    this.color,
    this.value,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.errorText,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(controller != null) controller.text = value;
    return TextField(
      onChanged: onChanged,
      obscureText: isPassword ? true : false,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: color == Colors.white ? Colors.white : Colors.black,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: color == null ? Colors.white : color,
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: color == null ? Colors.white : color,
              width: 1.0,
            ),
          ),
          hintText: this.title,
          labelText: this.title,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          errorText: errorText,
          errorStyle: GoogleFonts.workSans(
            fontSize: fontSize ?? 12,
            color: Colors.white,
          )),
    );
  }
}
