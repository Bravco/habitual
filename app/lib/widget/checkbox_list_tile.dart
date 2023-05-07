import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

// Model
import 'package:app/model/habit.dart';

// Widget
import 'package:app/widget/checkbox.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final Habit habit;
  final bool? value;
  final VoidCallback onCheckboxPressed;
  final VoidCallback onHabitEdit;
  final VoidCallback onHabitDelete;
  final String title;
  final String? subtitle;

  const CustomCheckboxListTile({
    super.key,
    required this.habit,
    required this.value,
    required this.onCheckboxPressed,
    required this.onHabitEdit,
    required this.onHabitDelete,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: utils.color60,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 28,
          right: 28,
          top: 8,
          bottom: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CustomCheckbox(
                    value: value as bool,
                    onPressed: onCheckboxPressed,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: utils.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    subtitle != null
                    ? Text(
                      subtitle!,
                      style: TextStyle(
                        color: utils.textColorAlt,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                    : Container(),
                    Text(
                      "DAY STREAK: ${habit.getDayStreak()}",
                      style: const TextStyle(
                        color: utils.color10,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            PopupMenuButton<void Function()>(
              constraints: const BoxConstraints(minWidth: 192),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              icon: Icon(
                Icons.more_horiz,
                size: 32,
                color: utils.textColorAlt,
              ),
              onSelected: (value) => value(),
              itemBuilder: (context) {
                return <PopupMenuEntry<void Function()>>[
                  PopupMenuItem<void Function()>(
                    value: onHabitEdit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit",
                          style: TextStyle(
                            color: utils.textColorAlt,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: utils.textColorAlt,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<void Function()>(
                    value: onHabitDelete,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delete",
                          style: TextStyle(
                            color: utils.textColorAlt,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(
                          Icons.delete,
                          color: utils.color10,
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}