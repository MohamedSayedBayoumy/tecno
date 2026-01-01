import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../../models/contact/contact_info_model.dart';
import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ContactController>(
        builder: (controller) {
          switch (controller.status) {
            case Status.loading:
              return const Center(child: CustomLoading());
            case Status.loaded:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomAppBar(
                      title: "مساعدة و دعم",
                      showCart: false,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ...controller.contactInfo.map((contact) {
                            return Column(
                              children: [
                                _buildContactCard(
                                  contactInfo: contact,
                                ),
                                sizer(),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            case Status.fail:
              return CustomFailedWidget(
                onTap: () => controller.getContactInformation(),
              );
          }
        },
      ),
    );
  }

  Widget _buildContactCard({
    required ContactInfoModel contactInfo,
  }) {
    // Determine if it's a phone number or email based on label or value
    final isPhone = _isPhoneNumber(contactInfo.value);
    final isEmail = _isEmail(contactInfo.value);
    
    // Determine icon and color based on type
    IconData leftIcon;
    Color iconColor;
    IconData rightIcon;
    Color? rightIconColor;
    
    if (isEmail) {
      leftIcon = Icons.send;
      iconColor = mainColor;
      rightIcon = Icons.email_outlined;
      rightIconColor = Colors.red;
    } else if (isPhone) {
      leftIcon = Icons.phone;
      iconColor = mainColor;
      // Determine right icon based on label
      if (contactInfo.label.contains('ادارة') || 
          contactInfo.label.contains('إدارة') ||
          contactInfo.label.contains('Administration')) {
        rightIcon = Icons.person_outline;
      } else {
        rightIcon = Icons.headset_mic_outlined;
      }
      rightIconColor = null;
    } else {
      // Default
      leftIcon = Icons.info_outline;
      iconColor = mainColor;
      rightIcon = Icons.arrow_forward_ios_rounded;
      rightIconColor = null;
    }

    return InkWell(
      onTap: () {
        if (isPhone) {
          _makePhoneCall(contactInfo.value);
        } else if (isEmail) {
          _sendEmail(contactInfo.value);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                leftIcon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contactInfo.label,
                    style: Styles.styleSemiBold16,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contactInfo.value,
                    style: Styles.styleRegular14.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              rightIcon,
              color: rightIconColor ?? Colors.grey.shade600,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  bool _isPhoneNumber(String value) {
    // Check if value contains only digits and possibly + or spaces
    final phoneRegex = RegExp(r'^[\d\s\+\-\(\)]+$');
    return phoneRegex.hasMatch(value.replaceAll(' ', ''));
  }

  bool _isEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        Get.snackbar(
          'Error'.tr,
          'Cannot make phone call'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error'.tr,
        'Something went wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar(
          'Error'.tr,
          'Cannot open email'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error'.tr,
        'Something went wrong'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}

