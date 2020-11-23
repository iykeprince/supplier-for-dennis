import 'package:uplanit_supplier/core/enums/drawer_pages.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class DrawerModel extends BaseModel {
  DrawerPages _selectedDrawerPage = DrawerPages.BUSINESS_PROFILE;
  DrawerPages get selectedDrawerPages => _selectedDrawerPage;

  void setDrawerPage(DrawerPages page) {
    _selectedDrawerPage = page;
    notifyListeners();
  }
  
}
