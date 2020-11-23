import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBadge extends StatelessWidget {
  final String title;
  const CustomBadge({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFBFC1CF),
      ),
      child: Text(
        '$title',
        style: GoogleFonts.workSans(
          fontSize: 12.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
