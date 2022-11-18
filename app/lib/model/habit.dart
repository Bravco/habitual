const String tableHabits = "habits";

class HabitFields {
  static final List<String> values = [
    id, title, subtitle, dateData
  ];

  static const String id = "_id";
  static const String title = "title";
  static const String subtitle = "subtitle";
  static const String dateData = "dateData";
}

class Habit {
  final int? id;
  late String title;
  late String? subtitle;
  late List<DateTime> dateData;

  Habit({
    this.id,
    required this.title,
    this.subtitle,
    List<DateTime>? dateData,
  }) : dateData = dateData ?? [];

  Habit copy({
    int? id,
    String? title,
    String? subtitle,
    List<DateTime>? dateData,
  }) => Habit(
    id: id ?? this.id,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    dateData: dateData ?? this.dateData,
  );

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
      HabitFields.dateData: dateDataJson(),
    };
  }
}