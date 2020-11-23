import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/enums/drawer_pages.dart';
import 'package:uplanit_supplier/core/models/portfolio/portfolio.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/viewmodels/drawer_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/custom_drawer.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:uplanit_supplier/ui/views/about/about.dart';
import 'package:uplanit_supplier/ui/views/business_profile/business_profile.dart';
import 'package:uplanit_supplier/ui/views/payment_provider/payment_provider.dart';
import 'package:uplanit_supplier/ui/views/portfolio/portfolio.dart';
import 'package:uplanit_supplier/ui/views/business_info/business_info.dart';
import 'package:uplanit_supplier/ui/views/team/team.dart';

class HomeView extends StatelessWidget {
  HomeView({
    Key key,
  }) : super(key: key);
//context.read<AuthenticationService>().logout(),
  DrawerModel drawerModel;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    drawerModel = Provider.of<DrawerModel>(context);
    print('actions: ${drawerModel.actions.length}');
    return Consumer<DrawerModel>(
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        appBar: profileAppBar(
          context: context,
          title: '${drawerModel.pageTitle}',
          onTapProfileIcon: () {
            print('open drawer');
            _scaffoldKey.currentState.openDrawer();
          },
          actions: model.actions,
        ),
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        body: getScreens(),
      ),
    );
  }

  getScreens() {
    switch (drawerModel.selectedDrawerPages) {
      case DrawerPages.BUSINESS_PROFILE:
        return BusinessProfile();
      case DrawerPages.BUSINESS_PORTFOLIO:
        return PortfolioPage();
      case DrawerPages.PAYMENT_PROVIDER:
        return PaymentProvider();
      case DrawerPages.BUSINESS_INFO:
        return BusinessInfoPage();
      case DrawerPages.TEAM:
        return TeamPage();
      default:
        {
          //  drawerModel.setDrawerPage(DrawerPages.BUSINESS_INFO);
          drawerModel.setPageTitle('Business Profile');
          return BusinessProfile();
        }
    }
  }
}
/*[
            FlatButton(
              onPressed: () => Navigator.pushNamed(
                context,
                About.ROUTE,
              ),
              child: Text(
                'About',
                style: GoogleFonts.workSans(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            )
          ]*/
