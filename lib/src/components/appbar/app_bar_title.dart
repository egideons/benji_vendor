import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "BEN",
          style: TextStyle(
            color: kSecondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        Text(
          "JI",
          style: TextStyle(
            color: kAccentColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        kHalfWidthSizedBox,
        Text(
          "VENDOR",
          style: TextStyle(
            color: kAccentColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
