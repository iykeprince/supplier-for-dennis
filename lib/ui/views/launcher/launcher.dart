import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/auth/login/login.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';

import '../auth/signup/sign_up.dart';

class Launcher extends StatefulWidget {
  static const String ROUTE = '/launcher';
  const Launcher({Key key}) : super(key: key);

  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    clearPreferences();
    super.initState();
  }

  clearPreferences() async {
    SharedPreferences sharedPreferences = await _prefs;
    await sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Carousel(
                  boxFit: BoxFit.cover,
                  images: [
                    AssetImage('assets/images/heroImage.png'),
                    AssetImage('assets/images/image1.jpg'),
                    AssetImage('assets/images/image2.jpg'),
                    AssetImage('assets/images/image3.jpg'),
                    AssetImage('assets/images/image4.jpg')
                  ],
                  dotPosition: DotPosition.bottomCenter,
                  dotIncreaseSize: 2.0,
                  dotVerticalPadding: 50.0,
                  dotBgColor: Colors.white.withOpacity(0.0),
                  overlayShadowSize: 500.0,
                  overlayShadow: true,
                  overlayShadowColors: Colors.grey[600],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, .3),
                  ),
                  child: Center(
                    child: Container(
                      width: 300,
                      child: Text(
                        'Profile your business for free and get booked whenever you want',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Login.ROUTE);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.workSans(
                      fontSize: 22.0,
                      color: CustomColor.uplanitBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    print('sign up');
                    Navigator.pushNamed(context, SignUp.ROUTE);
                  },
                  title: 'Become A Supplier',
                  style: GoogleFonts.workSans(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
