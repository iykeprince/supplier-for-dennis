import 'package:flutter/material.dart';
import 'package:uplanit_supplier/ui/views/about/about.dart';
import 'package:uplanit_supplier/ui/views/auth/login/login.dart';
import 'package:uplanit_supplier/ui/views/business_profile/business_profile.dart';
import 'package:uplanit_supplier/ui/views/onboard/account_setup_one.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_finish.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_one.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_two.dart';
import 'package:uplanit_supplier/ui/views/launcher/launcher.dart';
import 'package:uplanit_supplier/ui/views/onboard/account_setup_two.dart';
import 'package:uplanit_supplier/ui/views/onboard/all_done.dart';
import 'package:uplanit_supplier/ui/views/business_info/business_info.dart';
import 'package:uplanit_supplier/ui/views/portfolio/portfolio.dart';
import 'package:uplanit_supplier/ui/views/team/team.dart';
import 'package:uplanit_supplier/ui/views/team/team_detail.dart';

import '../../main.dart';

class CustomRouter {
  static Route<Widget> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthenticationWrapper.ROUTE:
        return MaterialPageRoute(builder: (_) => AuthenticationWrapper());
      case Launcher.ROUTE:
        return MaterialPageRoute(builder: (_) => Launcher());
      case Login.ROUTE:
        return MaterialPageRoute(builder: (_) => Login());
      case SignUp.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUp());
      case SignUpPagerOne.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUpPagerOne());
      case SignUpPagerTwo.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUpPagerTwo());
      case SignUpPagerFinish.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUpPagerFinish());
      case AccountSetupOne.ROUTE:
        return MaterialPageRoute(builder: (_) => AccountSetupOne());
      case AccountSetupTwo.ROUTE:
        return MaterialPageRoute(builder: (_) => AccountSetupTwo());
      case AllDone.ROUTE:
        return MaterialPageRoute(builder: (_) => AllDone());
//Business profile
      case BusinessProfile.ROUTE:
        return MaterialPageRoute(builder: (_) => BusinessProfile());
      case PortfolioPage.ROUTE:
        return MaterialPageRoute(builder: (_) => PortfolioPage());
      case BusinessInfoPage.ROUTE:
        return MaterialPageRoute(builder: (_) => BusinessInfoPage());

      case TeamDetailPage.ROUTE:
        return MaterialPageRoute(builder: (_) => TeamDetailPage());
      case About.ROUTE:
        return MaterialPageRoute(builder: (_) => About());


      default:
        return null;
    }
  }
}
