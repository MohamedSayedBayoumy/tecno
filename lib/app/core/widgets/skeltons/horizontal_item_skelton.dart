import 'package:flutter/material.dart';

import '../common/skelton.dart';
// import 'package:get/get.dart';
// import 'package:r7/app/core/Constants/colors.dart';
// import 'package:r7/app/core/constants/styles.dart';
// import 'package:r7/app/core/functions/future/get_since_time.dart';
// import 'package:r7/app/core/widgets/buttons/book_mark_button.dart';
// import 'package:r7/app/core/widgets/labels/label_style.dart';
// import 'package:r7/app/routes/app_pages.dart';
// import '../../constants/strings.dart';
// import '../../functions/future/get_type.dart';

class horizontalItemSkelton extends StatelessWidget {
  double height;

  horizontalItemSkelton({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: height,
          // width: height,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              skelton(height: 50, width: 50),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      skelton(height: 15, width: 80),
                      skelton(height: 20, width: 20),
                    ],
                  ),
                  Row(
                    children: [
                      skelton(height: 20, width: 20),
                      const SizedBox(
                        width: 5,
                      ),
                      skelton(height: 15, width: 80),
                      const Spacer(),
                      skelton(height: 15, width: 80),
                    ],
                  ),
                  Row(
                    children: [
                      skelton(height: 20, width: 20),
                      const SizedBox(
                        width: 5,
                      ),
                      skelton(height: 15, width: 80),
                      const Spacer(),
                      skelton(height: 15, width: 80),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
