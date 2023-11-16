// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../src/providers/constants.dart';
import '../../src/components/appbar/my appbar.dart';
import '../../src/components/button/my elevatedButton.dart';
import '../../src/components/input/my_message_textformfield.dart';
import '../../theme/colors.dart';

class ReportPackage extends StatefulWidget {
  const ReportPackage({
    super.key,
  });

  @override
  State<ReportPackage> createState() => _ReportPackageState();
}

class _ReportPackageState extends State<ReportPackage> {
  //============================================ ALL VARIABLES ===========================================\\

  //============================================ BOOL VALUES ===========================================\\
  bool submittingReport = false;

  //============================================ CONTROLLERS ===========================================\\
  final messageEC = TextEditingController();

  //============================================ FOCUS NODES ===========================================\\
  final messageFN = FocusNode();

  //============================================ KEYS ===========================================\\
  final formKey = GlobalKey<FormState>();

  //============================================ FUNCTIONS ===========================================\\

  Future<void> submitReport() async {
    setState(() {
      submittingReport = true;
    });

    setState(() {
      submittingReport = false;
    });

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          title: "Help and support",
          elevation: 0.0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(color: kPrimaryColor),
          padding: const EdgeInsets.all(kDefaultPadding),
          child: MyElevatedButton(
            onPressed: (() async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                submitReport();
              }
            }),
            title: "Submit",
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(kDefaultPadding),
            physics: const BouncingScrollPhysics(),
            children: [
              const Text(
                'We will like to hear from you',
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              kHalfSizedBox,
              Text(
                "What went wrong with this package delivery?",
                style: TextStyle(
                  color: kTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyMessageTextFormField(
                      controller: messageEC,
                      textInputAction: TextInputAction.done,
                      focusNode: messageFN,
                      hintText: "Enter your message here",
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                      maxLength: 1000,
                      validator: (value) {
                        if (value == null || value!.isEmpty) {
                          messageFN.requestFocus();
                          return "Field cannot be left empty";
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
