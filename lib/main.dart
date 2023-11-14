import 'package:benji_vendor/app/splash_screens/startup_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_theme.dart';
import 'theme/colors.dart';

late SharedPreferences prefs;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Benji Vendor",
      debugShowCheckedModeBanner: false,
      color: kPrimaryColor,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          title: "Benji Vendor",
          themeMode: ThemeMode.light,
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          defaultTransition: Transition.rightToLeft,
          home: SplashScreen(),
        );
      },
    );
  }
}
