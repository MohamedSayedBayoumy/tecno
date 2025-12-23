import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/widgets/common/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../models/product/item_details_model.dart';

class UserCommentWidget extends StatelessWidget {
  const UserCommentWidget({super.key, required this.reviewUser});

  final ReviewUser reviewUser;

  @override
  Widget build(BuildContext context) {
    if (AppUtils.appLang == "ar") {
      timeago.setLocaleMessages('ar', timeago.ArMessages());
    } else {
      timeago.setLocaleMessages('en', timeago.EnMessages());
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: Colors.grey.shade100,
                ),
                child: Center(
                  child: Text(
                    reviewUser.user!.name[0],
                    style: Styles.styleExtraBold25,
                  ),
                ),
              ),
              sizer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewUser.user!.name),
                  Text(
                    reviewUser.createdAtHuman,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.styleMedium13,
                  ),
                ],
              ),
            ],
          ),
          sizer(),
          Row(
            children: [
              for (int i = 0; i < 5; i++) ...[
                Icon(
                  reviewUser.rating > i
                      ? Icons.star_rate_rounded
                      : Icons.star_border_rounded,
                  color: reviewUser.rating > i ? Colors.amber : Colors.grey,
                  size: 30,
                )
              ]
            ],
          ),
          sizer(),
          Text(
            reviewUser.review,
            style: Styles.styleMedium15,
          )
        ],
      ),
    );
  }
}
