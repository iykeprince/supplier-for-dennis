import 'package:uplanit_supplier/core/models/business_profile/base_work_time.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_work_time.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class WorkHourModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();

  final List<WorkTimeElement> workdays = [
    WorkTimeElement(id: "monday"),
    WorkTimeElement(id: "tuesday"),
    WorkTimeElement(id: "wednesday"),
    WorkTimeElement(id: "thursday"),
    WorkTimeElement(id: "friday"),
    WorkTimeElement(id: "saturday"),
    WorkTimeElement(id: "sunday")
  ];

  List<BaseWorkTime> _workTimes;
  List<WorkTimeElement> _selectedWorkdays = [];
  bool _loading = false;

  List<WorkTimeElement> get selectedWorkdays => _selectedWorkdays;
  bool get loading => _loading;
  List<BaseWorkTime> get workTimes => _workTimes;

  void setWorkTime(List<BaseWorkTime> workTimes) {
    _workTimes = workTimes;
    _selectedWorkdays.clear();
    if (_workTimes != null && _workTimes.length > 0)
      _workTimes.forEach((element) {
        if (element.times.open != null) {
          String open =
              '${HelperUtil.leadingZero(element.times.open.hour)}:${HelperUtil.leadingZero(element.times.open.minute)}';
          String close =
              '${HelperUtil.leadingZero(element.times.close.hour)}:${HelperUtil.leadingZero(element.times.close.minute)}';
          String id = element.id; //id is a day of the weekday
          _selectedWorkdays.add(WorkTimeElement(
            open: open,
            close: close,
            id: id,
          ));
        }
      });
    notifyListeners();
  }

  void addWorkday(WorkTimeElement workday) {
    _selectedWorkdays.add(workday);
    notifyListeners();
  }

  void removeWorkday(WorkTimeElement workday) {
    _workTimes.forEach((element) {
      if (element.id == workday.id) {
        element.valid = false;
        print('day worked on: ${element.id} == ${workday.id}');
      }
    });
    print('_selectedWorkdays length: ${_selectedWorkdays.length}');

    _selectedWorkdays.removeWhere((element) => element.id == workday.id);
    print('_selectedWorkdays length: ${_selectedWorkdays.length}');
    notifyListeners();
  }

  void setOpen(int index, String value) {
    selectedWorkdays[index].open = value;
    notifyListeners();
  }

  void setClose(int index, String value) {
    selectedWorkdays[index].close = value;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<List<BaseWorkTime>> updateWorkTime() async {
    String token = await auth.user.getIdToken();
    // print('selected workdays: $selectedWorkdays');
    // return [];
    return await _businessProfileService.updateWorkTime(
      token: token,
      workTimeObject: PostWorkTime(
        workTime: selectedWorkdays,
      ),
    );
  }
}
