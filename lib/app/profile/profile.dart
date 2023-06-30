import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _DashboardState();
}

class _DashboardState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(
          color: kAccentColor,
        ),
        // titleSpacing: kDefaultPadding / 2,
        elevation: 0.0,
      ),
      body: Container(),
    );
  }
}
