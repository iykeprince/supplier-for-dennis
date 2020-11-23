import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';

class BaseModel extends ChangeNotifier {
  String _pageTitle = '';
  List<Widget> _actions = [];
  bool _isEditMode = false;
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  bool get isEditMode => _isEditMode;
  String get pageTitle => _pageTitle;
  List<Widget> get actions => _actions;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setPageTitle(String pageTitle) {
    _pageTitle = pageTitle;
    notifyListeners();
  }

  void addActions(Widget action) {
    _actions.clear();
    _actions.add(action);
    
    notifyListeners();
  }

  void toggleMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  Future<String> firebaseExceptionsHandler(FirebaseAuth auth, dynamic e) async {
    if (e.code == 'account-exists-with-different-credential') {
      // The account already exists with a different credential
      String email = e.email;
      AuthCredential pendingCredential = e.credential;

      // Fetch a list of what sign-in methods exist for the conflicting user
      List<String> userSignInMethods =
          await auth.fetchSignInMethodsForEmail(email);

      // If the user has several sign-in methods,
      // the first method in the list will be the "recommended" method to use.
      if (userSignInMethods.first == 'password') {
        // Prompt the user to enter their password
        String password = '...';

        // Sign the user in to their account with the password
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Link the pending credential with the existing account
        await userCredential.user.linkWithCredential(pendingCredential);

        // Success! Go back to your application flow
        return "true";
      }
    }
  }
}
