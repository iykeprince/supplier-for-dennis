import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/models/default_response.dart';
import 'package:uplanit_supplier/core/models/payment_provider/stripe_response.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/viewmodels/payment_provider_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_browser.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/ui/views/payment_provider/payment_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';

class PaymentProvider extends StatelessWidget {
  static const String ROUTE = '/payment_providerr/payment_provider';
  PaymentProviderModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<PaymentProviderModel>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
            child: RichText(
              text: TextSpan(
                  text:
                      'Payment providers help you process card payments and\n',
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'manage your financials. We currently support two',
                    ),
                    TextSpan(
                      text: ' payment providers',
                    ),
                    TextSpan(
                        text: ' Stripe', style: TextStyle(color: Colors.red)),
                    TextSpan(text: ' and'),
                    TextSpan(
                        text: ' paypal', style: TextStyle(color: Colors.red))
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Default Currency:',
              style: GoogleFonts.workSans(
                  fontSize: 14.0, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          Text('United States - United State Dollars',
              style: GoogleFonts.workSans(
                  fontSize: 14.0, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: PaymentButton(
              onTap: model.connectingStripe
                  ? null
                  : () async {
                      if (model.isConnectStripe != null &&
                          !model.isConnectStripe) {
                        print('stripe payment');
                        model.setConnectingStripe(true);
                        String code = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomBrowser()),
                        );
                        if (code != null) {
                          String value =
                              code.split('=')[1]; //value to send to stripe

                          DefaultResponse response =
                              await model.addStripeDetail(value);
                          model.setConnectingStripe(false);
                          if (response != null && response.name == 'SUCCESS') {
                            model.connectStripe();
                          } else {
                            model.setErrorMessage(response.message);
                          }
                        }
                      } else {
                        model.setConnectingStripe(true);
                        DefaultResponse response =
                            await model.deleteStripeConnect();
                        //TODO: show toast
                        model.setConnectingStripe(false);
                        model.disconnectStripe();
                      }
                    },
              color: model.isConnectStripe == null
                  ? Colors.grey
                  : model.connectingStripe
                      ? Colors.transparent
                      : model.isConnectStripe
                          ? Colors.black87
                          : Color(0xff27368e),
              image: Image.asset('assets/images/stripe.png'),
              text: model.connectingStripe
                  ? CustomProgressWidget()
                  : Text(
                      model.isConnectStripe == null
                          ? 'loading...'
                          : model.isConnectStripe
                              ? 'Disconnect Stripe'
                              : 'Connect with Stripe',
                      style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          model.errorMessage != null
              ? Text(
                  '${model.errorMessage}',
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 35.0, right: 35.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 30.0,
                      child: Divider(thickness: 1.0, color: Colors.black)),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Or', textAlign: TextAlign.left),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(child: Divider(thickness: 1.0, color: Colors.black))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: PaymentButton(
                color: Colors.grey.shade400,
                image: Image.asset('assets/images/paypal.png'),
                text: Text(
                  'Coming soon',
                  style: GoogleFonts.workSans(
                      color: Color(0xff27368e),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}
