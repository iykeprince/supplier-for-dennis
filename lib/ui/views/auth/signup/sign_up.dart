import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';

import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/core/viewmodels/auth_model.dart';
import 'package:uplanit_supplier/ui/views/auth/login/login.dart';
import 'package:uplanit_supplier/ui/widgets/social_button.dart';

import 'sign_up_pager_finish.dart';
import 'sign_up_pager_one.dart';

class SignUp extends StatelessWidget {
  static const String ROUTE = '/auth/signup/signUp';
  const SignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  _buildOptions(context),
                ],
              ),
            ),
            Container(
              width: 240,
              child: RichText(
                text: TextSpan(
                  text: 'Creating an account with us means you agree with our ',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' and '),
                    TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // margin: EdgeInsets.only(top: 12),
              // child: Image.asset("assets/images/logo-w.png"),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, Login.ROUTE),
              child: Text(
                'Sign in',
                style: GoogleFonts.workSans(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildOptions(BuildContext context) {
    // final AuthModel authModel = locator<AuthModel>();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Center(
            child: Text(
              'Welcome to Uplanit',
              style: GoogleFonts.workSans(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 20),
          SocialButton(
            icon: FontAwesomeIcons.facebookSquare,
            title: 'Sign up with Facebook',
            onTap: () async {
              User user =
                  await context.read<AuthenticationService>().facebookSignIn();
              if (user != null) {
                context.read<AuthModel>().setDisplayName(user.displayName);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignUpPagerFinish.ROUTE,
                  (r) => false,
                );
              } else {
                _showSnackBarError(context);
              }
            },
          ),
          SizedBox(height: 20),
          SocialButton(
            icon: FontAwesomeIcons.googlePlusSquare,
            title: 'Sign up with Google',
            onTap: () async {
              User user =
                  await context.read<AuthenticationService>().googleSignIn();

              if (user != null) {
                context.read<AuthModel>().setDisplayName(user.displayName);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignUpPagerFinish.ROUTE,
                  (r) => false,
                );
              } else {
                _showSnackBarError(context);
              }
            },
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () => Navigator.pushNamed(context, SignUpPagerOne.ROUTE),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Create Account',
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Other options',
                style: GoogleFonts.workSans(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showSnackBarError(BuildContext context) {
    // return Scaffold.of(context).showSnackBar(
    //   SnackBar(
    //     action: SnackBarAction(label: 'Close', onPressed: () {}),
    //     content:
    //         Text('An error occurred, please check your internet connection'),
    //   ),
    // );
    print('An error occurred, please check your internet connection');
  }
}
