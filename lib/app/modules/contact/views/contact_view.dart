import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/sizer.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  _buildContactCard(
                    icon: Icons.phone,
                    iconColor: mainColor,
                    title: "الادارة",
                    subtitle: "0590148158",
                    rightIcon: Icons.person_outline,
                    onTap: () => _makePhoneCall("0590148158"),
                  ),
                  sizer(),
                  _buildContactCard(
                    icon: Icons.phone,
                    iconColor: mainColor,
                    title: "مبيعات الرياض",
                    subtitle: "0591358436",
                    rightIcon: Icons.headset_mic_outlined,
                    onTap: () => _makePhoneCall("0591358436"),
                  ),
                  sizer(),
                  _buildContactCard(
                    icon: Icons.phone,
                    iconColor: mainColor,
                    title: "مبيعات جده",
                    subtitle: "0591336529",
                    rightIcon: Icons.headset_mic_outlined,
                    onTap: () => _makePhoneCall("0591336529"),
                  ),
                  sizer(),
                  _buildContactCard(
                    icon: Icons.send,
                    iconColor: mainColor,
                    title: "البريد الالكتروني",
                    subtitle: "Tecnofactoryplastic@gmail.com",
                    rightIcon: Icons.email_outlined,
                    rightIconColor: Colors.red,
                    onTap: () => _sendEmail("Tecnofactoryplastic@gmail.com"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required IconData rightIcon,
    Color? rightIconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
                icon,
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
                    title,
                    style: Styles.styleSemiBold16,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
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

