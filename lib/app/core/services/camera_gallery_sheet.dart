import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/styles.dart';
import '../services/pick_image_file_services.dart';

/// Show a bottom sheet to pick image(s) from camera or gallery.
/// If [allowMultiple] is true, gallery selection allows multiple images.
/// Returns a list of picked images (empty if user cancels).
Future<List<PickedImageFile>> showCameraGallerySheet(
  BuildContext context, {
  bool allowMultiple = false,
  int? maxImages,
  bool onlyGallery = false,
  bool deleteImage = false,
  VoidCallback? onDelete,
}) async {
  final picker = PickImageFileServices();
  List<PickedImageFile> result = const [];

  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!onlyGallery) ...[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text('common.camera'.tr),
                onTap: () async {
                  final picked = await picker.pickSingleImage(
                    source: ImageSource.camera,
                  );
                  if (picked != null) {
                    result = [picked];
                  }
                  Navigator.of(ctx).pop();
                },
              ),
              const Divider(height: 1),
            ],
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('common.gallery'.tr),
              onTap: () async {
                final picked = await picker.pickSingleImage(
                  source: ImageSource.gallery,
                );
                if (picked != null) result = [picked];

                Navigator.of(ctx).pop();
              },
            ),
            const SizedBox(height: 8),
            if (deleteImage) ...[
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(
                  'common.delete_image'.tr,
                  style: Styles.styleRegular15.copyWith(
                    color: Colors.red,
                  ),
                ),
                onTap: () async {
                  onDelete?.call();
                  Navigator.of(ctx).pop();
                },
              ),
              const Divider(height: 1),
            ],
          ],
        ),
      );
    },
  );

  return result;
}
