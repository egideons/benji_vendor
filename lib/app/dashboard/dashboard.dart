import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../modules/home appBar vendor name.dart';
import '../../theme/constants.dart';
import '../profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding / 2,
        elevation: 0.0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                child: CircleAvatar(
                  minRadius: 20,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/profile/profile-picture.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const AppBarVendor(
              vendorName: "Ntachi-Osa",
              vendorLocation: "Independence Layout, Enugu",
            ),
          ],
        ),
        actions: [
          Container(
            width: 45,
            height: 45,
            margin: const EdgeInsets.only(
              right: kDefaultPadding / 2,
            ),
            decoration: const ShapeDecoration(
              color: Color(0xFFFEF8F8),
              shape: OvalBorder(
                side: BorderSide(
                  width: 0.50,
                  color: Color(
                    0xFFFDEDED,
                  ),
                ),
              ),
            ),
            child: IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => Cart(),
                //   ),
                // );
              },
              splashRadius: 20,
              icon: Icon(
                Icons.notifications_outlined,
                color: kAccentColor,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(
              kDefaultPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 2; i++)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(
                              kDefaultPadding / 2,
                            ),
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: 150,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(
                                    0x0F000000,
                                  ),
                                  blurRadius: 24,
                                  offset: Offset(
                                    0,
                                    4,
                                  ),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 20,
                                    color: kGreyColor1,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 59.30,
                                        height: 62.78,
                                        child: Text(
                                          '20',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: kAccentColor,
                                            fontSize: 52.32,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
