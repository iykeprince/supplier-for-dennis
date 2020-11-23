import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/viewmodels/auth_model.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:uplanit_supplier/core/viewmodels/signin_model.dart';
import 'package:uplanit_supplier/ui/views/auth/forgot_password/forgot_pwd.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_finish.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_login_gf.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';
import 'package:uplanit_supplier/main.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static const String ROUTE = '/login';
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<SigninModel>(context);


    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 30),
              CustomLoginGF(
                onTap: () async {
                  User user = await context.read<AuthenticationService>().facebookSignIn(); 
                  if (user != null) {
                    Navigator.pushNamed(
                      context,
                      AuthenticationWrapper.ROUTE,
                    );
                  } else {
                    // _showSnackBarError(context);
                  }
                },
                title: 'Sign in with Facebook',
                images: 'assets/images/facebook.png',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomLoginGF(
                onTap: () async {
                  User user = await context
                      .read<AuthenticationService>()
                      .googleSignIn();

                  if (user != null) {
                    Navigator.pushNamed(
                      context,
                      AuthenticationWrapper.ROUTE,
                    );
                  } else {
                    // _showSnackBarError(context);
                  }
                },
                title: 'Sign in with Google',
                images: 'assets/images/google.png',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildText(),
              SizedBox(height: 20),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EMAIL',
                      style: GoogleFonts.workSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextField(
                      onChanged: validationService.validateEmail,
                      errorText: validationService.emailAddress.error,
                      keyboardType: TextInputType.emailAddress,
                      color: Colors.black,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'PASSWORD',
                      style: GoogleFonts.workSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextField(
                      onChanged: validationService.validatePword,
                      errorText: validationService.passWord.error,
                      title: '',
                      color: Colors.black,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => ForgotPwd());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<SigninModel>(
                      builder: (context, value, child) => Opacity(
                        opacity: !value.isValid ? .4 : 1,
                        child: value.state == ViewState.Busy
                            ? CircularProgressIndicator()
                            : CustomButton(
                                title: 'LOG IN',
                                style: GoogleFonts.workSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                onPressed: !value.isValid
                                    ? null
                                    : () async {
                                        User user = await value.submitData();

                                        if (user != null) {
                                          Navigator.pushNamed(
                                            context,
                                            SignUpPagerFinish.ROUTE,
                                          );
                                        } else {
                                          print('an error occurred');
                                        }
                                      },
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Image.asset(
              "assets/images/logo.png",
              height: 70.0,
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pushNamed(context, SignUp.ROUTE),
            child: Text(
              'Sign Up',
              style: GoogleFonts.workSans(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildText() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log in to continue',
              style: GoogleFonts.workSans(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
            )
          ]),
    );
  }

  // _buildForm() {
  //   TextEditingController _emailController = TextEditingController();
  //   TextEditingController _passwordController = TextEditingController();

  //   return Form(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'EMAIL',
  //           style: GoogleFonts.workSans(
  //             fontSize: 18.0,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         CustomTextField(
  //           error: ,
  //           title: '',
  //           color: Colors.black,
  //           controller: _emailController,
  //           keyboardType: TextInputType.emailAddress,
  //         ),
  //         SizedBox(height: 20),
  //         Text(
  //           'PASSWORD',
  //           style: GoogleFonts.workSans(
  //             fontSize: 18.0,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         CustomTextField(
  //           title: '',
  //           color: Colors.black,
  //           controller: _passwordController,
  //           keyboardType: TextInputType.text,
  //           isPassword: true,
  //         ),
  //         InkWell(
  //           onTap: () {},
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8.0),
  //             child: Text(
  //               'Forgot Password?',
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         CustomButton(
  //           title: 'LOG IN',
  //           style: GoogleFonts.workSans(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.white,
  //           ),
  //           onPressed: () {},
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         CustomLoginGF(
  //           title: 'Sign in with Google',
  //           images: 'assets/images/google.png',
  //           style: GoogleFonts.workSans(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.black,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         CustomLoginGF(
  //           title: 'Sign in with Google',
  //           images: 'assets/images/facebook.png',
  //           style: GoogleFonts.workSans(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
