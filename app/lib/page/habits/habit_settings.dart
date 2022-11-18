import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

// Model
import 'package:app/model/habit.dart';

// Data
import 'package:app/data/db/habits_db.dart';

// Widget
import 'package:app/widget/checkbox.dart';

class HabitSettingsPage extends StatefulWidget {
  final Habit? habit;

  const HabitSettingsPage({
    super.key, 
    this.habit,
  });

  @override
  State<HabitSettingsPage> createState() => _HabitSettingsPageState();
}

class _HabitSettingsPageState extends State<HabitSettingsPage> {
  bool haveTimeNotification = false;

  late bool isEditing = widget.habit == null ? false : true;

  late TextEditingController titleController;
  late TextEditingController subtitleController;

  void submit() async {
    if (titleController.text == "" || titleController.text.isEmpty) return;

    if (isEditing) {
      widget.habit!.title = titleController.text;
      widget.habit!.subtitle = subtitleController.text == "" ? null : subtitleController.text;

      await HabitsDatabase.instance.update(widget.habit!);
    } else {
      await HabitsDatabase.instance.create(Habit(
        title: titleController.text,
        subtitle: subtitleController.text == "" ? null : subtitleController.text,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    subtitleController = TextEditingController();

    if (isEditing) {
      titleController.text = widget.habit!.title;
      subtitleController.text = widget.habit!.subtitle ?? "";
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.color60,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: utils.color10Dark,
        centerTitle: true,
        title: Text(
          "Habit Settings",
          style: TextStyle(
            color: utils.textColorAlt,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        children: [
          buildListItem(buildTextField(titleController, "Title", 20)),
          buildListItem(buildTextField(subtitleController, "Subtitle", 25)),
          buildListItem(Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time Notification",
                    style: TextStyle(
                      color: utils.textColorAlt,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CustomCheckbox(
                    value: haveTimeNotification, 
                    onPressed: () {
                      setState(() => haveTimeNotification = !haveTimeNotification);
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: utils.color10,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "H",
                            style: TextStyle(
                              color: utils.textColorAlt,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 40),
                          Text(
                            "M",
                            style: TextStyle(
                              color: utils.textColorAlt,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      TimePickerSpinner(
                        time: DateTime.now(),
                        spacing: 40,
                        itemWidth: 32,
                        itemHeight: 48,
                        is24HourMode: true,
                        isForce2Digits: true,
                        isShowSeconds: false,
                        alignment: Alignment.center,
                        normalTextStyle: TextStyle(
                          color: utils.color10DarkAlt,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        highlightedTextStyle: const TextStyle(
                          color: utils.color10Dark,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        onTimeChange: (p0) {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          submit();
          Navigator.pop(context);
        },
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        backgroundColor: utils.color10Dark,
        splashColor: utils.color30Alt,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              utils.color10BoxShadow,
            ],
          ),
          child: const Icon(Icons.check),
        ),
      ),
    );
  }

  Widget buildListItem(Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: widget,
    );
  }

  Widget buildTextField(TextEditingController controller, String label, int maxLength) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      autofocus: false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: utils.textColorAlt,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        border:  const UnderlineInputBorder(borderSide: BorderSide(color: utils.color10)),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: utils.color10)),
        focusedBorder:  const UnderlineInputBorder(borderSide: BorderSide(color: utils.color10)),
      ),
    );
  }
}