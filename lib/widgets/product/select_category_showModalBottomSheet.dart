// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../providers/constants.dart';

Future<dynamic> SelectCategoryShowModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: kPrimaryColor,
    barrierColor: kBlackColor.withOpacity(0.5),
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    isDismissible: true,
    elevation: 20.0,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      minHeight: MediaQuery.of(context).size.height * 0.5,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          kDefaultPadding,
        ),
      ),
    ),
    enableDrag: true,
    builder: (context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Category',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.48,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: kAccentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kDefaultPadding * 3,
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/icons/add-category.png",
                ),
                kSizedBox,
                const SizedBox(
                  width: 156,
                  height: 31,
                  child: Text(
                    'No Category',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      overflow: TextOverflow.ellipsis,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.48,
                    ),
                  ),
                ),
                kSizedBox,
                const SizedBox(
                  width: 187,
                  height: 60,
                  child: Text(
                    'Create a new category to have it appear here.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 56,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFFE6E6E6)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outlined,
                      color: kAccentColor,
                    ),
                    kHalfWidthSizedBox,
                    Text(
                      'Add Category',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kAccentColor,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
