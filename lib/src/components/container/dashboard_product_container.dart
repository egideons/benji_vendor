import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../providers/constants.dart';

class DashboardProductContainer extends StatelessWidget {
  final Widget child;
  final String productName;
  final void Function()? onTap;
  const DashboardProductContainer(
      {super.key, required this.child, this.onTap, required this.productName});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width - 150,
      padding: const EdgeInsets.all(5),
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
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            child,
            kHalfSizedBox,
            Text(
              productName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kTextGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
