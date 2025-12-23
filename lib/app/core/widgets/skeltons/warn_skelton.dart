import 'package:flutter/material.dart';
import '../common/skelton.dart';

class warnCardSkelton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              skelton(height: 15, width: 80),
              skelton(height: 15, width: 100),
            ],
          ),
          skelton(height: 15, width: 150),
        ],
      ),
    );
  }
}
