import 'package:benji_vendor/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../providers/responsive_constants.dart';
import '../image/my_image.dart';
import '../section/welcome_greeting.dart';

class DashboardUserCard extends StatelessWidget {
  final UserModel user;
  final Function()? onTap;
  const DashboardUserCard({super.key, this.onTap, required this.user});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      width: media.width,
      decoration: ShapeDecoration(
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 24,
            offset: Offset(0, 4),
            spreadRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Center(
              child: CircleAvatar(
                maxRadius: deviceType(media.width) >= 2 ? 90 : 50,
                minRadius: deviceType(media.width) >= 2 ? 90 : 50,
                child: ClipOval(
                  child: MyImage(
                    url: user.profileLogo,
                  ),
                ),
              ),
            ),
          ),
          deviceType(media.width) >= 2 ? kWidthSizedBox : kHalfWidthSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeGreeting(
                vendorName: "${user.firstName} ${user.lastName}",
              ),
              kHalfSizedBox,
              Row(
                children: [
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidEnvelope,
                        color: kAccentColor,
                        size: deviceType(media.width) >= 2 ? 20 : 15,
                      ),
                      kHalfSizedBox,
                      FaIcon(
                        FontAwesomeIcons.mapLocationDot,
                        color: kAccentColor,
                        size: deviceType(media.width) >= 2 ? 20 : 15,
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      SizedBox(
                        width: deviceType(media.width) >= 2
                            ? media.width - 460
                            : media.width - 250,
                        child: Text(
                          user.email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: deviceType(media.width) >= 2 ? 16 : 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      SizedBox(
                        width: deviceType(media.width) >= 2
                            ? media.width - 460
                            : media.width - 250,
                        child: Text(
                          user.address,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: deviceType(media.width) >= 2 ? 16 : 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
