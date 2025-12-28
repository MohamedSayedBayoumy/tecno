import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../controllers/register_controller.dart';
import '../models/branch_model.dart';

class BranchesWidget extends StatelessWidget {
  BranchesWidget({super.key});

  final controller = Get.find<RegisterController>();

  final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: textFieldBackGround,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: mainColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "branch".tr,
          style: Styles.styleBold15.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<BranchRegisterModel>(
          isExpanded: true,
          decoration: inputDecoration,
          menuMaxHeight: 300,
          value: controller.branchesResponse?.data.isNotEmpty ?? false
              ? controller.branchesResponse?.data.firstWhereOrNull(
                  (c) => c.id == controller.selectedBranch?.id,
                )
              : null,
          items: controller.branchesResponse?.data.map((branch) {
            return DropdownMenuItem<BranchRegisterModel>(
              value: branch,
              child: Text(branch.name),
            );
          }).toList(),
          onChanged: (BranchRegisterModel? selectedBranch) {
            if (selectedBranch != null) {
              controller.selectedBranch = selectedBranch;
              controller.update();
            }
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a city'.tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}
