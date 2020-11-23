import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadio extends StatelessWidget {
  final String group;
  final String title;
  final Color activeColor;
  final Function(Object) onRadioChanged;

  const CustomRadio({
    Key key,
    this.group,
    this.title,
    this.activeColor,
    this.onRadioChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio(
          value: true,
          groupValue: group,
          activeColor: activeColor,
          onChanged: onRadioChanged,
        ),
        Text(
          '$title',
          style: GoogleFonts.workSans(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
