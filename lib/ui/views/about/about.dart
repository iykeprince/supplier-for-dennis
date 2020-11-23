import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class About extends StatefulWidget {
  static const String ROUTE = '/about/about';
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          'About',
          style: GoogleFonts.workSans(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            Row(
              children: [
                Image.asset('assets/images/UPlanit.png'),
                Text(
                  'UPlanit',
                  style: GoogleFonts.workSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFC20370),
                  ),
                ),
              ],
            ),
            
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Business information helps procide more information about your business and company detils. This information will be provided in invoices sent out from uplanit',
              style: GoogleFonts.workSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Color(0xFF161F51),
                      size: 24,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Color(0xFF161F51),
                      size: 24,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.mailBulk,
                      color: Color(0xFF161F51),
                      size: 24,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Color(0xFF161F51),
                      size: 24,
                    ),
                    onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
