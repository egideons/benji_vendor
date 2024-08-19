// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:benji_vendor/src/controller/error_controller.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// import '../providers/api_url.dart';
// import 'user_controller.dart';

// class FcmMessagingController extends GetxController {
//   static FcmMessagingController get instance {
//     return Get.find<FcmMessagingController>();
//   }

//   Future<void> handleFCM() async {
//     final fcmToken = await FirebaseMessaging.instance.getToken();

//     if (Platform.isIOS) {
//       final apnToken = await FirebaseMessaging.instance.getAPNSToken();
//       log("This is the APNS token: $apnToken");
//     }

//     log("This is the FCM token: $fcmToken");

//     try {
//       final user = UserController.instance.user.value;
//       var url = Api.baseUrl + Api.createPushNotification;

//       Map data = {"user_id": user.id, "token": fcmToken};

//       log("Data: $data");
//       log("Url: $url");
//       log("User Id: ${user.id} and User token: ${user.token}");

//       http.Response? response = await HandleData.postApi(url, user.token, data);

//       log("Response status code: ${response!.statusCode}");
//       if (response.statusCode == 200) {
//         log("Response body: ${response.body}");
//       } else {
//         log("Response body: ${response.body}");
//       }
//     } on SocketException {
//       ApiProcessorController.errorSnack("Please connect to the internet");
//     } catch (e) {
//       log(e.toString());
//     }

//     //When the app restarts
//     // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
//     // log("This is the FCM token after the app restarted: $fcmToken");

//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       print(
//           'app notification opened ${event.data.toString()} ${event.notification?.title}');

//       // Timer(const Duration(seconds: 10), () {
//       //   Get.to(
//       //     () => const OrdersAwaiting(),
//       //     duration: const Duration(milliseconds: 300),
//       //     fullscreenDialog: true,
//       //     curve: Curves.easeIn,
//       //     routeName: "OrdersAwaiting",
//       //     preventDuplicates: true,
//       //     popGesture: false,
//       //     transition: Transition.downToUp,
//       //   );
//       // });
//     });
//     // Note: This callback is fired at each app startup and whenever a new
//     // token is generated.
//     // }).onError((err) {
//     //   log("This is the error: $err");

//     //   // Error getting token.
//     // });
//   }

//   Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     log("Handling a background message: ${message.messageId}");

//     //Call awesomenotification to how the push notification.
//     AwesomeNotifications().createNotificationFromJsonData(message.data);
//   }
// }
