import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

class ContactHandle extends StatelessWidget {
  final IconData icon;
  final String handle;
  final String hint;
  final bool isEditMode;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const ContactHandle({
    Key key,
    this.icon,
    this.handle,
    this.hint,
    this.isEditMode,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = handle;
    return Row(
      children: [
        FaIcon(
          icon,
          color: CustomColor.socialMedia,
          size: 24,
        ),
        SizedBox(
          width: 4,
        ),
        !isEditMode
            ? Text(
                '${handle.isEmpty ? hint : handle}',
                style: GoogleFonts.workSans(
                  fontSize: 12,
                ),
              )
            : Expanded(
                child: Container(
                  child: CustomTextField(
                    controller: controller,
                    color: Colors.black,
                    fontSize: 12,
                    keyboardType: keyboardType,
                  ),
                ),
              ),
      ],
    );
  }
}
