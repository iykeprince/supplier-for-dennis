import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/models/onboard/onboard.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';
import 'package:uplanit_supplier/main.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/core/viewmodels/auth_model.dart';
import 'package:uplanit_supplier/ui/widgets/custom_indicators.dart';

import '../../onboard/account_setup_one.dart';

class SignUpPagerFinish extends StatefulWidget {
  static const String ROUTE = '/auth/signup/signUpPagerFinish';
  SignUpPagerFinish({Key key}) : super(key: key);

  @override
  _SignUpPagerFinishState createState() => _SignUpPagerFinishState();
}

class _SignUpPagerFinishState extends State<SignUpPagerFinish> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthenticationWrapper.ROUTE,
        (r) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String displayName = context.watch<AuthModel>().displayName;
    // Future.delayed(
    //   Duration(seconds: 5),
    //   () => AccountSetupOne.ROUTE,
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Welcome $displayName!',
                      style: GoogleFonts.workSans(
                        color: CustomColor.primaryColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Now, let us setup your business profile',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        color: CustomColor.primaryColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AccountSetupOne.ROUTE,
                      (r) => false
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: CustomColor.primaryColor,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Image.asset(
                          "assets/images/Vector.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildIndicator(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AccountSetupOne.ROUTE,
                );
              },
              child: Center(
                child: Text(
                  'Proceed to profile',
                  style: GoogleFonts.workSans(
                    fontSize: 22.0,
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderedDot(
            color: CustomColor.primaryColor,
          ),
          SizedBox(width: 2),
          SimpleLine(
            color: CustomColor.primaryColor,
          ),
          SizedBox(width: 2),
          BorderedDot(
            color: CustomColor.primaryColor,
          ),
          SizedBox(width: 2),
          SimpleLine(
            color: CustomColor.primaryColor,
          ),
          SizedBox(width: 2),
          SimpleDot(
            color: CustomColor.primaryColor,
          ),
        ],
      ),
    );
  }
}
