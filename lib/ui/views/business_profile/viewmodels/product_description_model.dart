import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class ProductDescriptionModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();
  final List<String> _myEventTypes = [];
  final String _eventType = null;
  bool _loading = false;
  BaseUserProfile _baseUserProfile;
  List<BaseCategory> _baseCategories;
  List<BaseEventType> _baseEventTypes = [];

  List get myEventTypes => _myEventTypes;
  String get eventType => _eventType;
  bool get loading => _loading;
  BaseUserProfile get baseUserProfile => _baseUserProfile;
  List<BaseCategory> get baseCategories => _baseCategories;
  List<BaseEventType> get baseEventTypes => _baseEventTypes;

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setBaseUserProfile(BaseUserProfile baseUserProfile) {
    _baseUserProfile = baseUserProfile;
    print('base user profile: $_baseUserProfile');
    notifyListeners();
  }

  void setCategories(List<BaseCategory> categories) {
    _baseCategories = categories;
    notifyListeners();
  }

  void setEventTypes(List<BaseEventType> eventTypes) {
    _baseEventTypes = eventTypes;
    notifyListeners();
  }

  Future<BaseUserProfile> updateProfile(
      {String name, String description}) async {
    String token = await auth.user.getIdToken();
    return await _businessProfileService.updateProfile(
      token: token,
      baseUserProfile: BaseUserProfile(name: name, description: description),
    );
  }

  void addEventType(String eventType) {
    _myEventTypes.add(eventType);
    notifyListeners();
  }
}
