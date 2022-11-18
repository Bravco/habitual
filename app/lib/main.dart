import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

// Data
import 'package:app/data/db/habits_db.dart';

// Page
import 'package:app/page/habits/habits.dart';
import 'package:app/page/habits/habit_settings.dart';
import 'package:app/page/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: utils.color10),
      ),
      home: const SafeArea(
        top: false,
        child: Page(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  static final GlobalKey<HabitsPageState> habitsPageKey = GlobalKey();

  final pages = [
    HabitsPage(key: habitsPageKey),
    const ProfilePage(),
  ];

  int pageIndex = 0;

  @override
  void dispose() {
    HabitsDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.color60,
      body: pages[pageIndex],
      floatingActionButton: pageIndex == 0
      ? FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HabitSettingsPage()))
          .then((value) => habitsPageKey.currentState!.refreshHabits());
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
          child: const Icon(Icons.add),
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: "Habits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        selectedIconTheme: const IconThemeData(
          size: 32,
          color: utils.color10,
        ),
        unselectedIconTheme: IconThemeData(
          size: 28,
          color: utils.textColorAlt,
        ),
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(() => pageIndex = index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}