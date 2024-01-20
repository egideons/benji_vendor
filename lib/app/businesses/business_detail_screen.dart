import 'package:benji_vendor/src/components/appbar/my_appbar.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';

class BusinessDetailScreen extends StatefulWidget {
  const BusinessDetailScreen({Key? key}) : super(key: key);

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Business detail",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: ListView(
          children: const [],
        ),
      ),
    );
  }
}
