// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../providers/constants.dart';

void mySnackBar(BuildContext context, String text, Color bgColor,
    SnackBarBehavior snackbarBehavior, double bottomHeight) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
      duration: const Duration(
        seconds: 3,
      ),
      margin: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: bottomHeight,
      ),
      behavior: snackbarBehavior,
      backgroundColor: bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10.0,
          ),
          bottom: Radius.circular(
            10.0,
          ),
        ),
      ),
    ),
  );
}
