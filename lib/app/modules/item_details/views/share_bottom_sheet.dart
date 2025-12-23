import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets.dart';
import '../../../models/product/item_details_model.dart';
import '../controllers/item_details_controller.dart';

class ShareBottomSheet extends GetWidget<ItemDetailsController> {
  final Rxn<ItemDetails> item;

  ShareBottomSheet({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Share this product with friends'.tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          Obx(() => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: item.value?.item?.photo != null
                          ? Image.network(
                              item.value!.item!.photo!,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(AppAssets.noImage);
                              },
                              fit: BoxFit.cover,
                              height: 120,
                            )
                          : Image.asset(AppAssets.noImage,
                              fit: BoxFit.cover, height: 120),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${item.value?.item?.name ?? ""}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildShareOption('WhatsApp', Icons.chat, Colors.green,
                  controller.shareViaWhatsApp),
              _buildShareOption('Messenger', Icons.chat, Colors.blue,
                  controller.shareViaMessenger),
              _buildShareOption('Messages', Icons.chat, Colors.green,
                  controller.shareViaMessages),
              _buildShareOption(
                  'Email', Icons.email, Colors.red, controller.shareViaEmail),
              _buildShareOption(
                  'Copy', Icons.link, Colors.grey, controller.copyShareLink),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildShareOption(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
