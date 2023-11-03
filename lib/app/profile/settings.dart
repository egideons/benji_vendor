import 'package:benji_vendor/src/components/appbar/my%20appbar.dart';
import 'package:benji_vendor/src/components/body/settings_body.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Settings",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      body: const SettingsBody(),
    );
  }
}
