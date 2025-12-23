import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:customer/app/modules/item_details/controllers/item_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../models/product/item_details_model.dart';
import '../../../../routes/app_pages.dart';
import 'rate_count_and_star_widget.dart';
import 'rate_details_widget.dart';
import 'user_comment_widget.dart';

class RateAnalysisWidget extends StatelessWidget {
  const RateAnalysisWidget({
    super.key,
    required this.title,
    required this.reviewItem,
    required this.itemId,
  });
  final String title;

  final ReviewItem reviewItem;

  final int itemId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style: Styles.styleBold15,
          ),
          sizer(),
          Row(
            children: [
              RateCountAndStarWidget(
                totalRate: reviewItem.statistics.averageRating,
                totalStar: reviewItem.statistics.totalReviews,
              ),
              sizer(),
              Expanded(
                child: RateDetailsWidget(
                  ratingBreakdown: reviewItem.statistics.ratingBreakdown,
                ),
              )
            ],
          ),
          if (reviewItem.latestReviews.isNotEmpty) ...[
            Divider(
              height: 30,
              color: AppColors.grey,
            ),
            Text(
              "user_review".tr,
              style: Styles.styleBold15,
            ),
            sizer(),
            ListView.separated(
              itemCount: reviewItem.latestReviews.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 0),
              separatorBuilder: (context, index) => sizer(),
              itemBuilder: (context, index) {
                return UserCommentWidget(
                  reviewUser: reviewItem.latestReviews[index],
                );
              },
            ),
            sizer(),
            if (reviewItem.hasMore == true) ...[
              CustomAppButton(
                text: "more",
                color: Colors.white,
                borderColor: mainColor,
                style: Styles.styleBold15.copyWith(color: mainColor),
                action: () {
                  Get.find<ItemDetailsController>().getComments(itemId: itemId);
                  Get.toNamed(Routes.comments);
                },
              )
            ],
          ]
        ],
      ),
    );
  }
}
