import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

// Data
import 'package:app/data/habits.dart';

class CheckinsPage extends StatelessWidget {
  const CheckinsPage({super.key});

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
          "Check-ins",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    color: utils.color10,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: 72,
                  decoration: BoxDecoration(
                    color: utils.overlayGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.check,
                          color: utils.color10,
                          size: 24,
                        ),
                        Text(
                          totalCheckins().toString(),
                          style: const TextStyle(
                            color: utils.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
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
              ) : ListView.separated(
                itemCount: habits.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 32);
                },
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                habits[index].title,
                                style: const TextStyle(
                                  color: utils.textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              habits[index].subtitle != null
                              ? Text(
                                habits[index].subtitle!,
                                style: TextStyle(
                                  color: utils.textColorAlt,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                              : Container(),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 72,
                        decoration: BoxDecoration(
                          color: utils.overlayGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.check,
                                color: utils.color10,
                                size: 24,
                              ),
                              Text(
                                habits[index].dateData.length.toString(),
                                style: const TextStyle(
                                  color: utils.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}