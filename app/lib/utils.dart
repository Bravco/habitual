import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final BoxShadow defaultBoxShadow = boxShadow(Colors.black.withOpacity(.1));

final Color overlayGrey = Colors.black.withOpacity(.1);

const Color textColor = Color.fromRGBO(0, 0, 0, 1);
final Color textColorAlt = textColor.withOpacity(.3);

const Color color60 = Color.fromRGBO(240, 240, 240, 1);
final Color color60Alt = color60.withOpacity(.3);
const Color color60Dark = Color.fromRGBO(228, 228, 228, 1);

const Color color30 = Color.fromRGBO(255, 255, 255, 1);
final Color color30Alt = color30.withOpacity(.3);

const Color color10 = Color.fromRGBO(200, 130, 230, 1);
final Color color10Alt = color10.withOpacity(.3);

const Color color10Dark = Color.fromRGBO(200, 75, 255, 1);
final Color color10DarkAlt = color10Dark.withOpacity(.3);

final BoxShadow color10BoxShadow = boxShadow(color10.withOpacity(.75));
const Gradient color10Gradient = LinearGradient(colors: [color10, color10Dark]);

BoxShadow boxShadow(Color color) {
  return BoxShadow(
    color: color,
    spreadRadius: 0,
    blurRadius: 20,
    offset: const Offset(0, 4),
  );
}

bool datesEquality(DateTime first, DateTime second) {
  if (first.year == second.year &&
      first.month == second.month &&
      first.day == second.day) {
    return true;
  } else {
    return false;
  }
}

List<DateTime> getMonthDays(DateTime date) {
  List<DateTime> days = [];

  date = date.subtract(Duration(days: date.day - 1));
  DateTime limit = DateTime(date.year, date.month + 1).subtract(const Duration(days: 1));

  for (int i = 0; i < limit.day; i++) {
    days.add(limit.subtract(Duration(days: i)));
  }

  return days;
}