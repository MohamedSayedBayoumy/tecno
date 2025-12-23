// import 'package:customer/app/core/widgets/app_bars/title_app_bar.dart';
// import 'package:customer/app/core/widgets/common/sizer.dart';
// import 'package:customer/app/modules/addresses/cards/address_card.dart';
// import 'package:customer/app/modules/checkOut/controllers/check_out_controller.dart';
// import 'package:customer/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class selectAddress extends StatelessWidget {
//   final controller = Get.find<CheckOutController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: titleAppbar(label: 'Select Address'.tr),
//       floatingActionButton:
//           FloatingActionButton(onPressed: () => Get.toNamed(Routes.ADDADDRESSES)),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView.separated(
//             itemBuilder: (context, index) => InkWell(
//                 onTap: () {
//                   Navigator.pop(context, controller.addresses[index]);
//                 },
//                 child: addressCard(item: controller.addresses[index])),
//             separatorBuilder: (context, index) => sizer(),
//             itemCount: controller.addresses.length),
//       ),
//     );
//   }
// }
