import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/enums/drawer_pages.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/viewmodels/drawer_model.dart';
import 'package:uplanit_supplier/main.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

class CustomDrawer extends StatelessWidget {
  DrawerModel drawerModel;
  CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    drawerModel = Provider.of<DrawerModel>(context);
    return ListView(
      children: [
        SizedBox(height: 54),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uplanit Ltd.',
                style: GoogleFonts.workSans(
                  fontSize: 24.0,
                  color: Color(0xFF27368E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.pin_drop_outlined,
                    color: CustomColor.drawerBlue,
                  ),
                  Text(
                    'Ikeja, Lagos',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      color: CustomColor.drawerBlue,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        profileItem(
          icon: Icons.grid_on_outlined,
          title: 'Overview',
          page: DrawerPages.OVERVIEW,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.OVERVIEW);
            drawerModel.setPageTitle('Overview');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Business Profile',
          page: DrawerPages.BUSINESS_PROFILE,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.BUSINESS_PROFILE);
            drawerModel.setPageTitle('Business Profile');
            
            Navigator.pop(context);
          },
        ),
        profileItem(
            icon: Icons.business_center_outlined,
            title: 'Business Portfolio',
            page: DrawerPages.BUSINESS_PORTFOLIO,
            onTap: () {
              drawerModel.setDrawerPage(DrawerPages.BUSINESS_PORTFOLIO);
              drawerModel.setPageTitle('Business Portfolio');
          
              Navigator.pop(context);
            }),
        profileItem(
          icon: Icons.chat,
          title: 'Messages',
          page: DrawerPages.MESSAGES,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.MESSAGES);
            drawerModel.setPageTitle('Messages');
            Navigator.pop(context);
          },
        ),
        Divider(
          color: Colors.grey.withOpacity(.2),
          thickness: 1,
        ),
        profileItem(
          icon: Icons.design_services_outlined,
          title: 'Service',
          page: DrawerPages.SERVICE,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.SERVICE);
            drawerModel.setPageTitle('Service');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.store_mall_directory_outlined,
          title: 'Store',
          page: DrawerPages.STORE,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.STORE);
            drawerModel.setPageTitle('Store');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.payment_outlined,
          title: 'Payment Plan',
          page: DrawerPages.PAYMENT_PLAN,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.PAYMENT_PLAN);
            drawerModel.setPageTitle('Payment Plan');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.book_online,
          title: 'Bookings',
          page: DrawerPages.BOOKINGS,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.BOOKINGS);
            drawerModel.setPageTitle('Bookings');
            Navigator.pop(context);
          },
        ),
        Divider(
          color: Colors.grey.withOpacity(.2),
          thickness: 1,
        ),
        profileItem(
          icon: Icons.calendar_today_outlined,
          title: 'Calendar',
          page: DrawerPages.CALENDAR,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.CALENDAR);
            drawerModel.setPageTitle('Calendar');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.people_alt_outlined,
          title: 'Team',
          page: DrawerPages.TEAM,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.TEAM);
            drawerModel.setPageTitle('Team');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.payments_outlined,
          title: 'Payment Provider',
          page: DrawerPages.PAYMENT_PROVIDER,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.PAYMENT_PROVIDER);
            drawerModel.setPageTitle('Payment Provider');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.business,
          title: 'Business Info',
          page: DrawerPages.BUSINESS_INFO,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.BUSINESS_INFO);
            drawerModel.setPageTitle('Business Info');
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 24,
        ),
        profileItem(
          icon: Icons.equalizer_outlined,
          title: 'Settings',
          page: DrawerPages.SETTINGS,
          onTap: () {
            drawerModel.setDrawerPage(DrawerPages.SETTINGS);
            drawerModel.setPageTitle('Settings');
            Navigator.pop(context);
          },
        ),
        profileItem(
          icon: Icons.logout,
          title: 'Log out',
          onTap: () async {
            await context.read<AuthenticationService>().logout();
            Navigator.popAndPushNamed(context, AuthenticationWrapper.ROUTE);
          },
        ),
      ],
    );
  }

  profileItem({IconData icon, String title, DrawerPages page, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: drawerModel.selectedDrawerPages == page
              ? Border(
                  left: BorderSide(
                    color: CustomColor.drawerBlue,
                    width: 4.0,
                  ),
                )
              : Border(
                  left: BorderSide(
                    color: Colors.transparent,
                    width: 4.0,
                  ),
                ),
          color: drawerModel.selectedDrawerPages == page
              ? CustomColor.drawerBlue.withOpacity(.4)
              : Colors.transparent,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Icon(
                icon,
                color: drawerModel.selectedDrawerPages == page
                    ? CustomColor.drawerBlue
                    : Colors.grey,
              ),
              SizedBox(width: 16),
              Text(
                '$title',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  color: drawerModel.selectedDrawerPages == page
                      ? CustomColor.drawerBlue
                      : Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ]),
      ),
    );
  }
}
