import 'package:benji_vendor/app/splash_screens/startup_splash_screen.dart';
import 'package:benji_vendor/src/controller/account_controller.dart';
import 'package:benji_vendor/src/controller/shopping_location_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/controller/auth_controller.dart';
import 'src/controller/business_controller.dart';
import 'src/controller/category_controller.dart';
import 'src/controller/fcm_messaging_controller.dart';
import 'src/controller/form_controller.dart';
import 'src/controller/latlng_detail_controller.dart';
import 'src/controller/login_controller.dart';
import 'src/controller/notification_controller.dart';
import 'src/controller/order_controller.dart';
import 'src/controller/payment_controller.dart';
import 'src/controller/product_controller.dart';
import 'src/controller/product_property_controller.dart';
import 'src/controller/profile_controller.dart';
import 'src/controller/push_notifications_controller.dart';
import 'src/controller/reviews_controller.dart';
import 'src/controller/send_package_controller.dart';
import 'src/controller/user_controller.dart';
import 'src/controller/withdraw_controller.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

late SharedPreferences prefs;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );

  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  Get.put(FcmMessagingController());
  Get.put(UserController());
  Get.put(CategoryController());
  Get.put(LoginController());
  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(OrderController());

  Get.put(FormController());
  Get.put(ReviewsController());
  Get.put(LatLngDetailController());
  Get.put(ProfileController());
  Get.put(NotificationController());
  Get.put(SendPackageController());
  Get.put(PaymentController());
  Get.put(ProductPropertyController());
  Get.put(BusinessController());
  Get.put(WithdrawController());
  Get.put(ShoppingLocationController());
  Get.put(AccountController());

  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await PushNotificationController.initializeNotification();
  }

  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Benji Vendor",
      debugShowCheckedModeBanner: false,
      color: kPrimaryColor,
      navigatorKey: Get.key,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.rightToLeft,
      home: SplashScreen(),
    );
  }
}
