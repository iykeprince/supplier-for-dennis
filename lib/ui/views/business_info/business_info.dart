import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/viewmodels/business_info_model.dart';
import 'package:uplanit_supplier/core/viewmodels/business_profile_model.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uplanit_supplier/ui/views/business_profile/profile_image.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

class BusinessInfoPage extends StatelessWidget {
  static const String ROUTE = '/business_info/business_info';
  BusinessInfoModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<BusinessInfoModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    'Business information helps provide more information  about your business and company details. This information will be provided in invoices sent out from uplanit',
                    style: GoogleFonts.workSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left),
                SizedBox(height: 20),
                Text(
                  'What will you be trading as?',
                  style: GoogleFonts.workSans(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton<String>(
                  items: model.businessTypes.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: GoogleFonts.workSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ));
                  }).toList(),
                  onChanged: (String selectedBusinessType) {
                    model.setSelectedBusinessType(selectedBusinessType);
                  },
                  value: model.selectedBusinessType,
                ),
                // CustomTextField(
                //   keyboardType: TextInputType.text,
                //   color: Colors.black,
                // ),
                // SizedBox(height: 3),
                // Text(
                //   'This cannot be changed after initial selection',
                //   style: GoogleFonts.workSans(
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                // RegCompanyWidget(),
                model.isSoleTraderSelected == null ? Container() : FormWidget(),
                //End form
                SizedBox(height: 40),
                CustomButton(
                  onPressed: () => Navigator.pop(context),
                  title: 'Save',
                  style: GoogleFonts.workSans(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  FormWidget({
    Key key,
  }) : super(key: key);

  BusinessInfoModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<BusinessInfoModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        model.isSoleTraderSelected
            ? Container()
            : Text(
                'Registered Company Name',
                style: GoogleFonts.workSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
        model.isSoleTraderSelected
            ? Container()
            : StreamBuilder(
                stream: model.companyNameStream,
                builder: (context, snapshot) {
                  print(
                      'company name stream value: ${snapshot.data} or error: ${snapshot.error}}');
                  return CustomTextField(
                    keyboardType: TextInputType.text,
                    color: Colors.black,
                    value: snapshot.data,
                    onChanged: model.changeCompanyName,
                    errorText: snapshot.error,
                  );
                }),
        model.isSoleTraderSelected ? Container() : SizedBox(height: 20),
        model.isSoleTraderSelected
            ? Container()
            : Text(
                'Company Number',
                style: GoogleFonts.workSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
        model.isSoleTraderSelected
            ? Container()
            : StreamBuilder(
                stream: model.companyNumberStream,
                builder: (context, snapshot) {
                  print(
                      'company number stream value: ${snapshot.data} or error: ${snapshot.error}}');
                  return CustomTextField(
                    keyboardType: TextInputType.phone,
                    color: Colors.black,
                    value: snapshot.data,
                    onChanged: model.changeCompanyNumber,
                    errorText: snapshot.error,
                  );
                }),
        model.isSoleTraderSelected ? Container() : SizedBox(height: 20),
        Text(
          'Business Representative',
          style: GoogleFonts.workSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        StreamBuilder(
            stream: model.businessRepresentativeStream,
            builder: (context, snapshot) {
              print(
                  'business rep stream value: ${snapshot.data} or error: ${snapshot.error}}');
              return CustomTextField(
                keyboardType: TextInputType.text,
                color: Colors.black,
                title: snapshot.data,
                onChanged: model.changeBusinessRepresentative,
                errorText: snapshot.error,
              );
            }),
        SizedBox(height: 20),
        Text(
          'Contact Number',
          style: GoogleFonts.workSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        StreamBuilder(
            stream: model.contactNumberStream,
            builder: (context, snapshot) {
              print(
                  'contact number stream value: ${snapshot.data} or error: ${snapshot.error}}');

              return CustomTextField(
                keyboardType: TextInputType.text,
                color: Colors.black,
                title: snapshot.data,
                onChanged: model.changeContactNumber,
                errorText: snapshot.error,
              );
            }),
        SizedBox(height: 20),
        model.isSoleTraderSelected
            ? Container()
            : Text(
                'VAT Number',
                style: GoogleFonts.workSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
        model.isSoleTraderSelected
            ? Container()
            : StreamBuilder(
                stream: model.vatStream,
                builder: (context, snapshot) {
                  print(
                      'vat stream value: ${snapshot.data} or error: ${snapshot.error}}');
                  return CustomTextField(
                    keyboardType: TextInputType.text,
                    color: Colors.black,
                    onChanged: model.changeVat,
                    value: snapshot.data,
                    errorText: snapshot.error,
                  );
                }),
      ],
    );
  }
}
