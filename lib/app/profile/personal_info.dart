import 'package:benji_vendor/src/components/appbar/my%20appbar.dart';
import 'package:benji_vendor/src/components/body/personal_info_body.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Personal Info",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      body: GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        child: const PersonalInfoBody(),
      ),
    );
  }
}
