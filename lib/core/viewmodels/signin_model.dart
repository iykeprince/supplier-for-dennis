import 'package:firebase_auth/firebase_auth.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class SigninModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  Validator _emailAddress = Validator(null, null);
  Validator _passWord = Validator(null, null);

  //getter
  Validator get emailAddress => _emailAddress;
  Validator get passWord => _passWord;
  bool get isValid {
    if (_emailAddress != null && _passWord != null) {
      return true;
    } else {
      return false;
    }
  }

  // setter
  void validateEmail(String value) {
    if (value.isNotEmpty) {
      _emailAddress = Validator(value, null);
    } else {
      _emailAddress = Validator(null, 'Please type in a valid email address');
    }
    notifyListeners();
  }

  void validatePword(String value) {
    if (value.isNotEmpty) {
      _passWord = Validator(value, null);
    } else {
      _passWord = Validator(value, 'Please type in your password');
    }
    notifyListeners();
  }

  Future<User> submitData() async {
    print('Email: ${emailAddress.value}, Password: ${passWord.value},');

    try {
      return auth.loginWithEmailAndPassword(
        email: emailAddress.value,
        password: passWord.value,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
