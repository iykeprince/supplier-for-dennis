import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_work_time.dart';
import 'package:uplanit_supplier/core/models/business_profile/contact.dart';
import 'package:uplanit_supplier/core/models/business_profile/cover_image.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';
import 'package:uplanit_supplier/core/viewmodels/category_provider.dart';
import 'package:uplanit_supplier/core/viewmodels/event_type_provider.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/address_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/contact_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/product_description_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/profile_image_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/work_hour_model.dart';

class BusinessProfileModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();

  ProfileImageModel profileImageModel = locator<ProfileImageModel>();
  ProductDescriptionModel productDescriptionModel =
      locator<ProductDescriptionModel>();
  AddressModel addressModel = locator<AddressModel>();
  ContactModel contactModel = locator<ContactModel>();
  WorkHourModel workHourModel = locator<WorkHourModel>();
  CategoryProvider categoryProvider = locator<CategoryProvider>();
  EventTypeProvider eventTypeProvider = locator<EventTypeProvider>();

  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();

  BaseProfile _baseProfile = locator<BaseProfile>();
  BaseProfile get baseProfile => _baseProfile;

  BusinessProfileModel() {
    getBaseProfile();
  }

  Future<void> getBaseProfile() async {
    String token = await auth.user.getIdToken();
    BaseProfile _baseProfile =
        await _businessProfileService.getBaseProfile(token: token);
    if (_baseProfile != null) {
      print('profile is available}');
      updateProfileCoverImage(_baseProfile.cover);
      updateProfileLogoImage(_baseProfile.logo);
      updateBaseUserProfile(_baseProfile.profile);
      updateBaseCategories(_baseProfile.categories);
      updateBaseEventTypes(_baseProfile.eventTypes);
      updateBaseAddress(_baseProfile.address);
      updateBaseDeliveryBounds(_baseProfile.deliveryBounds);
      updateBaseContact(_baseProfile.contact);
      updateWorkTime(_baseProfile.workTime);
    }
    notifyListeners();
  }

  void updateBaseUserProfile(BaseUserProfile baseUserProfile) {
    if (baseUserProfile != null)
      productDescriptionModel.setBaseUserProfile(baseUserProfile);
  }

  void updateBaseCategories(List<BaseCategory> categories,
      {bool listen: false}) {
    if (categories != null) {
      productDescriptionModel.setCategories(categories);
    }
    if (listen) {
      notifyListeners();
    }
  }

  void updateBaseEventTypes(List<BaseEventType> eventTypes,
      {bool listen: false}) {
    if (eventTypes != null) {
      productDescriptionModel.setEventTypes(eventTypes);
    }
    if (listen) {
      notifyListeners();
    }
  }

  void updateBaseAddress(BaseAddress address) {
    if (address != null) {
      addressModel.setAddress(address);
    }
    ;
  }

  void updateBaseDeliveryBounds(BaseDeliveryBounds deliveryBounds) {
    if (deliveryBounds != null) {
      addressModel.setDeliveryBounds(deliveryBounds);
    }
  }

  void updateBaseContact(Contact contact) {
    if (contact != null) contactModel.setContact(contact);
  }

  void updateWorkTime(List<BaseWorkTime> workTimes) {
    if (workTimes != null && workTimes.length > 0)
      workHourModel.setWorkTime(workTimes);
  }

  void updateProfileCoverImage(CoverImage cover) {
    if (cover != null) {
      profileImageModel.setCoverImage(cover);
    }
  }

  void updateProfileLogoImage(CoverImage logo) {
    if (logo != null) {
      profileImageModel.setLogoImage(logo);
    }
  }
}
