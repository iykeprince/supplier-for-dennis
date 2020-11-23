import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/team/team_detail.dart';

class Team {
  final String name;
  Team({this.name});
}

List<Team> teamList = [
  Team(
    name: 'Jonathan Jones',
  ),
  Team(
    name: 'Jonathan Jones',
  )
];

class TeamPage extends StatelessWidget {
  static const String ROUTE = '/team/team';
  const TeamPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24),
          Text(
            'Create and manage team members here',
            style: GoogleFonts.workSans(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) => _buildItem(context, index),
              itemCount: teamList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(context, index) {
    Team team = teamList[index];
    return InkWell(
      onTap: () => Navigator.pushNamed(context, TeamDetailPage.ROUTE),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 150,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/team_img.png'),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${team.name}',
              style: GoogleFonts.workSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'No service(s)',
                style: GoogleFonts.workSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text(
                'more',
                style: GoogleFonts.workSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: CustomColor.primaryColor,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
