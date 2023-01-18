import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  LocalNotification._();

  static FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  static init() async {
    AndroidInitializationSettings androidSettings = const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iOSSettings = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false
    );

    InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings
    );

    await plugin.initialize(settings);
  }

  static void requestPermission() {
    plugin
    .resolvePlatformSpecificImplementation
      <IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true
        );
  }

  static Future<void> notification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('wollu id', 'wollu name',
        channelDescription: 'wollu',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: false
      );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: DarwinNotificationDetails(
            badgeNumber: 1
          )
        );

    await plugin.show(
        0,
        'Test',
        '인터넷 서핑하기 \t 06:02',
        platformChannelSpecifics,
        payload: 'payload'
    );
  }
}