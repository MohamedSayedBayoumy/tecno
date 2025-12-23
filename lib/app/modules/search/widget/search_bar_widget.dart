import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_controller.dart';

class SearchFilterBarWidget extends StatelessWidget {
  const SearchFilterBarWidget({super.key, required this.controller});

  final SearchControllers controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (Platform.isIOS) {
                final keyboardOpened = FocusScope.of(context).hasFocus;
                if (keyboardOpened == true) {
                  FocusScope.of(context).unfocus();
                } else {
                  Get.back();
                  FocusScope.of(context).unfocus();
                }
              } else {
                Get.back();
              }
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: IgnorePointer(
              ignoring: Get.find<SearchControllers>().status == Status.loading,
              child: CustomTextFormFieldWidget(
                action: (p0) => p0,
                hint: "search_about".tr,
                controller: Get.find<SearchControllers>().searchController,
                onConfirm: () {
                  log("message");
                },
              ),
            ),
          ),
          const SizedBox(width: 5),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  if (Get.find<SearchControllers>().status == Status.loading) {
                    return;
                  }
                  Get.toNamed(Routes.filter);
                },
                borderRadius: BorderRadius.circular(6),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomAssetsImage(
                    imagePath: Assets.assetsImagesNewVersionFilter,
                    height: 25,
                  ),
                ),
              ),
              if (controller.doSearch == true) ...[
                ZoomIn(
                  child: const CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.red,
                  ),
                )
              ]
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
