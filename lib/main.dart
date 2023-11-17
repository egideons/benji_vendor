import 'package:benji_vendor/app/splash_screens/startup_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'src/controller/fcm_messaging_controller.dart';
import 'src/controller/push_notifications_controller.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

late SharedPreferences prefs;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await PushNotificationController.initializeNotification();

    await FcmMessagingController.instance.handleFCM();
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Benji Vendor",
      debugShowCheckedModeBanner: false,
      color: kPrimaryColor,
      navigatorKey: navigatorKey,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.rightToLeft,
      home: SplashScreen(),
    );
  }
}
