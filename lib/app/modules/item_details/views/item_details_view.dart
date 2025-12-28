import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/functions/public/get_lang';
import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:customer/app/core/widgets/common/custom_asset_image.dart';
import 'package:customer/app/core/widgets/common/custom_loading.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/data/online/auth_parser.dart';
import 'package:customer/app/modules/item_details/views/gellary_view.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../../../config/config.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../home/widgets/product_item_widget.dart';
import '../controllers/item_details_controller.dart';
import 'package:flutter_html/flutter_html.dart';

import '../widgets/app_bar_item_details.dart';
import '../widgets/item_description_widget.dart';
import '../widgets/rate_widget/rate_analysis_widget.dart';
import '../widgets/specification_widget.dart';
import 'price_shipping.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected =
                  !connectivity.contains(ConnectivityResult.none);
              if (connected) {
                return Obx(
                  () {
                    final controller = Get.find<ItemDetailsController>();
                    final profile = controller.homeCTRL.profile.value;
                    return Scaffold(
                      backgroundColor: Colors.white,
                      bottomNavigationBar: profile == null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    blurRadius: 20,
                                    offset: const Offset(0, -18),
                                  ),
                                ],
                              ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: CustomAppButton(
                                    action: () {
                                      Get.toNamed(Routes.SIGN_IN);
                                    },
                                    text: "Login".tr,
                                    color: mainColor),
                              ))
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    blurRadius: 20,
                                    offset: const Offset(0, -18),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  int totalStock =
                                      (controller.item.value!.item!.stock ?? 0);

                                  if (totalStock == 0) {
                                    Get.snackbar(
                                      'Error'.tr,
                                      'Out of Stock'.tr,
                                      snackPosition: SnackPosition
                                          .TOP, // Position on the screen
                                      backgroundColor:
                                          Colors.red.withOpacity(0.8),
                                      colorText: Colors.white,
                                      duration: const Duration(
                                          seconds:
                                              3), // Duration for the message
                                    );
                                    return;
                                  }
                                  controller.addToCart(
                                    id: controller.item.value?.item?.id ?? 0,
                                    counter: controller.counter,
                                    variantId:
                                        controller.variantId.toString().obs,
                                    variantPrice: controller.variantPrice,
                                    variantImage: controller.variantImage,
                                    variantName: controller.variantName,
                                    item: controller.item,
                                  );
                                },
                                child: Container(
                                    height: kTextTabBarHeight,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Center(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CustomAssetsImage(
                                            imagePath: Assets
                                                .assetsImagesNewVersionSolarCart5Bold,
                                            height: 20,
                                          ),
                                          const SizedBox(width: 4),
                                          labelStyle(
                                              text: 'Add To Cart'.tr,
                                              style: Styles.styleBold15
                                                  .copyWith(
                                                      color: Colors.white)),
                                        ],
                                      )),
                                    )),
                              ),
                            ),
                      body: Obx(() {
                        final item = controller.item.value;
                        // print(item?.item?.sortDetails);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              IgnorePointer(
                                  ignoring: controller.loading.value,
                                  child: const AppBarItemDetails()),
                              const SizedBox(height: 10),
                              controller.loading.value
                                  ? const Expanded(
                                      child: Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        children: [
                                          if (controller.item.value!.item!
                                                  .shippingPrice !=
                                              0.0) ...[
                                            ShippingPriceWidget(
                                              price: controller.item.value!
                                                  .item!.shippingPrice!,
                                            ),
                                          ],

                                          const SizedBox(height: 20),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: FadeIn(
                                                  child: labelStyle(
                                                    text:
                                                        "${item!.item!.name} ${controller.variantName.value}",
                                                    style: Styles.styleBold20,
                                                    maxLines: 6,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                overlayColor:
                                                    const WidgetStatePropertyAll(
                                                        Colors.transparent),
                                                onTap: () {
                                                  controller.addToWishList(
                                                      id: item.item!.id!);
                                                },
                                                child: likeButton(
                                                    item.item!.id!, controller),
                                              )
                                            ],
                                          ),

                                          FadeIn(
                                            delay: const Duration(
                                                milliseconds: 200),
                                            child: ItemDescriptionWidget(
                                                details: item.item?.sortDetails,
                                                controller: controller),
                                          ),
                                          FadeIn(
                                              delay: const Duration(
                                                  milliseconds: 300),
                                              child: images(controller)),
                                          sizer(),

                                          if (AuthParser().isAuth()) ...[
                                            buyOptions(controller),
                                            sizer(),
                                          ],

                                          Row(
                                            children: [
                                              labelStyle(
                                                text: "price".tr,
                                                maxLines: 2,
                                                style: Styles().subTitle,
                                              ),
                                              const Spacer(),
                                              Obx(
                                                () => labelStyle(
                                                  text:
                                                      '${controller.item.value?.item?.hasVariant == 1 ? controller.variantPrice.value : controller.item.value!.item!.price}  ${Config().currency}',
                                                  maxLines: 2,
                                                  style: Styles().normalCustom(
                                                      color: secondaryColor,
                                                      weight: FontWeight.bold,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                              sizer(),
                                              item.item?.previousPrice !=
                                                          null &&
                                                      item.item
                                                              ?.previousPrice !=
                                                          0.0
                                                  ? labelStyle(
                                                      text:
                                                          '${item.item?.previousPrice ?? ''} ${Config().currency}',
                                                      style: Styles().normalCustom(
                                                          color: mainColor,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          // properties(),

                                          if (item.item!.hasVariant == 1) ...[
                                            optionsSelect(controller),
                                            sizer(),
                                          ],

                                          // InkWell(
                                          //   onTap: () {
                                          //     Get.toNamed(
                                          //       Routes.VENDOR_DETAILS,
                                          //     );
                                          //   },
                                          //   child: const VendorWidget(),
                                          // ),
                                          sizer(),
                                          SpecificationWidget(
                                            itemDetails: controller.item.value!,
                                          ),
                                          sizer(),
                                          if (controller.item.value!.reviews !=
                                              null) ...[
                                            RateAnalysisWidget(
                                              title: "item_rate",
                                              reviewItem: controller
                                                  .item.value!.reviews!,
                                              itemId: controller
                                                  .item.value!.item!.id!,
                                            ),
                                          ],

                                          sizer(),

                                          relatedItems(controller),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset(AppAssets.noConnection)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "check internet connection".tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              }
            },
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ));
  }

  Widget sectionHeader({required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              // borderRadius:
              //     const BorderRadius.only(topRight: Radius.circular(20)),
              child: Container(
                // height: kToolbarHeight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: language().tr == 'ar'
                  //     ? BorderRadius.only(
                  //         bottomLeft: Radius.circular(25),
                  //         topLeft: Radius.circular(25))
                  //     : BorderRadius.only(
                  //         bottomRight: Radius.circular(25),
                  //         topRight: Radius.circular(25))
                ),
                child: labelStyle(
                    text: text,
                    style: Styles().subTitle.copyWith(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ),
            sizer(),
          ],
        ),
        // Container(
        //   width: double.infinity,
        //   height: 5,
        //   decoration: const BoxDecoration(
        //     color: Colors.black,
        //   ),
        // ),
      ],
    );
  }

  Widget likeButton(id, ItemDetailsController controller) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.transparent,
      child: Obx(() {
        if (controller.loadingLike.value == true) {
          return const Padding(
            padding: EdgeInsets.all(10.0),
            child: CustomLoading(
              width: 60,
              height: 60,
            ),
          );
        } else {
          if (controller.wasAddedToWishList.value == true ||
              controller.addedToWishList(id: id ?? 0).value) {
            return ZoomIn(
              child: const CustomAssetsImage(
                imagePath: Assets.assetsImagesNewVersionHeartFill,
                width: 30,
              ),
            );
          } else {
            return FadeIn(
              delay: const Duration(milliseconds: 100),
              child: const CustomAssetsImage(
                imagePath: Assets.assetsImagesNewVersionHeart,
                width: 50,
              ),
            );
          }
        }
      }),
    );
  }

  // Widget reviews() {
  //   final list = controller.item.value?.reviews ?? [];
  //   return list.isNotEmpty
  //       ? Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             labelStyle(text: 'Reviews', style: styles().subTitle),
  //             ListView.separated(
  //                 // scrollDirection: Axis.horizontal,
  //                 shrinkWrap: true,
  //                 itemBuilder: (context, index) {
  //                   final item = list[index];
  //                   return reviewCard(item: item);
  //                 },
  //                 separatorBuilder: (context, index) => sizer(),
  //                 itemCount: list.length),
  //           ],
  //         )
  //       : const SizedBox();
  // }

  Widget relatedItems(ItemDetailsController controller) {
    if (controller.item.value?.relatedItems.isEmpty ?? true) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Related Items'.tr, style: Styles.styleBold20),
        SizedBox(
          height: 320,
          child: ListView.builder(
            itemCount: controller.item.value?.relatedItems.length ?? 0,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final item = controller.item.value!.relatedItems[index];
              return ProductItemWidget(item: item);
            },
          ),
        )
      ],
    );
  }

  Widget properties(ItemDetailsController controller) {
    final list = controller.item.value?.secName ?? [];
    // final vendor = controller.item.value?.item?.;
    // print(controller.item.value!.attributes!.first.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                const item = "";
                // final item = list[index]??"";
                return Column(
                  children: [
                    labelStyle(text: item ?? "", style: Styles().normal),
                  ],
                );
              },
              separatorBuilder: (context, index) => Container(),
              itemCount: list.length ?? 0),
        ),
      ],
    );
  }

  // Widget buyOptions() {
  //   return Column(
  //     children: [
  //       Container(
  //         child: Row(
  //           children: [
  //             labelStyle(
  //               text: 'QTY'.tr,
  //               style: styles().subTitle,
  //             ),
  //             const Spacer(),
  //             Container(
  //               padding: const EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                   color: mainColor,
  //                   border: Border.all(color: Colors.grey),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: InkWell(
  //                   onTap: () => controller.addCount(
  //                       controller.variantStock.value == 0
  //                           ? controller.item.value!.item!.stock??0
  //                           : controller.variantStock.value ?? 0),
  //                   child: const Icon(
  //                     Icons.add,
  //                     color: Colors.white,
  //                   )),
  //             ),
  //             sizer(),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               height: 40,
  //               width: 50,
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Center(
  //                 child: Obx(
  //                   () => labelStyle(
  //                     text: '${controller.counter.value}',
  //                     style: styles().normal,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             sizer(),
  //             Container(
  //               padding: const EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                   color: mainColor,
  //                   border: Border.all(color: Colors.grey),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: InkWell(
  //                   onTap: () => controller.minusCount(),
  //                   child: const Icon(
  //                     Icons.remove,
  //                     color: Colors.white,
  //                   )),
  //             ),
  //           ],
  //         ),
  //       ),
  //       sizer(),
  //     ],
  //   );
  // }

  Widget buyOptions(ItemDetailsController controller) {
    int totalStock = (controller.item.value!.item!.stock ?? 0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: totalStock > 0
          ? DropdownButton<int>(
              isExpanded: true,
              // Makes dropdown full width
              value: controller.counter.value > totalStock
                  ? 1 // Reset to 1 if counter exceeds stock
                  : controller.counter.value,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  controller.counter.value = newValue;
                }
              },
              items: List.generate(
                totalStock,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              underline: const SizedBox(),
              // Remove default underline
              selectedItemBuilder: (BuildContext context) => List.generate(
                totalStock,
                (index) => Align(
                  alignment: language().tr == 'ar'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    '${'QTY'.tr}: ${controller.counter.value}',
                    // Shows 'QTY' in dropdown
                    style: Styles().subTitle,
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  'Out of Stock'.tr,
                  style: Styles().subTitle.copyWith(color: Colors.red),
                ),
              ),
            ),
    );
  }

  // Widget optionsSelect() {
  //   return Obx(() => SingleChildScrollView(
  //     scrollDirection: Axis.horizontal, // Enables horizontal scrolling
  //     child: Row(
  //       children: [
  //         ListView.builder(
  //           itemCount: controller.item.value?.variants?.length ?? 0,
  //           shrinkWrap: true,
  //           physics: BouncingScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             final variant = controller.item.value!.variants![index];
  //
  //             return Obx(
  //                   () => Card(
  //                 color: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                   side: BorderSide(
  //                     color: controller.isSelected(variant.id!)
  //                         ? mainColor
  //                         : Colors.grey,
  //                     width: 1.5,
  //                   ),
  //                 ),
  //                 child: Container(
  //                   width: 200, // Set a fixed width for each card
  //                   child: ListTile(
  //                     leading: variant.photo != null
  //                         ? Image.network(
  //                       variant.photo!,
  //                       width: 50,
  //                       height: 50,
  //                       fit: BoxFit.cover,
  //                       errorBuilder: (context, error, stackTrace) {
  //                         return Icon(Icons.image_not_supported, size: 50);
  //                       },
  //                     )
  //                         : Icon(Icons.image_not_supported, size: 50),
  //                     title: Text(variant.name ?? "No Name"),
  //                     subtitle: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text("السعر: ${variant.price} \$"),
  //                         Text("الكمية المتاحة: ${variant.stock}"),
  //                       ],
  //                     ),
  //                     trailing: Icon(
  //                       controller.isSelected(variant.id!)
  //                           ? Icons.check_circle
  //                           : Icons.circle_outlined,
  //                       color: controller.isSelected(variant.id!)
  //                           ? mainColor
  //                           : Colors.grey,
  //                     ),
  //                     onTap: () => controller.selectVariant(variant),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   ));
  // }

  Widget optionsSelect(ItemDetailsController controller) {
    if (controller.item.value!.variants.isEmpty) {
      return const SizedBox();
    }
    return Obx(() => SizedBox(
          height: 180, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Scroll Right to Left
            reverse: true,
            // Ensures scrolling starts from the right
            itemCount: controller.item.value?.variants.length ?? 0,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final variant = controller.item.value!.variants[index];
              return Obx(
                () => Container(
                  width: 140, // Adjust card width
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: controller.isSelected(variant.id!)
                            ? mainColor
                            : Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => controller.selectVariant(variant),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Variant Image
                          Container(
                            height: 90,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              image: DecorationImage(
                                image: variant.photo != null
                                    ? NetworkImage(variant.photo!)
                                    : AssetImage(AppAssets.noImage)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Variant Name
                          Text(
                            variant.name ?? "No Name",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${"price".tr} : ${variant.price} ${Config().currency}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          // Stock Status
                          if (variant.stock == 0)
                            Text(
                              "Out of Stock".tr,
                              style: const TextStyle(color: Colors.red),
                            ),
                          if (variant.stock! < 5 && variant.stock != 0)
                            Text(
                              "${variant.stock} ${"left in stock".tr}",
                              style: const TextStyle(color: Colors.orange),
                            ),
                          if (variant.stock! >= 5)
                            Text(
                              "In Stock".tr,
                              style: const TextStyle(color: Colors.green),
                            ),

                          // const SizedBox(height: 8),
                          // // Selection Icon
                          // Icon(
                          //   controller.isSelected(variant.id!)
                          //       ? Icons.check_circle
                          //       : Icons.circle_outlined,
                          //   color: controller.isSelected(variant.id!)
                          //       ? mainColor
                          //       : Colors.grey,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  // Widget optionsSelect() {
  //   return Obx(() => ListView.builder(
  //         itemCount: controller.item.value?.variants?.length ?? 0,
  //         shrinkWrap: true,
  //         physics: BouncingScrollPhysics(),
  //         itemBuilder: (context, index) {
  //           final variant = controller.item.value!.variants![index];
  //
  //           return Obx(
  //             () => Card(
  //               color: Colors.white,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //                 side: BorderSide(
  //                   color: controller.isSelected(variant.id!)
  //                       ? mainColor
  //                       : Colors.grey,
  //                   width: 1.5,
  //                 ),
  //               ),
  //               child: ListTile(
  //                 leading: variant.photo != null
  //                     ? Image.network(
  //                         variant.photo!,
  //                         width: 50,
  //                         height: 50,
  //                         fit: BoxFit.cover,
  //                         errorBuilder: (context, error, stackTrace) {
  //                           return Image.asset(
  //                             Assets.noImage,
  //                             height: 50,
  //                           );
  //                         },
  //                       )
  //                     : Image.asset(
  //                         Assets.noImage,
  //                         height: 50,
  //                       ),
  //                 title: Text(variant.name ?? "No Name"),
  //                 subtitle: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text("السعر: ${variant.price} \$"),
  //                     if (variant.stock == 0)
  //                       Text(
  //                         "Out Of Stock",
  //                         style: TextStyle(color: Colors.red),
  //                       ),
  //                     if (variant.stock! < 5 && variant.stock != 0)
  //                       Text(
  //                         "${variant.stock} left in stock",
  //                         style: TextStyle(color: Colors.orange),
  //                       ),
  //                     if (variant.stock! >= 5)
  //                       Text(
  //                         "In Stock",
  //                         style: TextStyle(color: Colors.green),
  //                       ),
  //                   ],
  //                 ),
  //                 trailing: Icon(
  //                   controller.isSelected(variant.id!)
  //                       ? Icons.check_circle
  //                       : Icons.circle_outlined,
  //                   color: controller.isSelected(variant.id!)
  //                       ? mainColor
  //                       : Colors.grey,
  //                 ),
  //                 onTap: () => controller.selectVariant(variant),
  //               ),
  //             ),
  //           );
  //         },
  //       ));
  // }

  Widget images(ItemDetailsController controller) {
    List<String> imageUrls = [];

    if (controller.item.value?.item?.hasVariant == 1) {
      // Use the first variant's gallery if available
      imageUrls = [
        if (controller.item.value!.item!.variants.isNotEmpty) ...[
          controller.item.value!.item!.photo!,
          ...controller.item.value!.item!.variants[0].gallery
              .map((e) => e.toString()),
        ]
      ];
    } else {
      // Fallback to main product gallery if variants are empty
      imageUrls = controller.item.value!.item!.galleries;
      controller.galleryImages.value = controller.item.value!.item!.galleries;
      print(
          "controller.item.value!.item!.galleries ${controller.item.value!.item!.galleries}");
    }

    return imageUrls.isNotEmpty
        ? NaturalHeightCarousel(imageUrls: controller.galleryImages)
        : controller.item.value!.item!.photo!.isNotEmpty
            ? Center(
                child: controller.item.value!.item!.photo! != null
                    ? Image.network(
                        controller.item.value!.item!.photo!,
                        height: 400,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppAssets.noImage,
                            height: 200,
                          );
                        },
                      )
                    : Image.asset(
                        AppAssets.noImage,
                        height: 200,
                      ),
              )
            : Center(
                child: Image.asset(
                AppAssets.noImage,
                height: 200,
              ));
  }

  Widget buildHtmlDetails(String? details, ItemDetailsController controller) {
    if (details == null || details.isEmpty) {
      return IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () {
            // controller.showShareBottomSheet(context);
            controller.shareViaWhatsApp();
          },
          icon: Icon(
            Icons.share_outlined,
            color: mainColor,
          ));
    }
    String displayText = details.length > 160
        ? "${details.substring(0, min(details.length, 160))}..."
        : details;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onLongPress: () {
              Clipboard.setData(
                  ClipboardData(text: _extractTextFromHtml(details)));
              Fluttertoast.showToast(msg: "تم نسخ الوصف");
            },
            child: Html(
              data: "$displayText seeMore",
              style: {
                "body": Style.fromTextStyle(
                    Styles.styleRegular15.copyWith(color: Colors.black)),
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.shareViaWhatsApp();
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffF3F3F3)),
            child: IconButton(
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                onPressed: () {
                  controller.shareViaWhatsApp();
                },
                icon: Icon(
                  Icons.share_rounded,
                  color: mainColor,
                  size: 18,
                )),
          ),
        ),
      ],
    );
  }

  String _extractTextFromHtml(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }
}
