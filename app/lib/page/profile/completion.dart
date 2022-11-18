import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

// Data
import 'package:app/data/habits.dart';

// Widget
import 'package:app/widget/progression_donuts.dart';

class CompletionPage extends StatefulWidget {
  const CompletionPage({super.key});

  @override
  State<CompletionPage> createState() => _CompletionPageState();
}

class _CompletionPageState extends State<CompletionPage> {
  List<String> choices = ["Day", "Week", "Month"];
  int choiceIndex = 0;

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
          "Completion",
          style: TextStyle(
            color: utils.textColorAlt,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final choice in choices) ChoiceChip(
                  elevation: 0,
                  pressElevation: 0,
                  selectedColor: utils.color10Alt,
                  backgroundColor: utils.overlayGrey,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  label: Text(
                    choice,
                    style: TextStyle(
                      color: choices[choiceIndex] == choice ? utils.color10 : utils.textColorAlt,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  selected: choices[choiceIndex] == choice,
                  onSelected: (value) {
                    setState(() {
                      choiceIndex = choices.indexOf(choice);
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                color: utils.textColorAlt,
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
            ),
            buildSection(
              "Progression Donuts",
              buildProgressionDonuts(),
            ),
            buildSection(
              "Progression Bars", 
              AspectRatio(
                aspectRatio: 1.2,
                child: BarChart(
                  BarChartData(
                    barGroups: buildChartGroupData(),
                    minY: 0,
                    maxY: 1,
                    barTouchData: BarTouchData(
                      enabled: false,
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                          color: utils.overlayGrey,
                          width: 2,
                        ),
                        top: BorderSide(
                          color: utils.overlayGrey,
                          width: 2,
                        ),
                      )
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: .2,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: utils.overlayGrey,
                          strokeWidth: 2,
                          dashArray: [8],
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${(value * 100).round()}%",
                                style: TextStyle(
                                  color: utils.textColorAlt,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 24,
                          getTitlesWidget: (value, meta) {
                            var string = "";

                            if (choiceIndex == 0) {
                              switch (value.toInt()) {
                                case 1:
                                  string = DateFormat.E().format(DateTime.now().subtract(const Duration(days: 6)));
                                  break;
                                
                                case 2:
                                  string = DateFormat.E().format(DateTime.now().subtract(const Duration(days: 5)));
                                  break;
                                
                                case 3:
                                  string = DateFormat.E().format(DateTime.now().subtract(const Duration(days: 4)));
                                  break;
                                
                                case 4:
                                  string = DateFormat.E().format(DateTime.now().subtract(const Duration(days: 3)));
                                  break;
                                
                                case 5:
                                  string = DateFormat.E().format(DateTime.now().subtract(const Duration(days: 2)));
                                  break;
                                
                                case 6:
                                  string = DateFormat.E().format(DateTime.now().subtract(const Duration(days: 1)));
                                  break;
                                
                                case 7:
                                  string = DateFormat.E().format(DateTime.now());
                                  break;
                              }
                            } else if (choiceIndex == 1) {
                              switch (value.toInt()) {
                                case 1:
                                  string = "7th";
                                  break;
                                
                                case 2:
                                  string = "6th";
                                  break;
                                
                                case 3:
                                  string = "5th";
                                  break;
                                
                                case 4:
                                  string = "4th";
                                  break;
                                
                                case 5:
                                  string = "3rd";
                                  break;
                                
                                case 6:
                                  string = "Last";
                                  break;
                                
                                case 7:
                                  string = "This";
                                  break;
                              }
                            } else if (choiceIndex == 2) {
                              switch (value.toInt()) {
                                case 1:
                                  string = DateFormat.MMM().format(DateTime(DateTime.now().year, DateTime.now().month - 6));
                                  break;
                                
                                case 2:
                                  string = DateFormat.MMM().format(DateTime(DateTime.now().year, DateTime.now().month - 5));
                                  break;
                                
                                case 3:
                                  string = DateFormat.MMM().format(DateTime(DateTime.now().year, DateTime.now().month - 4));
                                  break;
                                
                                case 4:
                                  string = DateFormat.MMM().format(DateTime(DateTime.now().year, DateTime.now().month - 3));
                                  break;
                                
                                case 5:
                                  string = DateFormat.MMM().format(DateTime(DateTime.now().year, DateTime.now().month - 2));
                                  break;
                                
                                case 6:
                                  string = DateFormat.MMM().format(DateTime(DateTime.now().year, DateTime.now().month - 1));
                                  break;
                                
                                case 7:
                                  string = DateFormat.MMM().format(DateTime.now());
                                  break;
                              }
                            }

                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                string,
                                style: TextStyle(
                                  color: utils.textColorAlt,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: utils.textColorAlt,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          widget,
        ],
      ),
    );
  }

  Widget buildProgressionDonuts() {
    List<double> values = [];
    List<String> titles = [];

    for (int i = 0; i < 7; i++) {
      switch (choiceIndex) {
        case 0:
          values.add(dayProgressDouble(DateTime.now().subtract(Duration(days: i))));
          titles.add(DateFormat.E().format(DateTime.now().subtract(Duration(days: i))));
          break;

        case 1:
          values.add(weekProgressDouble(DateTime.now().subtract(Duration(days: 7 * i))));
          switch (i) {
            case 0:
              titles.add("This");
              break;
            
            case 1:
              titles.add("Last");
              break;
            
            case 2:
              titles.add("3rd");
              break;
            
            case 3:
              titles.add("4th");
              break;
            
            case 4:
              titles.add("5th");
              break;
            
            case 5:
              titles.add("6th");
              break;
            
            case 6:
              titles.add("7th");
              break;
          }
          break;

        case 2:
          if (i == 0) {
            values.add(monthProgressDouble(DateTime.now()));
          } else {
            values.add(monthProgressDouble(DateTime(DateTime.now().year, DateTime.now().month - i)));
          }
          titles.add(DateFormat.MMM().format(DateTime(DateTime.now().year, DateTime.now().month - i)));
          break;
      }
    }
    return ProgressionDonuts(
      values: values,
      titles: titles,
    );
  }

  List<BarChartGroupData> buildChartGroupData() {
    List<BarChartGroupData> temp = [];

    for (int x = 1; x <= 7; x++) {
      double y = 0;

      switch (choiceIndex) {
        case 0:
          y = dayProgressDouble(DateTime.now().subtract(Duration(days: 7 - x)));
          break;
        
        case 1:
          if (x == 7) {
            y = weekProgressDouble(DateTime.now());
          } else {
            y = weekProgressDouble(DateTime.now().subtract(Duration(days: 7 * (7 - x))));
          }
          break;
        
        case 2:
          if (x == 7) {
            y = monthProgressDouble(DateTime.now());
          } else {
            y = monthProgressDouble(DateTime(DateTime.now().year, DateTime.now().month - (7 - x)));
          }
          break;
      }

      temp.add(BarChartGroupData(
        x: x,
        barRods: [BarChartRodData(
          toY: y,
          width: 12,
          gradient: const LinearGradient(
            colors: [utils.color10Dark, utils.color10],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        )],
      ));
    }

    return temp;
  }
}