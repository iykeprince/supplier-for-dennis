import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplanit_supplier/core/utils/constant_util.dart';

main() {
  test('Shared preference will save data', () async {
    Map<String, dynamic> values = Map<String, dynamic>();
    values[DONE_ONBOARDING] = true;
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    SharedPreferences.setMockInitialValues(values);

    expect(_prefs.getBool(DONE_ONBOARDING), true);
  });
}
