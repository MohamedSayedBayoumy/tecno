import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../models/product/item_details_model.dart';

class RateDetailsWidget extends StatelessWidget {
  const RateDetailsWidget({super.key, required this.ratingBreakdown});

  final List<RatingBreakdown> ratingBreakdown;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        ratingBreakdown.length,
        (index) {
          return Row(
            children: [
              SizedBox(
                width: 50,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "star_${ratingBreakdown[index].stars}".tr.toString(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: LinearProgressIndicator(
                    minHeight: 4.0,
                    value: ratingBreakdown[index].percentage / 100,
                    color: mainColor,
                    backgroundColor: Colors.white.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Text(
                "${ratingBreakdown[index].percentage}%",
                style: Styles.styleRegular13,
              ),
            ],
          );
        },
      ),
    );
  }
}
