import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Data
import 'package:app/data/habits.dart';

// Widget
import 'package:app/widget/progression_donuts.dart';

// Page
import 'package:app/page/profile/checkins.dart';
import 'package:app/page/profile/completion.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*Container(
          decoration: BoxDecoration(
            color: utils.color30,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [utils.defaultBoxShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: utils.textColorAlt,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: utils.color60,
                    size: 96,
                  ),
                ),
                const Text(
                  "You",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),*/
        const SizedBox(height: 48),
        // TEMPORARY
        Expanded(
          child: ListView(
            children: [
              buildTile(
                context,
                "Check-ins",
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Total check-ins ",
                        style: TextStyle(
                          color: utils.textColorAlt,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: totalCheckins().toString(),
                        style: const TextStyle(
                          color: utils.color10,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const CheckinsPage(),
              ),
              buildTile(
                context,
                "Completion",
                ProgressionDonuts(
                  values: [for (int i = 0; i < 7; i++) dayProgressDouble(DateTime.now().subtract(Duration(days: i)))],
                  titles: [for (int i = 0; i < 7; i++) DateFormat.E().format(DateTime.now().subtract(Duration(days: i)))],
                ),
                const CompletionPage(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTile(BuildContext context, String title, Widget preview, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        bottom: 48,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: utils.color30,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [utils.defaultBoxShadow],
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: utils.textColorAlt,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: utils.textColorAlt,
                size: 24,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => page));
              },
            ),
            const Divider(
              thickness: 2,
              indent: 16,
              endIndent: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 16,
                  bottom: 24,
                ),
                child: preview,
              ),
            ),
          ],
        ),
      ),
    );
  }
}