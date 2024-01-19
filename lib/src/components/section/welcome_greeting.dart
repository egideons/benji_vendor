// ignore_for_file: file_names

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
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(
          width: media.width - 220,
          child: Text(
            vendorName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: kTextGreyColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
