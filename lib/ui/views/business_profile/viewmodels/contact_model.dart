import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/business_profile/contact.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class ContactModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();

  bool _loading = false;
  Contact _contact;
  Contact _baseContact; //contact returned from the server
  String _error;

  String get error => _error;
  Contact get contact => _contact;
  Contact get baseContact => _baseContact;
  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  updateError(String error) {
    _error = error;
    notifyListeners();
  }

  void setContact(Contact contact) {
    _baseContact = contact;
    notifyListeners();
  }

  Future<Contact> updateContact() async {
    _loading = true;
    String instagram = instagramController.text.trim();
    String facebook = facebookController.text.trim();
    String linkedIn = linkedInController.text.trim();
    String website = websiteController.text.trim();
    String twitter = twitterController.text.trim();
    String phone = phoneController.text.trim();

    print(
        'phone: $phone, instagram: $instagram, facebook: $facebook, twitter: $twitter, linkedIn: $linkedIn, webs: $website');

    String token = await auth.user.getIdToken();
    return await _businessProfileService.createContact(
      token: token,
      contact: Contact(
        facebook: facebook,
        instagram: instagram,
        twitter: twitter,
        email: auth.user.email,
        website: website,
        phoneNumber: phone,
        linkedIn: linkedIn,
      ),
    );
  }
}
