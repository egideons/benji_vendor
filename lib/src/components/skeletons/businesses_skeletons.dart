import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../providers/responsive_constants.dart';
import 'page_skeleton.dart';

class BusinessListSkeleton extends StatelessWidget {
  const BusinessListSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const SizedBox(height: kDefaultPadding),
      itemCount: 20,
      addAutomaticKeepAlives: true,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            highlightColor: kBlackColor.withOpacity(0.02),
            baseColor: kBlackColor.withOpacity(0.8),
            direction: ShimmerDirection.ltr,
            child: const PageSkeleton(height: 120, width: 130),
          ),
          kWidthSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 100,
                child: PageSkeleton(height: 20, width: 100),
              ),
              kSizedBox,
              SizedBox(
                width: deviceType(media.width) >= 2
                    ? media.width - 400
                    : deviceType(media.width) > 1 && deviceType(media.width) < 2
                        ? media.width - 250
                        : media.width - 220,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PageSkeleton(height: 15, width: 60),
                    kHalfWidthSizedBox,
                    PageSkeleton(height: 15, width: 60),
                  ],
                ),
              ),
              kHalfSizedBox,
              PageSkeleton(
                  height: 15,
                  width: deviceType(media.width) >= 2
                      ? media.width - 400
                      : deviceType(media.width) > 1 &&
                              deviceType(media.width) < 2
                          ? media.width - 250
                          : media.width - 220),
              kSizedBox,
              PageSkeleton(
                  height: 15,
                  width: deviceType(media.width) >= 2
                      ? media.width - 400
                      : deviceType(media.width) > 1 &&
                              deviceType(media.width) < 2
                          ? media.width - 250
                          : media.width - 220),
            ],
          ),
        ],
      ),
    );
  }
}
