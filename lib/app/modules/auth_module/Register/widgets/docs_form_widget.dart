import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/services/camera_gallery_sheet.dart';
import '../../../../core/services/pick_image_file_services.dart';
import '../../../../core/widgets/common/custom_asset_image.dart';
import '../../../../models/public/language.dart';
import '../controllers/register_controller.dart';

class UploadFilesSection extends StatelessWidget {
  const UploadFilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    const Color rowBg = Color(0xFF57BFD0); // لون المستطيل الفاتح
    const Color iconBg = Color(0xFF4AB1C3); // خلفية أيقونة اليسار

    return GetBuilder<RegisterController>(
      builder: (controller) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "upload_files".tr,
              maxLines: 2,
              style: Styles.styleBold15.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 5),

            // Rows
            _UploadRow(
              title: "commercial_register_image".tr,
              rowBg: rowBg,
              iconBg: iconBg,
              image: controller.commercialRegisterImage,
              onTap: (result) {
                controller.commercialRegisterImage = result;
                controller.update();
              },
              onDelete: () {
                controller.commercialRegisterImage = null;
                controller.update();
              },
            ),
            const SizedBox(height: 10),
            _UploadRow(
              title: "tax_number_image".tr,
              rowBg: rowBg,
              image: controller.taxNumberImage,
              iconBg: iconBg,
              onTap: (result) {
                controller.taxNumberImage = result;
                controller.update();
              },
              onDelete: () {
                controller.taxNumberImage = null;
                controller.update();
              },
            ),
            const SizedBox(height: 10),
            _UploadRow(
              title: "address_image".tr,
              rowBg: rowBg,
              image: controller.addressImage,
              iconBg: iconBg,
              onTap: (result) {
                controller.addressImage = result;
                controller.update();
              },
              onDelete: () {
                controller.addressImage = null;
                controller.update();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadRow extends StatelessWidget {
  final String title;
  final Color rowBg;
  final Color iconBg;
  Function(PickedImageFile?)? onTap;
  PickedImageFile? image;
  Function()? onDelete;

  _UploadRow({
    required this.title,
    required this.rowBg,
    required this.iconBg,
    this.onTap,
    this.image,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await showCameraGallerySheet(
          context,
        );
        onTap?.call(result.firstOrNull);
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: rowBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Left icon (download)
              if (image == null) ...[
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ] else ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: FileImage(File(image?.path ?? '')),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 12),

              // Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: 10),

              // Right file icon
              if (image == null) ...[
                const Icon(
                  Icons.insert_drive_file_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ] else ...[
                InkWell(
                  onTap: () {
                    onDelete?.call();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
