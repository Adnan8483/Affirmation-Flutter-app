import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //To store payload values in both scenario app launch and running app payload.
  String? lastNotificationPayload;

  Future<void> initializeNotifications({
    void Function(String? payload)? onNotificationTap,
  }) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true);

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: iosSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        // Method to get payload from app running in background.
        onDidReceiveNotificationResponse: (res) {
      final payload = res.payload;
      if (onNotificationTap != null) {
        onNotificationTap(payload);
      }

      // print(
      //     "&&&& Payload from existing background:- ${res.payload.toString()}");
    });

    // Method to Handle notification app launch if closed.
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      String? payload =
          notificationAppLaunchDetails?.notificationResponse?.payload;

      if (payload != null) {
        int affirmationId = int.parse(payload);
        if (affirmationId != null) {
          onNotificationTap!(affirmationId.toString());
          // print(
          //     '**** App launched from notification with affirmation ID: $affirmationId');
        }
      }
    }
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "com.effocess.inspira.notification_channel",
          "Inspira App Channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

//showing notification onTap function.
  Future<void> showNotification(
      int affirmationId, String affirmationText) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "com.effocess.inspira.notification_channel",
      "Inspira App Channel",
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Affirmation',
      affirmationText,
      platformChannelSpecifics,
      payload: affirmationId.toString(), // Pass the affirmation ID as payload
    );
  }
}
