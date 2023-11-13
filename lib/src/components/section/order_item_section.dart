import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../model/order_model.dart';
import '../../providers/responsive_constants.dart';
import '../image/my_image.dart';

class OrderItemSection extends StatelessWidget {
  final OrderModel order;
  const OrderItemSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: deviceType(media.width) >= 2 ? 86 : 56,
          height: deviceType(media.width) >= 2 ? 86 : 56,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          // child: MyImage(url: order.orderitems.image),
          child: const MyImage(url: ""),
        ),
        const SizedBox(
          child: Text.rich(
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            TextSpan(
              children: [
                TextSpan(
                  text: "",
                  // text: order.orderitems.name,
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: " ",
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "x ",
                  // text: "x ${order.orderitems.quantity}",
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '₦',
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: ' ',
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: '',
                // text: '${order.orderitems.amount}',
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14.30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
