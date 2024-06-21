// ignore_for_file: unused_field

import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class BusinessOrderContainer extends StatelessWidget {
  final OrderModel order;
  const BusinessOrderContainer({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
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
        children: [
          Column(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MyImage(
                    url: order.client.image,
                  ),
                ),
              ),
              kHalfSizedBox,
              SizedBox(
                width: 60,
                child: Text(
                  "#${order.code}",
                  maxLines: 2,
                  style: TextStyle(
                    color: kTextGreyColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          kWidthSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: media.width - 320,
                    child: Text(
                      order.deliveryStatus == "CANC"
                          ? "Cancelled"
                          : order.deliveryStatus == "dispatched"
                              ? "Dispatched"
                              : order.deliveryStatus == "PEND"
                                  ? "Pending"
                                  : "Completed",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: order.deliveryStatus == "CANC"
                            ? kAccentColor
                            : order.deliveryStatus == "dispatched"
                                ? kSecondaryColor
                                : order.deliveryStatus == "PEND"
                                    ? kLoadingColor
                                    : kSuccessColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    order.created,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              kHalfSizedBox,
              SizedBox(
                width: media.width - 260,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "₦ ${convertToCurrency(order.preTotal.toString())}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'sen',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              kHalfSizedBox,
              Container(
                  color: kLightGreyColor, height: 2, width: media.width - 160),
              kHalfSizedBox,
              SizedBox(
                width: media.width - 260,
                child: Text(
                  "${order.client.firstName} ${order.client.lastName}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
