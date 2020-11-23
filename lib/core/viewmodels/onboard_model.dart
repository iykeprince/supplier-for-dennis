import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/models/onboard/onboard.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

import 'base_model.dart';

class OnboardModel extends BaseModel {
  OnboardService onboardService = OnboardService();
  AuthenticationService auth = locator<AuthenticationService>();

  final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _descriptionController =
      BehaviorSubject<String>();

  Function(String) get onNameChanged => _nameController.sink.add;
  Function(String) get onDescriptionChanged => _descriptionController.sink.add;

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validator.validateBusinessName);
  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validator.validateDescription);

  Stream<bool> get isNameDescriptionValid =>
      Rx.combineLatest2(nameStream, descriptionStream, (String c, String d) {
        print('c: $c');
        print('d: $d');
        return true;
      });

  String get name => _nameController.value.trim();
  String get description => _descriptionController.value.trim();

  @override
  void dispose() {
    _nameController.close();
    _descriptionController.close();
    super.dispose();
  }

  Future<Profile> createProfile() async {
    String idToken = await auth.user.getIdToken();

    return onboardService.createProfile(
      body: Profile(
        name: name,
        description: description,
      ),
      token: idToken,
    );
  }
}
