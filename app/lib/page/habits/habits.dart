import 'package:app/utils.dart' as utils;
import 'package:app/notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

// Model
import 'package:app/model/habit.dart';

// Data
import 'package:app/data/db/habits_db.dart';
import 'package:app/data/habits.dart';

// Widget
import 'package:app/widget/checkbox_list_tile.dart';

// Page
import 'package:app/page/habits/habit_settings.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({ super.key });

  @override
  State<HabitsPage> createState() => HabitsPageState();
}

class HabitsPageState extends State<HabitsPage> {
  bool isLoading = false;

  int selectedDayIndex = 6;
  List<DateTime> last7Days = [];

  List<bool> isSelected() {
    List<bool> temp = [];

    for (int i = 0; i < last7Days.length; i++) {
      temp.add(i == selectedDayIndex);
    }

    return temp;
  }

  void initLast7Days() {
    for (int i = 0; i < 7; i++) {
      last7Days.add(DateTime.now().subtract(Duration(days: i)));
    }
    
    last7Days = last7Days.reversed.toList();
  }
  
  Future refreshHabit(Habit habit) async {
    setState(() => isLoading = true);
    habit = await HabitsDatabase.instance.readHabit(habit.id as int);
    setState(() => isLoading = false);
  }

  Future refreshHabits() async {
    setState(() => isLoading = true);
    habits = await HabitsDatabase.instance.readAllHabits();
    setState(() => isLoading = false);
  }
  
  @override
  void initState() {
    super.initState();

    refreshHabits();

    initLast7Days();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            color: utils.color30,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [utils.defaultBoxShadow],
            image: const DecorationImage(
              image: AssetImage("assets/hero.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "The key is\n",
                      style: TextStyle(
                        color: utils.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "Discipline.",
                      style: TextStyle(
                        color: utils.color10,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ToggleButtons(
              isSelected: isSelected(),
              onPressed: (int index) {
                setState(() => selectedDayIndex = index);
              },
              borderWidth: 4,
              borderColor: Colors.transparent,
              selectedBorderColor: Colors.transparent,
              splashColor: utils.color10Alt,
              selectedColor: utils.color10,
              fillColor: utils.color60Dark,
              children: buildWeek(),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      habits.isEmpty
                      ? "You have nothing to track."
                      : "You are almost done.",
                      style: TextStyle(
                        color: utils.textColorAlt,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${(dayProgressDouble(last7Days[selectedDayIndex]) * 100).round()}%",
                      style: const TextStyle(
                        color: utils.color10,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: 24,
                  top: 12,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: dayProgressDouble(last7Days[selectedDayIndex]),
                    color: utils.color10,
                    backgroundColor: utils.overlayGrey,
                  ),
                ),
              ),
              Divider(
                color: utils.textColorAlt,
                height: 1,
                thickness: 1,
                indent: 32,
                endIndent: 32,
              ),
              Expanded(
                child: habits.isEmpty
                ? Center(
                  child: Text(
                    "You have no habits.",
                    style: TextStyle(
                      color: utils.textColorAlt,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ) : ReorderableListView(
                  onReorder: (oldIndex, newIndex) async {
                    if (newIndex > oldIndex) newIndex--;

                    var x = habits[oldIndex].copy();
                    var y = habits[newIndex].copy();

                    habits[newIndex].title = habits[oldIndex].title;
                    habits[newIndex].subtitle = habits[oldIndex].subtitle;
                    habits[newIndex].dateData = habits[oldIndex].dateData;
                    await HabitsDatabase.instance.update(habits[newIndex]);
                    
                    for (int i = 0; i < (oldIndex - newIndex).abs(); i++) {
                      if (oldIndex >= newIndex) {
                        if ((i % 2) == 0) {
                          x = habits[newIndex + i + 1].copy();
                          habits[newIndex + i + 1].title = y.title;
                          habits[newIndex + i + 1].subtitle = y.subtitle;
                          habits[newIndex + i + 1].dateData = y.dateData;
                          await HabitsDatabase.instance.update(habits[newIndex + i + 1]);
                        } else if ((i % 2) == 1) {
                          y = habits[newIndex + i + 1].copy();
                          habits[newIndex + i + 1].title = x.title;
                          habits[newIndex + i + 1].subtitle = x.subtitle;
                          habits[newIndex + i + 1].dateData = x.dateData;
                          await HabitsDatabase.instance.update(habits[newIndex + i + 1]);
                        }
                      } else {
                        if ((i % 2) == 0) {
                          x = habits[newIndex - i - 1].copy();
                          habits[newIndex - i - 1].title = y.title;
                          habits[newIndex - i - 1].subtitle = y.subtitle;
                          habits[newIndex - i - 1].dateData = y.dateData;
                          await HabitsDatabase.instance.update(habits[newIndex - i - 1]);
                        } else if ((i % 2) == 1) {
                          y = habits[newIndex - i - 1].copy();
                          habits[newIndex - i - 1].title = x.title;
                          habits[newIndex - i - 1].subtitle = x.subtitle;
                          habits[newIndex - i - 1].dateData = x.dateData;
                          await HabitsDatabase.instance.update(habits[newIndex - i - 1]);
                        }
                      }
                    }

                    refreshHabits();
                  },
                  children: [
                    for (final habit in habits) buildCheckboxListTile(habit, ValueKey(habit)),
                  ],

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDay(DateTime dateTime) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            DateFormat.d().format(dateTime),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            DateFormat.E().format(dateTime),
            style: TextStyle(
              color: utils.textColorAlt,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      )
    );
  }

  List<Widget> buildWeek() {
    List<Widget> temp = <Widget>[];

    for (int i = 0; i < last7Days.length; i++) {
      temp.add(buildDay(last7Days[i]));
    }

    return temp.toList();
  }

  Widget buildCheckboxListTile(Habit habit, Key? key) {
    bool value() {
      for (DateTime dateDataDate in habit.dateData) {
        if (utils.datesEquality(dateDataDate, last7Days[selectedDayIndex])) return true;
      }

      return false;
    }

    return CustomCheckboxListTile(
      key: key,
      habit: habit,
      value: value(),
      onCheckboxPressed: () async {
        bool removed = false;

        for (int i = 0; i < habit.dateData.length; i++) {
          if (utils.datesEquality(habit.dateData[i], last7Days[selectedDayIndex])) {
            habit.dateData.remove(habit.dateData[i]);
            removed = true;
          }
        }

        if (removed == false) {
          AudioPlayer().play(AssetSource("click.wav"));
          habit.dateData.add(last7Days[selectedDayIndex]);
        }

        final newHabit = habit.copy();
        await HabitsDatabase.instance.update(newHabit);
        refreshHabit(newHabit);
      },
      onHabitEdit: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HabitSettingsPage(habit: habit)))
        .then((value) => refreshHabit(habit));
      },
      onHabitDelete: () async {
        final newHabit = habit.copy();

        await HabitsDatabase.instance.delete(habit.id as int);
        refreshHabits();

        if (habit.timeNotification != null) {
          Notifications.cancel(habit.id as int);
        }

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: utils.color30,
            content: Text(
              "${habit.title} has been deleted.",
              style: TextStyle(
                color: utils.textColorAlt,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () async {
                Habit undoHabit = await HabitsDatabase.instance.create(newHabit);
                refreshHabits();

                if (undoHabit.timeNotification != null) {
                  Notifications.showScheduledNotification(
                    id: undoHabit.id!,
                    title: undoHabit.title,
                    body: undoHabit.subtitle ?? "",
                    scheduledDateTime: undoHabit.timeNotification!,
                    daily: true,
                  );
                }
              },
            ),
          ),
        );
      },
      title: habit.title,
      subtitle: habit.subtitle,
    );
  }
}