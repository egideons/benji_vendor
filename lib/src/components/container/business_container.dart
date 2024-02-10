// ignore_for_file: file_names, unused_local_variable

import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/model/business_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../providers/responsive_constants.dart';

class BusinessContainer extends StatefulWidget {
  final Function()? onTap;
  final BusinessModel business;

  const BusinessContainer(
      {super.key, required this.onTap, required this.business});

  @override
  State<BusinessContainer> createState() => _BusinessContainerState();
}

class _BusinessContainerState extends State<BusinessContainer> {
  //======================================= ALL VARIABLES ==========================================\\

  //======================================= F UNCTIONS ==========================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: ShapeDecoration(
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: ShapeDecoration(
                  color: kLightGreyColor, shape: const CircleBorder()),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MyImage(
                  url: widget.business.shopImage,
                ),
              ),
            ),
            kHalfWidthSizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: deviceType(media.width) >= 2
                      ? media.width - 400
                      : deviceType(media.width) > 1 &&
                              deviceType(media.width) < 2
                          ? media.width - 250
                          : media.width - 220,
                  child: Text(
                    widget.business.shopName,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kTextBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                kHalfSizedBox,
                SizedBox(
                  width: deviceType(media.width) >= 2
                      ? media.width - 400
                      : deviceType(media.width) > 1 &&
                              deviceType(media.width) < 2
                          ? media.width - 250
                          : media.width - 220,
                  child: Text(
                    widget.business.address,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                kSizedBox,
                SizedBox(
                  width: deviceType(media.width) >= 2
                      ? media.width - 400
                      : deviceType(media.width) > 1 &&
                              deviceType(media.width) < 2
                          ? media.width - 250
                          : media.width - 220,
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidIdCard,
                        color: kAccentColor,
                        size: 16,
                      ),
                      kHalfWidthSizedBox,
                      SizedBox(
                        width: deviceType(media.width) >= 2
                            ? media.width - 430
                            : deviceType(media.width) > 1 &&
                                    deviceType(media.width) < 2
                                ? media.width - 250
                                : media.width - 250,
                        child: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "CAC: ",
                                style: TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: widget.business.businessId,
                                style: const TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
