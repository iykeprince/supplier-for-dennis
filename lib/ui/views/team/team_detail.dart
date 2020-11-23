import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_calendar/uplanit_calendar.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_radio.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

class TeamDetailPage extends StatelessWidget {
  static const String ROUTE = '/team/team_detail';
  const TeamDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Jonathan Jones',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
              child: SizedBox(
                child: UplanitCalendarView(),
              ),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 100,
                      child: Image.asset('assets/images/team_img.png'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Name',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextField(
                    color: Colors.black54,
                    keyboardType: TextInputType.text,
                    fontSize: 14.0,
                    title: 'Jonathan Jones',
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: GoogleFonts.workSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomRadio(
                        group: 'gender',
                        title: 'Male',
                        activeColor: CustomColor.uplanitBlue,
                        onRadioChanged: (value) {},
                      ),
                      SizedBox(width: 4),
                      CustomRadio(
                        group: 'gender',
                        title: 'Female',
                        activeColor: CustomColor.uplanitBlue,
                        onRadioChanged: (value) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bio',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextArea(
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Active',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  CustomButton(
                    title: 'Update',
                    style: GoogleFonts.workSans(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Linked Service',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Wrap(
                    children: [
                      Chip(
                        backgroundColor: Colors.black,
                        clipBehavior: Clip.antiAlias,
                        deleteButtonTooltipMessage: 'Remove service',
                        deleteIconColor: Colors.white,
                        deleteIcon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Cake',
                          style: GoogleFonts.workSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
