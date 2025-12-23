import 'package:customer/app/config/config.dart';
import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/models/product/item.dart';
import 'package:customer/app/modules/item_details/controllers/item_details_controller.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../home/controllers/home_controller.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  ItemCard({super.key, required this.item});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.delete<ItemDetailsController>();
        Get.toNamed(Routes.ITEM_DETAILS,
            arguments: item.id, preventDuplicates: false);
      },
      child: Container(
        width: kTextTabBarHeight * 4,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: item.photo != null
                  ? Image.network(
                      item.photo!,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(AppAssets.noImage);
                      },
                      fit: BoxFit.cover,
                    )
                  : Image.asset(AppAssets.noImage, fit: BoxFit.cover),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelStyle(
                  text: item.name ?? '',
                  maxLines: 2,
                  style: Styles().normalCustom(
                      color: Colors.black, overflow: TextOverflow.ellipsis),
                ),
                RichText(
                    maxLines: 1,
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${item.price ?? ''}  ${Config().currency}',
                        style: Styles().normalCustom(
                            color: mainColor, overflow: TextOverflow.ellipsis),
                      ),
                      if (item.previousPrice != 0.0)
                        TextSpan(
                          text: item.previousPrice != null
                              ? '  ${item.previousPrice ?? ''} ${Config().currency}'
                              : '',
                          style: Styles().normalCustom(
                              color: mainColor,
                              decoration: TextDecoration.lineThrough),
                        )
                    ])),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Obx(
                //       () => iconButton(
                //           action: () {
                //             if (AuthParser().isAuth()) {
                //               controller.addToWishList(id: item.id ?? 0);
                //             } else {
                //               Get.toNamed(Routes.SIGN_IN);
                //             }
                //           },
                //           icon:
                //               controller.addedToWishList(id: item.id ?? 0).value
                //                   ? Icons.favorite
                //                   : Icons.favorite_border_rounded),
                //     ),
                //     iconButton(
                //         action: () async {
                //           await Clipboard.setData(ClipboardData(
                //               text:
                //                   "${Config.staticURL}/product/${item.slug ?? ''}"));
                //           renderSuccess(message: 'Copied Successfully!'.tr);
                //         },
                //         icon: Icons.copy),
                //    Obx(() {
                //      final profile = controller.profile.value;
                //      return  iconButton(
                //          action: () {
                //            if (profile != null) {
                //              // controller.addToCart(item: item);
                //              controller.addToCartLocal(item: item, id:item.id! );
                //            } else {
                //              Get.toNamed(Routes.SIGN_IN);
                //            }
                //          },
                //          icon: Icons.shopping_cart_outlined);
                //    },),
                //   ],
                // )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
