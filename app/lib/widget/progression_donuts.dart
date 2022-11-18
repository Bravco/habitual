import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

class ProgressionDonuts extends StatelessWidget {
  final List<double>? values;
  final List<String>? titles;

  const ProgressionDonuts({
    super.key,
    this.values,
    this.titles,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> week = [];

    for (int i = 0; i < 7; i++) {
      week.add(
        Column(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: values == null || values!.isEmpty || values!.length != 7
                ? 0
                : values![i],
                strokeWidth: 8,
                backgroundColor: utils.overlayGrey,
                color: utils.color10,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              titles == null || titles!.isEmpty || titles!.length != 7
              ? ""
              : titles![i],
              style: TextStyle(
                color: utils.textColorAlt,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    week = week.reversed.toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: week,
    );
  }
}