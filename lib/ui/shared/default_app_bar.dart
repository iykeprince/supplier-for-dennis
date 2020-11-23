import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar defaultAppBar({
  @required BuildContext context,
  @required String title,
  List<Widget> actions,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    ),
    title: Text(
      '$title',
      style: GoogleFonts.workSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    actions: actions != null && actions.length > 0
        ? actions.map((action) => action).toList()
        : [],
  );
}
