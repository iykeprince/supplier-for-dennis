import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/models/business_profile/contact.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';

import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

import 'viewmodels/contact_model.dart';
import 'widgets/round_edit_button.dart';
import 'widgets/contact_handle.dart';

class ContactView extends StatelessWidget {
  final bool isEditMode;
  
  ContactView({
    Key key,
    this.isEditMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<ContactModel>(
        builder: (context, model, child) => Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 8,
                  bottom: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contact',
                      style: GoogleFonts.workSans(
                        fontSize: 16.0,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    model.isEditMode
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                RaisedButton(
                                  color: CustomColor.primaryColor,
                                  onPressed: model.loading
                                      ? null
                                      : () async {
                                        HelperUtil.dismissKeyboard(context);
                                          model.setLoading(true);
                                          if (model
                                              .phoneController.text.isEmpty) {
                                            model.updateError(
                                                'Phone number is required! Phone number been updated!');
                                            model.setLoading(false);
                                            return;
                                          }
                                          model.updateError('');
                                          Contact contact =
                                              await model.updateContact();
                                          
                                          model.setContact(contact);
                                          model.setLoading(false);
                                          model.toggleMode();
                                        },
                                  child: model.loading
                                      ? Center(
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Update',
                                          style: GoogleFonts.workSans(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ),
                                RaisedButton(
                                  onPressed: model.toggleMode,
                                  child: Container(
                                    color: Colors.grey.shade300,
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Back',
                                      style: GoogleFonts.workSans(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ])
                        : RoundEditButton(
                            onTap: model.toggleMode,
                          ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 8,
                  bottom: 4,
                ),
                child: Text(
                  model.error ?? '',
                  style: GoogleFonts.workSans(
                    fontSize: 13,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 8,
                  bottom: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContactHandle(
                            handle: model.baseContact != null
                                ? model.baseContact.phoneNumber
                                : '',
                            hint: model.baseContact == null || model.baseContact.phoneNumber.isEmpty ? 'update phone' : '',
                            icon: FontAwesomeIcons.phoneSquare,
                            isEditMode: model.isEditMode,
                            controller: model.phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          ContactHandle(
                            handle: model.baseContact != null
                                ? model.baseContact.instagram
                                : "",
                            hint: model.baseContact == null || model.baseContact.instagram.isEmpty ? 'update instagram' : '',
                            icon: FontAwesomeIcons.instagramSquare,
                            isEditMode: model.isEditMode,
                            controller: model.instagramController,
                            keyboardType: TextInputType.text,
                          ),
                          ContactHandle(
                            handle: model.baseContact != null
                                ? model.baseContact.linkedIn
                                : "",
                            hint: model.baseContact == null || model.baseContact.linkedIn.isEmpty ? 'update linkedin' : '',
                            icon: FontAwesomeIcons.linkedin,
                            isEditMode: model.isEditMode,
                            controller: model.linkedInController,
                            keyboardType: TextInputType.text,
                          ),
                          ContactHandle(
                            handle: model.baseContact != null
                                ? model.baseContact.website
                                : "",
                            hint: model.baseContact == null || model.baseContact.website.isEmpty ? 'update website' : '',
                            icon: FontAwesomeIcons.dribbbleSquare,
                            isEditMode: model.isEditMode,
                            controller: model.websiteController,
                            keyboardType: TextInputType.url,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContactHandle(
                            handle: model.baseContact != null
                                ? model.baseContact.facebook
                                : "",
                            hint: model.baseContact == null || model.baseContact.facebook.isEmpty ? 'update facebook' : '',
                            icon: FontAwesomeIcons.facebookSquare,
                            isEditMode: model.isEditMode,
                            controller: model.facebookController,
                            keyboardType: TextInputType.text,
                          ),
                          ContactHandle(
                            handle: model.baseContact != null
                                ? model.baseContact.twitter
                                : "",
                            hint: model.baseContact == null || model.baseContact.twitter.isEmpty ? 'update twitter' : '',
                            icon: FontAwesomeIcons.twitterSquare,
                            isEditMode: model.isEditMode,
                            controller: model.twitterController,
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      );
  }
}
/*/ setState(() {
      // });
      _height = height;
      final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
      RenderObject renderObject;
      
      print('KEY: actual height: $_height');

      print(
          "KEY: SIZE of Red: ${renderBoxRed.size.height}, ${renderBoxRed.size.width}");
          */
