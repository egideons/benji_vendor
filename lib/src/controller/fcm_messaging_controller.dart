import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../providers/api_url.dart';

class FcmMessagingController extends GetxController {
  static FcmMessagingController get instance {
    return Get.find<FcmMessagingController>();
  }

  Future<void> handleFCM() async {
    final fcmToken =
        await FirebaseMessaging.instance.getToken().then((value) => null);

    consoleLog("This is the FCM token: $fcmToken");

    //When the app restarts
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      consoleLog("This is the FCM token after the app restarted: $fcmToken");

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      consoleLog("This is the error: $err");

      // Error getting token.
    });
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    consoleLog("Handling a background message: ${message.messageId}");

    //Call awesomenotification to how the push notification.
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }
}
