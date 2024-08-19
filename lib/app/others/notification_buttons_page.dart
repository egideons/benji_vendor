// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';

// import '../../src/components/appbar/my_appbar.dart';
// import '../../src/components/button/notification_button.dart';
// import '../../src/controller/push_notifications_controller.dart';
// import '../../src/providers/constants.dart';
// import '../../theme/colors.dart';

// class NotificationButtonsPage extends StatefulWidget {
//   const NotificationButtonsPage({Key? key}) : super(key: key);

//   @override
//   State<NotificationButtonsPage> createState() =>
//       _NotificationButtonsPageState();
// }

// class _NotificationButtonsPageState extends State<NotificationButtonsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//         title: "Notification Screen (Awesome Notifications)",
//         elevation: 0,
//         actions: const [],
//         backgroundColor: kPrimaryColor,
//       ),
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       body: SafeArea(
//         maintainBottomViewPadding: true,
//         child: ListView(
//           children: [
//             NotificationButton(
//               text: "Normal Notification",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   largeIcon: "asset://assets/icons/app_icon.png",
//                 );
//               },
//             ),
//             kSizedBox,
//             NotificationButton(
//               text: "Notification with summary",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   summary: "Small summary",
//                   notificationLayout: NotificationLayout.Inbox,
//                 );
//               },
//             ),
//             kSizedBox,
//             NotificationButton(
//               text: "Progress bar notification",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   summary: "Small summary",
//                   notificationLayout: NotificationLayout.ProgressBar,
//                 );
//               },
//             ),
//             kSizedBox,
//             NotificationButton(
//               text: "Message notification",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   summary: "Small summary",
//                   notificationLayout: NotificationLayout.Messaging,
//                 );
//               },
//             ),
//             kSizedBox,
//             NotificationButton(
//               text: "Big image notification",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   summary: "Small summary",
//                   notificationLayout: NotificationLayout.BigPicture,
//                   bigPicture:
//                       "https://files.tecnoblog.net/wp-content/uploads/2019/09/emoji.jpg",
//                 );
//               },
//             ),
//             kSizedBox,
//             NotificationButton(
//               text: "Action button notification",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   payload: {
//                     "navigate": "true",
//                   },
//                   actionButtons: [
//                     NotificationActionButton(
//                       key: "check",
//                       label: "Check it out",
//                       actionType: ActionType.SilentAction,
//                       color: kAccentColor,
//                     ),
//                   ],
//                 );
//               },
//             ),
//             kSizedBox,
//             NotificationButton(
//               text: "Scheduled notification",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   scheduled: true,
//                   interval: 5,
//                 );
//               },
//             ),
//             kSizedBox,
//             NotificationButton(
//               text: "Another notification",
//               onPressed: () async {
//                 await PushNotificationController.showNotification(
//                   title: "Title of the notification",
//                   body: "Body of the notification",
//                   allowWhileIdle: true,
//                   actionButtons: [
//                     NotificationActionButton(
//                       key: "open",
//                       label: "Open",
//                       actionType: ActionType.Default,
//                       color: kSecondaryColor,
//                       autoDismissible: true,
//                       requireInputText: true,
//                     ),
//                   ],
//                 );
//               },
//             ),
//             kSizedBox,
//           ],
//         ),
//       ),
//     );
//   }
// }
