// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import '../../reusable widgets/my elevatedButton.dart';
import '../../theme/constants.dart';

class WithdrawalSuccessful extends StatelessWidget {
  const WithdrawalSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          margin: const EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/animations/successful/successful-payment.gif",
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              const SizedBox(
                width: 307,
                child: Text(
                  'Withdrawal successful',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(
                      0xFF676565,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.36,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              MyElevatedButton(
                buttonTitle: "Done",
                titleFontSize: 18,
                circularBorderRadius: 10,
                maximumSizeHeight: 68,
                maximumSizeWidth: MediaQuery.of(context).size.width,
                minimumSizeHeight: 68,
                minimumSizeWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
