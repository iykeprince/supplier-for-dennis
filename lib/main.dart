import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplanit_calendar/uplanit_calendar.dart';
import 'package:uplanit_supplier/core/bloc/onboard_bloc.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';
import 'package:uplanit_supplier/core/utils/constant_util.dart';
import 'package:uplanit_supplier/core/viewmodels/business_info_model.dart';
import 'package:uplanit_supplier/core/viewmodels/category_provider.dart';
import 'package:uplanit_supplier/core/viewmodels/drawer_model.dart';
import 'package:uplanit_supplier/core/viewmodels/event_type_provider.dart';
import 'package:uplanit_supplier/core/viewmodels/payment_provider_model.dart';
import 'package:uplanit_supplier/core/viewmodels/portfolio_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/home_view.dart';
import 'package:uplanit_supplier/ui/views/launcher/launcher.dart';
import 'package:uplanit_supplier/ui/views/business_profile/business_profile.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'core/enums/api_response_type.dart';
import 'core/models/onboard/onboard.dart';
import 'core/repository/api.dart';
import 'core/utils/custom_router.dart';
import 'core/utils/locator.dart';
import 'core/viewmodels/auth_model.dart';
import 'core/viewmodels/business_profile_model.dart';
import 'core/viewmodels/onboard_model.dart';
import 'core/viewmodels/signin_model.dart';

import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/address_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/contact_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/product_description_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/profile_image_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/work_hour_model.dart';

import 'ui/views/onboard/account_setup_one.dart';
import 'ui/views/onboard/account_setup_two.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => locator<AuthenticationService>()),
        Provider<OnboardService>(create: (_) => locator<OnboardService>()),
        ChangeNotifierProvider(create: (_) => locator<AuthModel>()),
        ChangeNotifierProvider<SigninModel>(create: (_) => SigninModel()),
        ChangeNotifierProvider<OnboardModel>(create: (_) => OnboardModel()),
        ChangeNotifierProvider<BusinessProfileModel>(
            create: (_) => locator<BusinessProfileModel>()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider()),
        ChangeNotifierProvider<EventTypeProvider>(
            create: (_) => EventTypeProvider()),
        ChangeNotifierProvider<PortfolioModel>(
            create: (_) => locator<PortfolioModel>()),
        ChangeNotifierProvider<ProfileImageModel>(
          create: (_) => locator<ProfileImageModel>(),
        ),
        ChangeNotifierProvider<ProductDescriptionModel>(
            create: (_) => locator<ProductDescriptionModel>()),
        ChangeNotifierProvider<ContactModel>(
            create: (_) => locator<ContactModel>()),
        ChangeNotifierProvider<AddressModel>(
            create: (_) => locator<AddressModel>()),
        ChangeNotifierProvider<WorkHourModel>(
            create: (_) => locator<WorkHourModel>()),
        ChangeNotifierProvider<DrawerModel>(
            create: (_) => locator<DrawerModel>()),
        //payment provider
        ChangeNotifierProvider<PaymentProviderModel>(
            create: (_) => locator<PaymentProviderModel>()),

        //business info
        ChangeNotifierProvider<BusinessInfoModel>(
            create: (_) => locator<BusinessInfoModel>()),

        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
        FutureProvider<SharedPreferences>(
          create: (context) => SharedPreferences.getInstance(),
          catchError: (context, error) {
            print('$error');
            return null;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Uplanit Supplier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        onGenerateRoute: CustomRouter.onGenerateRoute,
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  static const String ROUTE = '/';
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool doneOnboarding = false;
  OnboardBloc _onboardBloc;
  SharedPreferences _pref;
  @override
  void initState() {
    _onboardBloc = OnboardBloc();

    _initPrefs();
    super.initState();
  }

  _initPrefs() async {
    SharedPreferences pref =
        Provider.of<SharedPreferences>(context, listen: false);
    if (pref != null) {
      doneOnboarding = pref.getBool(DONE_ONBOARDING);
      print('onboard shared preference check: $doneOnboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final User firebaseUser = context.watch<User>();
    print('done onboarding preference: $doneOnboarding');

    return Scaffold(
      body: firebaseUser == null
          ? Launcher()
          : doneOnboarding
              ? BusinessProfile()
              : StreamBuilder<ApiResponse<Onboard>>(
                  stream: _onboardBloc.onboardServiceStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<ApiResponse<Onboard>> snapshot) {
                    if (snapshot.hasData) {
                      ApiResponseStatus status = snapshot.data.status;
                      if (status == ApiResponseStatus.LOADING)
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomProgressWidget(),
                            SizedBox(height: 16),
                            Text('Please wait...'),
                          ],
                        );
                      if (status == ApiResponseStatus.COMPLETED) {
                        Onboard onboard = snapshot.data.data;
                        if (onboard == null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Something went wrong with the network',
                                  style: GoogleFonts.workSans(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AuthenticationWrapper.ROUTE,
                                        (route) => false);
                                  },
                                  child: Text('Refresh'))
                            ],
                          );
                        }
                        if (onboard.profile == null)
                          return AccountSetupOne();
                        else if (onboard.categories == null)
                          return AccountSetupTwo();
                        else if (onboard.eventTypes == null)
                          return AccountSetupTwo(
                            isShowDialog: true,
                          );
                        else
                          return HomeView();
                      }
                    }
                    return CustomProgressWidget();
                  },
                ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _onboardBloc.dispose();
  }
}
