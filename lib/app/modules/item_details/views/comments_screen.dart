import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/sizer.dart';
import '../controllers/item_details_controller.dart';
import '../widgets/rate_widget/user_comment_widget.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "item_rate",
          ),
          Expanded(
            child: GetBuilder<ItemDetailsController>(
              builder: (controller) {
                switch (controller.commentsStatus) {
                  case Status.loading:
                    return const CustomLoading();
                  case Status.loaded:
                    final comments =
                        controller.commentsResponse!.data.commentsList;
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      controller: controller.scrollController,
                      itemCount: controller.paginationReview == Status.loading
                          ? comments.length + 1
                          : comments.length,
                      separatorBuilder: (context, index) => sizer(),
                      itemBuilder: (context, index) {
                        if (index >= comments.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: CustomLoading(
                              width: 40,
                              height: 40,
                            ),
                          );
                        }
                        final comment = comments[index];

                        return UserCommentWidget(
                          reviewUser: comment,
                        );
                      },
                    );
                  case Status.fail:
                    return CustomFailedWidget(
                      onTap: () {
                        controller.getComments(page: 1);
                      },
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
