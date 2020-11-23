import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class BusinessInfoModel extends BaseModel {
  List<String> businessTypes = [
    '--Select--',
    'A sole trader',
    'A registered Company'
  ];
  String _selectedBusinessType = '--Select--';
  String get selectedBusinessType => _selectedBusinessType;

  void setSelectedBusinessType(String businessType) {
    _selectedBusinessType = businessType;
    notifyListeners();
  }
}
