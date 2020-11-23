import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';
import 'package:uplanit_supplier/core/viewmodels/onboard_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/core/viewmodels/auth_model.dart';
import 'package:uplanit_supplier/ui/widgets/custom_indicators.dart';
import 'package:uplanit_supplier/ui/widgets/custom_plain_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

import 'sign_up_pager_finish.dart';

class SignUpPagerTwo extends StatelessWidget {
  static const String ROUTE = '/auth/signup/signUpPagerTwo';
  SignUpPagerTwo({Key key}) : super(key: key);

  AuthModel authModel;

  @override
  Widget build(BuildContext context) {
    authModel = Provider.of<AuthModel>(context);
    String displayName =
        context.select<AuthModel, String>((value) => value.displayName);
    print('displayname: $displayName');
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Set your email \nand password',
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildForm(context),
                    //  Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          ),
          _buildIndicator(),
          Consumer<OnboardModel>(
            builder: (context, value, child) => StreamBuilder(
              stream: authModel.isEmailPasswordValid,
              builder: (context, snapshot) => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: !snapshot.hasData ? Colors.white70 : Colors.white,
                ),
                child: InkWell(
                  onTap: !snapshot.hasData
                      ? null
                      : () async {
                          HelperUtil.dismissKeyboard(context);
                          value.setState(ViewState.Busy);

                          User user = await authModel
                              .registerUserWithEmailAndPassword();

                          value.setState(ViewState.Idle);
                          if (user != null) {
                            Navigator.pushNamed(
                              context,
                              SignUpPagerFinish.ROUTE,
                            );
                          } else {
                            print('An error occurred');
                            // Scaffold.of(context).showSnackBar(
                            //   SnackBar(
                            //     action: SnackBarAction(label: 'Close', onPressed: () {}),
                            //     content: Text(
                            //         'An error occurred, please check your internet connection'),
                            //   ),
                            // );
                          }
                        },
                  child: Center(
                    child: value.state == ViewState.Busy
                        ? CustomProgressWidget()
                        : Text(
                            'Next',
                            style: GoogleFonts.workSans(
                              fontSize: 22.0,
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 40,
        left: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildForm(BuildContext context) {
    authModel = Provider.of<AuthModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ADD EMAIL ADDRESS',
          style: GoogleFonts.workSans(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        StreamBuilder(
            stream: authModel.emailStream,
            builder: (context, snapshot) => CustomPlainTextfield(
                  color: Colors.white,
                  errorText: snapshot.error,
                  fontSize: 16,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: authModel.onEmailChanged,
                )),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CREATE PASSWORD',
              style: GoogleFonts.workSans(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            InkWell(
              onTap: () => context.read<AuthModel>().togglePassword(),
              child: Text(
                !context.watch<AuthModel>().showPassword ? 'Show' : 'Hide',
                style: GoogleFonts.workSans(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        StreamBuilder(
          stream: authModel.passwordStream,
          builder: (context, snapshot) => CustomPlainTextfield(
            isPassword: !context.watch<AuthModel>().showPassword,
            color: Colors.white,
            errorText: snapshot.error,
            fontSize: 16,
            keyboardType: TextInputType.text,
            onChanged: authModel.onPasswordChanged,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _buildIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderedDot(
            color: Colors.white,
          ),
          SizedBox(width: 2),
          SimpleLine(),
          SizedBox(width: 2),
          SimpleDot(),
          SizedBox(width: 2),
          SimpleLine(),
          SizedBox(width: 2),
          SimpleDot(),
        ],
      ),
    );
  }
}
