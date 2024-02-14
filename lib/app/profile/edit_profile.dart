import 'package:benji_vendor/src/components/appbar/my_appbar.dart';
import 'package:benji_vendor/src/components/body/edit_profile_body.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

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
        child: const EditProfileBody(),
      ),
    );
  }
}
