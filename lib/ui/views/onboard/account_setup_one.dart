import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/models/onboard/onboard.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/core/viewmodels/onboard_model.dart';
import 'package:uplanit_supplier/ui/views/onboard/account_setup_two.dart';
import 'package:uplanit_supplier/ui/widgets/custom_indicators.dart';
import 'package:uplanit_supplier/ui/widgets/custom_plain_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AccountSetupOne extends StatelessWidget {
  static const String ROUTE = '/onboard/accountSetupOne';
  AccountSetupOne({Key key}) : super(key: key);

  OnboardModel onboardModel;

  @override
  Widget build(BuildContext context) {
    onboardModel = Provider.of<OnboardModel>(context);

    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        'Tell us about \nyour business',
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildForm(onboardModel),
                    //  Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          ),
          _buildIndicator(),
          StreamBuilder(
            stream: onboardModel.isNameDescriptionValid,
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
                        context.read<OnboardModel>().setState(ViewState.Busy);

                        Profile profile = await onboardModel.createProfile();

                        context.read<OnboardModel>().setState(ViewState.Idle);
                        print('profile: $profile');
                        if (profile != null) {
                          Navigator.pushNamed(context, AccountSetupTwo.ROUTE);
                        } else {
                          print('something went wrong tho');
                        }
                      },
                child: Center(
                  child: context.watch<OnboardModel>().state == ViewState.Busy
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
        ],
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            child: IconButton(
              onPressed: () {
                context.read<AuthenticationService>().logout();
              },
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

  _buildForm(OnboardModel onboardModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BUSINESS NAME',
          style: GoogleFonts.workSans(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        StreamBuilder(
          stream: onboardModel.nameStream,
          builder: (context, snapshot) => CustomPlainTextfield(
            errorText: snapshot.error,
            color: Colors.white,
            fontSize: 16,
            keyboardType: TextInputType.text,
            onChanged: onboardModel.onNameChanged,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'DESCRIBE YOUR BUSINESS',
          style: GoogleFonts.workSans(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        StreamBuilder(
          stream: onboardModel.descriptionStream,
          builder: (context, snapshot) => CustomTextArea(
            color: Colors.white,
            keyboardType: TextInputType.text,
            onChanged: onboardModel.onDescriptionChanged,
            errorText: snapshot.error,
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
          BorderedDot(),
          SizedBox(width: 2),
          SimpleLine(),
          SizedBox(width: 2),
          BorderedDot(),
          SizedBox(width: 2),
          SimpleLine(),
          SizedBox(width: 2),
          SimpleDot(),
        ],
      ),
    );
  }
}
