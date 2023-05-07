const String tableHabits = "habits";

class HabitFields {
  static final List<String> values = [
    id, title, subtitle, timeNotification, dateData
  ];

  static const String id = "_id";
  static const String title = "title";
  static const String subtitle = "subtitle";
  static const String timeNotification = "timeNotification";
  static const String dateData = "dateData";
}

class Habit {
  final int? id;
  late String title;
  late String? subtitle;
  late DateTime? timeNotification;
  late List<DateTime> dateData;

  Habit({
    this.id,
    required this.title,
    this.subtitle,
    this.timeNotification,
    List<DateTime>? dateData,
  }) : dateData = dateData ?? [];

  Habit copy({
    int? id,
    String? title,
    String? subtitle,
    DateTime? timeNotification,
    List<DateTime>? dateData,
  }) => Habit(
    id: id ?? this.id,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    timeNotification: timeNotification ?? this.timeNotification,
    dateData: dateData ?? this.dateData,
  );

  int getDayStreak() {
    List<DateTime> dates = dateData;
    dates.sort();

    if (dates.isEmpty) return 0;
    int streak = 1;
    DateTime previousDate = dates[0];

    for (int i = 1; i < dates.length; i++) {
      final difference = dates[i].difference(DateTime(
        previousDate.year, previousDate.month, previousDate.day
      ));
      if (difference.inDays == 1) {
        streak++;
      } else if (difference.inDays > 1) {
        // The streak has been broken
        streak = 1;
      }
      previousDate = dates[i];
    }

    return streak;
  }

  static Habit fromJson(Map<String, Object?> json) {
    List<DateTime> dateDataJson() {
      List<DateTime> temp = [];
      List<String> dateDataStrings = (json[HabitFields.dateData] as String).split("|");

      if (!dateDataStrings.contains("")) {
        for (int i = 0; i < dateDataStrings.length; i++) {
          temp.add(DateTime.parse(dateDataStrings[i]));
        }
      }

      return temp;
    }

    return Habit(
      id: json[HabitFields.id] as int?,
      title: json[HabitFields.title] as String,
      subtitle: json[HabitFields.subtitle] as String?,
      timeNotification: (json[HabitFields.timeNotification] as String) != ""
        ? DateTime.parse(json[HabitFields.timeNotification] as String)
        : null,
      dateData: dateDataJson(),
    );
  }

  Map<String, Object?> toJson() {
    String dateDataJson() {
      List<String> temp = [];

      for (int i = 0; i < dateData.length; i++) {
        temp.add(dateData[i].toIso8601String());
      }

      return temp.join("|");
    }

    return {
      HabitFields.id: id,
      HabitFields.title: title,
      HabitFields.subtitle: subtitle,
      HabitFields.timeNotification: timeNotification == null ? "" : timeNotification!.toIso8601String(),
      HabitFields.dateData: dateDataJson(),
    };
  }
}