import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';
import 'package:uplanit_supplier/core/viewmodels/drawer_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

AppBar profileAppBar({
  @required String title,
  List<Widget> actions,
  Function onTapProfileIcon,
  @required BuildContext context,
}) {
  AuthenticationService auth = Provider.of<AuthenticationService>(context);
  
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: InkWell(
      onTap: onTapProfileIcon,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16.0,
          top: 8.0,
        ),
        width: 60,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: auth.user.photoURL != null ? NetworkImage(auth.user.photoURL) : AssetImage('assets/images/supplier.png'),
            ),
            Positioned(
              bottom: 0,
              right: -8,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Icon(
                  Icons.menu_outlined,
                  size: 24,
                  color: CustomColor.uplanitBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    title: Text(
      title,
      style: GoogleFonts.workSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: CustomColor.uplanitBlue,
      ),
    ),
    actions: actions != null && actions.length > 0
        ? actions.map((action) => action).toList()
        : [],
  );
}
