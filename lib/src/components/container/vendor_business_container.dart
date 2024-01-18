// ignore_for_file: file_names, unused_local_variable

import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/model/vendor_business.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../providers/responsive_constants.dart';

class VendorBusinessContainer extends StatefulWidget {
  final Function() onTap;
  final BusinessModel business;

  const VendorBusinessContainer(
      {super.key, required this.onTap, required this.business});

  @override
  State<VendorBusinessContainer> createState() =>
      _VendorsProductContainerState();
}

class _VendorsProductContainerState extends State<VendorBusinessContainer> {
  //======================================= ALL VARIABLES ==========================================\\

  //======================================= F UNCTIONS ==========================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2.5),
        width: media.width,
        decoration: ShapeDecoration(
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 24,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: deviceType(media.width) >= 2
                  ? media.width - 250
                  : media.width - 300,
              height: deviceType(media.width) >= 2 ? 150 : 100,
              decoration: ShapeDecoration(
                color: kPageSkeletonColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: MyImage(url: widget.business.shopImage),
            ),
            kHalfWidthSizedBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.business.shopName,
                  style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: media.width - 250,
                  child: Text(
                    widget.business.businessBio,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                kHalfSizedBox,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
