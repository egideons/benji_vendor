import 'package:benji_vendor/src/common_widgets/appbar/my%20appbar.dart';
import 'package:benji_vendor/src/common_widgets/body/change_phone_number_body.dart';
import 'package:flutter/material.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Change Phone Number",
        elevation: 0,
        actions: const [],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: const SafeArea(
        maintainBottomViewPadding: true,
        child: ChangePhoneNumberBody(),
      ),
    );
  }
}
