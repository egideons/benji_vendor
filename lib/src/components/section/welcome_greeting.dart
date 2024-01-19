// ignore_for_file: file_names

import 'package:benji_vendor/src/providers/responsive_constants.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class WelcomeGreeting extends StatelessWidget {
  final String vendorName;

  const WelcomeGreeting({
    super.key,
    required this.vendorName,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Welcome,",
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: kAccentColor,
                fontSize: deviceType(media.width) >= 2 ? 22 : 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(
          width: deviceType(media.width) >= 2
              ? media.width - 430
              : deviceType(media.width) > 1 && deviceType(media.width) < 2
                  ? media.width - 250
                  : media.width - 220,
          child: Text(
            vendorName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: kTextGreyColor,
              fontSize: deviceType(media.width) >= 2 ? 20 : 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
