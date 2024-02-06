// ignore_for_file: file_names

import 'package:benji_vendor/src/controller/business_controller.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/model/business_model.dart';
import 'package:benji_vendor/src/providers/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/colors.dart';
import '../../providers/constants.dart';

class AvailableCashbackCard extends StatefulWidget {
  const AvailableCashbackCard({super.key, required this.business});
  final BusinessModel business;

  @override
  State<AvailableCashbackCard> createState() => _AvailableCashbackCardState();
}

class _AvailableCashbackCardState extends State<AvailableCashbackCard> {
  @override
  void initState() {
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
            ],
          ),
          GetBuilder<BusinessController>(
            initState: (state) => BusinessController.instance
                .getVendorBusinessBalance(widget.business.id),
            builder: (controller) {
              if (controller.isLoadBalance.value) {
                return const Text('Loading...');
              }
              return Row(
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
                              text:
                                  doubleFormattedText(controller.balance.value),
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
                    ],
                  ),
                  TextButton(
                    onPressed: doubleFormattedText(controller.balance.value)
                            .startsWith("0")
                        ? null
                        : () async {
                            final result = await BusinessController.instance
                                .getVendorBusinessWithdraw(widget.business,
                                    shopReward: controller.balance.value);
                            await BusinessController.instance
                                .getVendorBusinessBalance(widget.business.id);
                            // print(result?.body);
                            // print(result?.statusCode);
                            if (result != null && result.statusCode == 200) {
                              ApiProcessorController.successSnack(
                                'Withdrawal request successful',
                              );
                            } else {
                              ApiProcessorController.errorSnack(
                                'Withdrawal request failed',
                              );
                            }
                          },
                    child: Text(
                      'Withdraw',
                      style: TextStyle(
                        color: doubleFormattedText(controller.balance.value)
                                .startsWith("0")
                            ? null
                            : kAccentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
