import 'package:get_it/get_it.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';
import 'package:uplanit_supplier/core/services/payment_provider_service.dart';
import 'package:uplanit_supplier/core/services/portfolio_service.dart';
import 'package:uplanit_supplier/core/viewmodels/auth_model.dart';
import 'package:uplanit_supplier/core/viewmodels/business_profile_model.dart';
import 'package:uplanit_supplier/core/viewmodels/category_provider.dart';
import 'package:uplanit_supplier/core/viewmodels/drawer_model.dart';
import 'package:uplanit_supplier/core/viewmodels/event_type_provider.dart';
import 'package:uplanit_supplier/core/viewmodels/payment_provider_model.dart';
import 'package:uplanit_supplier/core/viewmodels/portfolio_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/address_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/contact_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/product_description_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/work_hour_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/profile_image_model.dart';

// This is our global ServiceLocator
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => OnboardService());
  locator.registerLazySingleton(() => BusinessProfileService());
  locator.registerLazySingleton(() => PortfolioService());
  locator.registerLazySingleton(() => PaymentProviderService());

  locator.registerFactory(() => BusinessProfileModel());
  locator.registerFactory(() => PortfolioModel());
  locator.registerFactory(() => PaymentProviderModel());
  //
  locator.registerLazySingleton(() => CategoryProvider());
  locator.registerLazySingleton(() => EventTypeProvider());

  //drawer
  locator.registerLazySingleton(() => DrawerModel());

  //Register Business Profile View Models
  locator.registerLazySingleton(() => WorkHourModel());
  locator.registerLazySingleton(() => ProfileImageModel());
  locator.registerLazySingleton(() => ProductDescriptionModel());
  locator.registerLazySingleton(() => AddressModel());
  locator.registerLazySingleton(() => ContactModel());

  locator.registerFactory(() => AuthModel());
  locator.registerFactory(() => BaseProfile());
  locator.registerFactory(() => ApiRepository());
}
