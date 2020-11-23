import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Color color;
  final String value;
  final Function validator;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String errorText;
  final int maxLines;

  const CustomTextArea({
    Key key,
    this.controller,
    this.title,
    this.color,
    this.value,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.errorText,
    this.maxLines = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: color == Colors.white ? Colors.white : Colors.black,
        fontSize: 22,
      ),
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        errorText: errorText,
        errorStyle: GoogleFonts.workSans(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
