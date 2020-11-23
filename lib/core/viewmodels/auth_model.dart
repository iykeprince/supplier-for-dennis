import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

import 'base_model.dart';

class AuthModel extends BaseModel {
  final BehaviorSubject<String> _firstNameController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _lastNameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  AuthenticationService auth = locator<AuthenticationService>();
  bool _showPassword = false;
  String _displayName = "";
  String _uid = "";

  Function(String) get onFirstNameChanged => _firstNameController.sink.add;
  Function(String) get onLastNameChanged => _lastNameController.sink.add;
  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;

  String get uid => _uid;
  String get displayName => _displayName;
  bool get showPassword => _showPassword;

  Stream<String> get firstNameStream =>
      _firstNameController.stream.transform(Validator.validateFirstName);
  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(Validator.validateLastName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(Validator.validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(Validator.validatePassword);

  Stream<bool> get isFirstLastNameValid =>
      Rx.combineLatest2(firstNameStream, lastNameStream, (a, b) => true);
      
  Stream<bool> get isEmailPasswordValid =>
      Rx.combineLatest2(emailStream, passwordStream, (c, d) => true);

  void togglePassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  setDisplayName(String displayName) {
    _displayName = displayName;
    notifyListeners();
  }

  setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  goToSignUpPagerTwo() {
    String firstname = _firstNameController.value.trim();
    String lastname = _lastNameController.value.trim();
    String displayName = '$firstname $lastname';
    setDisplayName(displayName);
  }

  Future<User> registerUserWithEmailAndPassword() async {
    String displayName = _displayName;
    String emailAddress = _emailController.value.trim();
    String password = _passwordController.value.trim();
    try {
      return auth.registerUserWithEmailAndPassword(
        displayName: displayName,
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
    }
  }

  @override
  void dispose() {
    _firstNameController.close();
    _lastNameController.close();
    _emailController.close();
    _passwordController.close();
    super.dispose();
  }
}
