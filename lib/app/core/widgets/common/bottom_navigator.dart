// import 'package:customer/app/core/constants/styles.dart';
// import 'package:customer/app/core/widgets/labels/label_style.dart';
// import 'package:customer/app/modules/cart/controllers/cart_controller.dart';
// import 'package:customer/app/modules/home/controllers/home_controller.dart';
// import 'package:customer/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// import '../../constants/colors.dart';

// class bottomNavigator extends StatelessWidget {
//   int index;
//   bottomNavigator({required this.index});

//   CartController get cartController {
//     try {
//       return Get.find<CartController>();
//     } catch (e) {
//       return Get.put(CartController());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: kTextTabBarHeight * 1.3,
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//       child: Row(
//         children: [
//           item(
//               ind: 0,
//               label: 'Home'.tr,
//               icon: Icons.home_filled,
//               onTap: () {
//                 if (Get.currentRoute != Routes.HOME) {
//                   Get.toNamed(Routes.HOME);
//                   print("Navigating to Home");

//                   // هنا يتم إضافة الـ ScrollListener فقط إذا كانت الصفحة هي الـ Home

//                   Get.find<HomeController>().onClose().then(
//                     (_) {
//                       Get.find<HomeController>().setupScrollListener();
//                     },
//                   );
//                 }
//               }),
//           item(
//               ind: 1,
//               label: 'Categories'.tr,
//               icon: Icons.window,
//               onTap: () {
//                 if (Get.currentRoute != Routes.CATEGORIES) {
//                   Get.toNamed(Routes.CATEGORIES);
//                 }
//               }),
//           item(
//               ind: 2,
//               label: 'Offers'.tr,
//               icon: Icons.whatshot_outlined,
//               iconColor: Colors.red,
//               onTap: () {
//                 if (Get.currentRoute != Routes.OFFERS) {
//                   Get.toNamed(Routes.OFFERS);
//                 }
//               }),
//           item(
//               ind: 3,
//               label: 'Cart'.tr,
//               icon: Icons.shopping_bag_outlined,
//               badge: cartController.totalItems,
//               onTap: () {
//                 if (Get.currentRoute != Routes.CART) {
//                   Get.toNamed(Routes.CART);
//                 }
//               }),
//           item(
//               ind: 4,
//               label: 'Account'.tr,
//               icon: Icons.person_rounded,
//               onTap: () {
//                 if (Get.currentRoute != Routes.ACCOUNT) {
//                   Get.toNamed(Routes.ACCOUNT);
//                 }
//               })
//         ],
//       ),
//     );
//   }

//   Widget item(
//       {required String label,
//       required IconData icon,
//       Color iconColor = Colors.black,
//       required int ind,
//       RxInt? badge,
//       required Function onTap}) {
//     return Expanded(
//       child: InkWell(
//         onTap: () => onTap(),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Icon(
//                   icon,
//                   color: ind == index ? mainColor : secondaryColor,
//                 ),
//                 if (badge != null && badge.value > 0)
//                   Positioned(
//                     right: -5,
//                     top: -5,
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 16,
//                         minHeight: 16,
//                       ),
//                       child: Obx(() => Text(
//                             '${badge.value}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                             ),
//                             textAlign: TextAlign.center,
//                           )),
//                     ),
//                   ),
//               ],
//             ),
//             labelStyle(
//                 text: label,
//                 style: ind == index
//                     ? Styles().normalCustom(color: mainColor)
//                     : Styles().normal),
//           ],
//         ),
//       ),
//     );
//   }
// }
