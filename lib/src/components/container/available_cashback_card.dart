// ignore_for_file: file_names

import 'package:benji_vendor/src/controller/withdraw_controller.dart';
import 'package:benji_vendor/src/providers/responsive_constants.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../providers/constants.dart';

class AvailableCashbackCard extends StatefulWidget {
  const AvailableCashbackCard({super.key, required this.shopReward});
  final double shopReward;

  @override
  State<AvailableCashbackCard> createState() => _AvailableCashbackCardState();
}

class _AvailableCashbackCardState extends State<AvailableCashbackCard> {
  late double shopReward;
  @override
  void initState() {
    shopReward = widget.shopReward;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      width: media.width,
      height: deviceType(media.width) >= 2 ? 200 : 140,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Shop Reward',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // IconButton(
              //   onPressed: toggleVisibleCash,
              //   icon: FaIcon(
              //     widget.business.isVisibleCash
              //         ? FontAwesomeIcons.solidEye
              //         : FontAwesomeIcons.solidEyeSlash,
              //     color: kAccentColor,
              //   ),
              // ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "₦ ",
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 30,
                            fontFamily: 'sen',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: doubleFormattedText(shopReward),
                          style: TextStyle(
                            color: kAccentColor,
                            fontSize: 30,
                            fontFamily: 'sen',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // kSizedBox,
                  // IconButton(
                  //   icon: const FaIcon(FontAwesomeIcons.arrowsRotate),
                  //   onPressed: () async {
                  //     await UserController.instance.getUser();
                  //   },
                  //   mouseCursor: SystemMouseCursors.click,
                  //   color: kGreyColor,
                  //   iconSize: 25.0,
                  //   tooltip: 'Refresh',
                  //   padding: const EdgeInsets.all(10.0),
                  //   splashRadius: 20.0,
                  // ),
                ],
              ),
              TextButton(
                onPressed: () async {
                  Map data = {
                    "user_id": 'id',
                    "amount_to_withdraw": '',
                    "bank_details_id": ''
                  };

                  final result =
                      await WithdrawController.instance.withdraw(data);
                  if (result.statusCode == 200) {
                    setState(() {
                      shopReward = 0;
                    });
                  }
                },
                child: const Text('Withdraw'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
