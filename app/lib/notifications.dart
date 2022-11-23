import 'package:app/utils.dart' as utils;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class Notifications {
  static Future init({bool initScheduled = false}) async {
    var androidInitialize = const AndroidInitializationSettings("@drawable/ic_stat_android");
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    await utils.flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future _notificationDetails(String? channelId) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId ?? "channel_id",
        "channel_name",
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(
        presentSound: true,
      ),
    );
  }

  static Future showNotification({
    int id = 0,
    String? channelId,
    required String title,
    required String body,
  }) async {
    await utils.flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await _notificationDetails(channelId),
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? channelId,
    required String title,
    required String body,
    required DateTime scheduledDateTime,
    bool daily = false,
  }) async {
    await utils.flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      daily == true
      ? tz.TZDateTime.from(scheduledDateTime, tz.local)
      : _scheduleDaily(Time(scheduledDateTime.hour, scheduledDateTime.minute, scheduledDateTime.second)),
      await _notificationDetails(channelId),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: daily == true ? DateTimeComponents.time : null,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    return scheduledDate.add(Duration(days: now.day - scheduledDate.day));
  }

  static void cancel(int id) => utils.flutterLocalNotificationsPlugin.cancel(id);

  static void cancelAll() => utils.flutterLocalNotificationsPlugin.cancelAll();
}