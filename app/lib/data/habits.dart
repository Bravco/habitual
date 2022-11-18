import 'package:app/utils.dart' as utils;

// Model
import 'package:app/model/habit.dart';

List<Habit> habits = <Habit>[];

int totalCheckins() {
  var value = 0;

  for (int i = 0; i < habits.length; i++) {
    value += habits[i].dateData.length;
  }

  return value;
}

double dayProgressDouble(DateTime dateTime) {
  if (habits.isNotEmpty) {
    var checked = 0;

    for (int i = 0; i < habits.length; i++) {
      for (DateTime dateDataDate in habits[i].dateData) {
        if (utils.datesEquality(dateDataDate, dateTime)) checked++;
      }
    }

    return checked / habits.length;
  } else {
    return 0;
  }
}

int dayProgressInt(DateTime dateTime) {
  if (habits.isNotEmpty) {
    var checked = 0;

    for (int i = 0; i < habits.length; i++) {
      for (DateTime dateDataDate in habits[i].dateData) {
        if (utils.datesEquality(dateDataDate, dateTime)) checked++;
      }
    }

    return checked;
  } else {
    return 0;
  }
}

double weekProgressDouble(DateTime date) {
  if (habits.isNotEmpty) {
    double value = 0;

    DateTime monday = date.subtract(Duration(days: date.weekday - 1));

    if (utils.datesEquality(DateTime.now(), date)) {
      for (int i = 0; i < date.weekday; i++) {
        value += dayProgressDouble(monday.add(Duration(days: i)));
      }

      return value / date.weekday;
    } else {
      for (int i = 0; i < 7; i++) {
        value += dayProgressDouble(monday.add(Duration(days: i)));
      }

      return value / 7;
    }
  } else {
    return 0;
  }
}

double monthProgressDouble(DateTime date) {
  if (habits.isNotEmpty) {
    double value = 0;

    if (utils.datesEquality(DateTime.now(), date)) {
      for (int i = 0; i < DateTime.now().day; i++) {
        value += dayProgressDouble(date.subtract(Duration(days: i)));
      }

      return value / date.day;
    } else {
      for (DateTime day in utils.getMonthDays(date)) {
        value += dayProgressDouble(day);
      }

      return value = value / utils.getMonthDays(date).length;
    }
  } else {
    return 0;
  }
}