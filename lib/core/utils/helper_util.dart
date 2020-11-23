import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HelperUtil {
  static List<String> getTimes() {
    var x = 30; //minutes interval
    List<String> times = []; // time array
    var tt = 0; // start time

//loop to increment the time and push results in array
    for (var i = 0; tt < 24 * 60; i++) {
      var hh = (tt / 60).floor(); // getting hours of day in 0-24 format
      var mm = (tt % 60).floor(); // getting minutes of the hour in 0-55 format

      String time =
          ('${hh < 10 ? '0$hh' : hh}:${mm < 10 ? '0$mm' : mm}'); // pushing data in array in [00:00 - 12:00 AM/PM format]
      times.add(time);

      tt = tt + x;
    }

    return times;
  }

  static String leadingZero(int value) {
    return (value < 10) ? '0$value' : '$value';
  }

  static String capitalize(String string) {
    if (string == null) {
      throw ArgumentError.notNull('string');
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  static dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static showSnackBarError(BuildContext context) {
    // return Scaffold.of(context).showSnackBar(
    //   SnackBar(
    //     action: SnackBarAction(label: 'Close', onPressed: () {}),
    //     content:
    //         Text('An error occurred, please check your internet connection'),
    //   ),
    // );
    print('An error occurred, please check your internet connection');
  }
}
