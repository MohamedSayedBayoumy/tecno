import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../models/cart/address_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/addresses_controller.dart';
import 'address_action_widget.dart';

class EditAndDeleteAddressWidget extends StatelessWidget {
  EditAndDeleteAddressWidget({super.key, required this.addressModel});
  final AddressData addressModel;

  final controller = Get.find<AddressesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          if (controller.showEdit == true) ...[
            AddressActionWidget(
              image: Assets.assetsImagesNewVersionEdit,
              title: "edit",
              onTap: () {
                controller.selectedAddress = addressModel;
                controller.getGovernorate();

                Get.toNamed(Routes.address);
              },
            ),
            Container(
              width: 1,
              height: 20,
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(horizontal: 15),
            ),
          ],
          AddressActionWidget(
            image: Assets.assetsImagesNewVersionDelete,
            title: "delete",
            onTap: () {
              showDeleteAddressDialog(context, addressModel);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> showDeleteAddressDialog(
    BuildContext context, AddressData addressModel) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  overlayColor: WidgetStatePropertyAll(Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                  child: const Icon(Icons.close),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, color: Colors.red.shade700),
                  Expanded(
                    child: Text(
                      "do_you_want_delete_address".tr,
                      textAlign: TextAlign.center,
                      style: Styles.styleBold15
                          .copyWith(color: Colors.red.shade700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                      side: BorderSide(color: Colors.red.shade700, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("no".tr),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      Get.find<AddressesController>()
                          .deleteAddress(addressModel.id);
                    },
                    child: Text("yes".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
