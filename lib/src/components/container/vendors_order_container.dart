// ignore_for_file: unused_field

import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class VendorsOrderContainer extends StatelessWidget {
  final OrderModel order;
  const VendorsOrderContainer({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
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
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: kLightGreyColor,
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/profile/avatar-image.jpg"),
                  ),
                ),
                // child:

                //  CachedNetworkImage(
                //   imageUrl: order.client.image ?? "",
                //   fit: BoxFit.cover,
                //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                //       Center(
                //     child: CupertinoActivityIndicator(color: kAccentColor),
                //   ),
                //   errorWidget: (context, url, error) =>
                //       Icon(Icons.error, color: kAccentColor),
                // ),
              ),
              kHalfSizedBox,
              SizedBox(
                width: 60,
                child: Text(
                  "#${order.code}",
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
              SizedBox(
                width: media.width - 150,
                // color: kAccentColor,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text(
                      UserController.instance.user.value.shopName,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      order.created,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              kHalfSizedBox,
              SizedBox(
                width: media.width - 200,
                child: Text(
                  order.deliveryStatus == "CANC"
                      ? "Cancelled"
                      : order.deliveryStatus == "PEND"
                          ? "Pending"
                          : "Completed",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: order.deliveryStatus == "PEND"
                        ? kSecondaryColor
                        : kSuccessColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              kHalfSizedBox,
              SizedBox(
                width: media.width - 200,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "₦ ${convertToCurrency(order.totalPrice.toString())}",
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
                  color: kLightGreyColor, height: 2, width: media.width - 150),
              kHalfSizedBox,
              SizedBox(
                width: media.width - 150,
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
