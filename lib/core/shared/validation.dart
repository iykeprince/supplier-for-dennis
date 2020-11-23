import 'dart:async';

class Validator {
  final String value;
  final String error;

  Validator(this.value, this.error);

  static final validateFirstName =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (firstname, sink) {
      if (firstname.isNotEmpty) {
        sink.add(firstname);
      } else {
        sink.addError('Please enter your firstname');
      }
    },
  );

  static final validateLastName =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (lastname, sink) {
      if (lastname.isNotEmpty) {
        sink.add(lastname);
      } else {
        sink.addError('please enter your lastname');
      }
    },
  );

  static final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.isEmpty) {
        sink.addError('Please enter your email address');
      } else if (!email.contains('@')) {
        sink.addError('Email address is not valid');
      } else {
        sink.add(email);
      }
    },
  );

  static final validatePassword =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.isEmpty) {
        sink.addError('Please enter your password');
      } else if (password.length < 4) { 
        sink.addError('password is expected to be 4 character');
      } else {
        sink.add(password);
      }
    },
  );

  static final validateBusinessName =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name != null && name.length > 0) {
        sink.add(name);
      } else {
        sink.addError('Please enter your business name...');
      }
    },
  );

  static final validateDescription =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (description, sink) {
      if (description != null && description.length > 0) {
        sink.add(description);
      } else {
        sink.addError('Please describe your business...');
      }
    },
  );
}
