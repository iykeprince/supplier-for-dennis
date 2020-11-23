import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const SocialButton({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: CustomColor.primaryColor,
            ),
            SizedBox(width: 30),
            Center(
              child: Text(
                '$title',
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  color: CustomColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
