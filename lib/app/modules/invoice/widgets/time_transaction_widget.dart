import 'package:flutter/material.dart';

import '../../../core/constants/styles.dart';

class DateTimeInlineWidget extends StatelessWidget {
  const DateTimeInlineWidget({
    super.key,
    required this.dateText,
    required this.timeText,
    this.color = const Color(0xFFAFB5A1), 
    this.onTapDate,
    this.onTapTime,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.fontSize = 34,
  });

  final String dateText;
  final String timeText;
  final Color color;
  final VoidCallback? onTapDate;
  final VoidCallback? onTapTime;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final textStyle = Styles.styleRegular15.copyWith(color: color);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_rounded,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 3),
          Text(dateText, style: textStyle),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              radius: 4,
              backgroundColor: color,
            ),
          ),
          Icon(
            Icons.access_time_rounded,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 3),
          Text(timeText, style: textStyle),
        ],
      ),
    );
  }
}
