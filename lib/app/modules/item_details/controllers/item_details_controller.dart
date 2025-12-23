import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:customer/app/config/config.dart';
import 'package:customer/app/data/online/auth_parser.dart';
import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/models/product/item.dart';
import 'package:customer/app/models/product/item_details_model.dart';
import 'package:customer/app/modules/cart/controllers/cart_controller.dart';
import 'package:customer/app/modules/home/controllers/home_controller.dart';
import 'package:customer/app/modules/item_details/views/share_bottom_sheet.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/enum.dart';
import '../../../core/functions/status/success.dart';
import '../../../data/repositories/cart/cart_repo.dart';
import '../../../models/cart/cart_options_model.dart';
import '../../../models/cart/option_selection.dart';
import '../../../models/product/comments.dart';

class ItemDetailsController extends GetxController {
  int id;

  ItemDetailsController({required this.id});

  final item = Rxn<ItemDetails>();
  CommentsResponse? commentsResponse;

  final loading = RxBool(false);
  final counter = 1.obs;

  final selectedOptions = <OptionSelection>[].obs;
  final galleryImages =
      <String>[].obs; // Add an observable list for gallery images
  final variantName = ''.obs;
  final variantPrice = ''.obs;
  final variantStock = 0.obs;
  final variantId = 0.obs;
  final variantImage = ''.obs;
  final wishList = <ItemModel>[].obs;
  final homeCTRL = Get.find<HomeController>();

  ScrollController scrollController = ScrollController();

  Status paginationReview = Status.loaded;

  Status commentsStatus = Status.loading;

  int pageIndex = 1;

  Timer? debounceScroll;

  handleUserScroll() {
    scrollController.addListener(
      () {
        final paginationData = commentsResponse!.data.pagination;
        if (paginationData!.lastPage != paginationData.currentPage) {
          if (debounceScroll?.isActive ?? false) {
            debounceScroll?.cancel();
          }
          if (paginationReview != Status.loading) {
            paginationReview = Status.loading;
            update();
          }

          debounceScroll = Timer(
            const Duration(seconds: 1),
            () async {
              ++pageIndex;
              getComments(
                itemId: id,
              );
            },
          );
        }
      },
    );
  }

  scroll() {
    scrollController.removeListener(() => handleUserScroll());

    scrollController.addListener(() => handleUserScroll());
  }

  getComments({itemId, int? page}) async {
    try {
      if (pageIndex == 1) {
        scroll();
        commentsStatus = Status.loading;
        update();
      }

      log("message$itemId");
      log("messagess$page");

      final result = await DataParser().getUsersComments(
        id: itemId ?? id,
        page: page ?? pageIndex,
      );
      if (pageIndex != 1) {
        commentsResponse!.data.commentsList.addAll(result.data.commentsList);
        commentsResponse!.data.pagination = result.data.pagination;
        paginationReview = Status.loaded;
      } else {
        commentsResponse = result;
        commentsStatus = Status.loaded;
      }
      update();
    } catch (e) {
      log("message>>$e");
      commentsStatus = Status.fail;
      update();
    }
  }

  @override
  void onInit() {
    getDetails();
    if (AuthParser().isAuth()) {
      getWishList();
    }
    super.onInit();
  }

  void selectVariant(Variant variant) {
    selectedOptions.clear(); // Allow only one selection at a time
    selectedOptions.add(OptionSelection(
      id: variant.id!,
      names: variant.name ?? '',
      optionName: variant.sku ?? '',
      optionPrice: double.tryParse(variant.price ?? "0") ?? 0,
    ));

    // Update gallery images when variant is selected
    if (variant.gallery.isNotEmpty) {
      galleryImages.assignAll(variant.gallery);
      variantName.value = variant.name!;
      variantPrice.value = variant.price!;
      variantStock.value = variant.stock!;
      counter.value = 1;
      variantId.value = variant.id!;
      variantImage.value = variant.gallery[0];
    } else {
      galleryImages.assignAll(item.value?.item?.galleries ?? []);
      variantName.value = item.value?.item?.name ?? "";
      variantPrice.value = item.value?.item?.price.toString() ?? "";
      variantStock.value = item.value?.item?.stock ?? 0;
      counter.value = 1;
      variantId.value = 0;
      variantImage.value = item.value?.item?.photo ?? "";
    }

    // Force UI update
    update();
  }

  void addCount(int stock) {
    if (stock == 0) {
      Get.snackbar(
        'Error'.tr, // Title of the snackbar
        'The product is currently not available'.tr, // Message
        snackPosition: SnackPosition.TOP, // Position on the screen
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3), // Duration for the message
      );
    } else {
      if (counter.value < stock) {
        counter.value++;
      } else {
        Get.snackbar(
          'Error'.tr, // Title of the snackbar
          'You cannot add more than the available stock'.tr, // Message
          snackPosition: SnackPosition.TOP, // Position on the screen
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3), // Duration for the message
        );
      }
    }
  }

  // void addToCart() {
  //   List<int> optionIds = [];
  //   List<String> names = [];
  //   List<int> optionId = [];
  //   List<String> optionNames = [];
  //   List<double> optionPrices = [];
  //   double optionsPrice = 0;
  //   for (var selectedOption in selectedOptions) {
  //     optionIds.add(selectedOption.id!);
  //     names.add(selectedOption.names ?? '');
  //     optionId.add(selectedOption.optionId ?? 0);
  //     optionNames.add(selectedOption.optionName ?? '');
  //     optionPrices.add(selectedOption.optionPrice ?? 0);
  //     optionsPrice += (selectedOption.optionPrice ?? 0);
  //   }
  //
  //   // print("optionIds === ${optionIds}");
  //   // print("int.parse(item.value!.item!.unitValue!) ${int.parse(item.value!.item!.unitValue!)}");
  //   // print("double.parse(item.value!.item!.wholeSalePrice!)/double.parse(item.value!.item!.unitValue!) ${double.parse(item.value!.item!.wholeSalePrice!)/double.parse(item.value!.item!.unitValue!)}");
  //   final cartOptions = CartOptions(
  //     optionsId: optionIds,
  //     attribute: Attribute(
  //         names: names,
  //         optionName: optionNames,
  //         optionPrice: optionPrices,
  //         optionId: optionId),
  //     attributePrice: optionsPrice,
  //     name: item.value?.item?.name ?? '',
  //     slug: item.value?.item?.slug ?? '',
  //     photo: item.value?.item?.photo ?? '',
  //     price: (double.parse(variantPrice.value.toString()) ?? 0 + optionsPrice),
  //     mainPrice: double.parse(item.value?.item?.price!) ?? 0,
  //     itemType: item.value?.item?.isType,
  //     qty: counter.value.toString(),
  //   );
  //   print("cart options ${cartOptions.optionsId}");
  //   // CartRepo().addToCart(itemId: id, qty: counter.value, options: cartOptions);
  //   print("cartOptions == ${cartOptions.attribute?.names ?? "444"} ");
  //
  //   print("stock == ${item.value?.item?.stock ?? "444"} ");
  //   CartRepo().addToCartLocal(
  //     productId: id.toString(),
  //     productName: item.value?.item?.name ?? "",
  //     productPrice:item.value?.item?.discountPrice.toString() ?? "",
  //     productImage: item.value?.item?.photo ?? "",
  //     productStock: item.value?.item?.stock.toString() ?? "",
  //     quantity: counter.value.toString(),
  //     options: cartOptions,
  //   );
  //   try {
  //     final cartCTRL = Get.find<CartController>();
  //     cartCTRL.getData();
  //   } catch (e) {}
  //   Get.snackbar(
  //     'Success'.tr, // Title of the snackbar
  //     'Added Successfully'.tr, // Message
  //     snackPosition: SnackPosition.TOP, // Position on the screen
  //     backgroundColor: Colors.green.withOpacity(0.8),
  //     colorText: Colors.white,
  //     duration: const Duration(seconds: 3),
  //   );
  //   // renderSuccess(message: 'Added Successfully'.tr);
  // }

  final loadingLike = false.obs;
  final wasAddedToWishList = false.obs;
  void addToWishList({required int id}) async {
    if (!AuthParser().isAuth()) {
      Get.snackbar(
        'Warning'.tr,
        'login_first'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      Get.toNamed(Routes.SIGN_IN);
      return;
    }

    try {
      loadingLike.value = true;
      await DataParser().addToWishList(id: id);
      if (addedToWishList(id: id).value) {
        wasAddedToWishList.value = false;
        Get.snackbar(
          'Success'.tr,
          'Removed from favourite'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        await homeCTRL.getWishList();
      } else {
        wasAddedToWishList.value = true;
        Get.snackbar(
          'Success'.tr,
          'Added to favourite'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        await homeCTRL.getWishList();
      }
      await getWishList();
      loadingLike.value = false;
    } catch (e) {
      print("Error in addToWishList: $e");
      Get.snackbar(
        'Error'.tr,
        'Failed to update wishlist'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      loadingLike.value = false;
    }
  }

  RxBool addedToWishList({
    required int id,
  }) {
    final item = wishList.firstWhereOrNull((element) => element.id == id);
    return RxBool(item != null);
  }

  Future<void> getWishList() async {
    try {
      wishList.value = await DataParser().getWishList();
    } catch (e) {
      print("Error in getWishList: $e");
    }
  }

  void showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ShareBottomSheet(
          item: item,
        );
      },
    );
  }

  void shareProduct() {
    Get.bottomSheet(
      ShareBottomSheet(item: item),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
    );
  }

  // Helper method to get share URL
  String getShareUrl() {
    return '${Config.staticURL}/product/${item.value?.item?.slug ?? ''}';
  }

  // Functions for different sharing methods
  void shareViaWhatsApp() async {
    final url = "https://wa.me/?text=${Uri.encodeComponent(getShareUrl())}";
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(getShareUrl());
    }
    // Get.back();
  }

  void shareViaMessenger() async {
    final url =
        "fb-messenger://share/?link=${Uri.encodeComponent(getShareUrl())}";
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(getShareUrl());
    }
    Get.back();
  }

  void shareViaMessages() async {
    final url = "sms:?body=${Uri.encodeComponent(getShareUrl())}";
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(getShareUrl());
    }
    Get.back();
  }

  void shareViaEmail() async {
    final url =
        "mailto:?subject=${Uri.encodeComponent('Check out this product')}&body=${Uri.encodeComponent(getShareUrl())}";
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(getShareUrl());
    }
    Get.back();
  }

  void copyShareLink() {
    Clipboard.setData(ClipboardData(text: getShareUrl()));
    Get.snackbar('Success'.tr, 'Link copied to clipboard'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2));
    Get.back();
  }

  // void addToCart() {
  //
  //   if (item.value!.item!.hasVariant != 0 && variantStock.value == 0) {
  //     Get.snackbar(
  //       'Error'.tr, // Title of the snackbar
  //       'The product is currently not available'.tr, // Message
  //       snackPosition: SnackPosition.TOP, // Position on the screen
  //       backgroundColor: Colors.red.withOpacity(0.8),
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 3), // Duration for the message
  //     );
  //     return; // Stop execution if stock is 0
  //   }
  //   List<int> optionIds = [];
  //   List<String> names = [];
  //   List<int> optionId = [];
  //   List<String> optionNames = [];
  //   List<double> optionPrices = [];
  //   double optionsPrice = 0;
  //
  //   print(item.value!.item!.price.toString());
  //   for (var selectedOption in selectedOptions) {
  //     optionIds.add(selectedOption.id!);
  //     names.add(selectedOption.names ?? '');
  //     optionId.add(selectedOption.optionId ?? 0);
  //     optionNames.add(selectedOption.optionName ?? '');
  //     optionPrices.add(selectedOption.optionPrice ?? 0);
  //     optionsPrice += (selectedOption.optionPrice ?? 0);
  //   }
  //
  //   final cartOptions = CartOptions(
  //     optionsId: optionIds,
  //     attribute: Attribute(
  //         names: names,
  //         optionName: optionNames,
  //         optionPrice: optionPrices,
  //         optionId: optionId),
  //     attributePrice: optionsPrice,
  //     name: item.value?.item?.name ?? '',
  //     slug: item.value?.item?.slug ?? '',
  //     photo: item.value?.item?.photo ?? '',
  //     price: item.value!.item!.hasVariant == 0
  //         ? double.parse(item.value!.item!.price.toString())
  //         : double.parse(variantPrice.value),
  //     itemType: item.value?.item?.isType,
  //     qty: counter.value.toString(),
  //   );
  //
  //   CartRepo().addToCartLocal(
  //     productId: id.toString(),
  //     productName: "${item.value?.item?.name} ${variantName.value}",
  //     variantId: variantId.value.toString(),
  //     productPrice: item.value!.item!.hasVariant == 0
  //         ? item.value!.item!.price.toString()
  //         : variantPrice.value,
  //     productImage: item.value!.item!.hasVariant == 0
  //         ? item.value!.item!.photo.toString()
  //         : variantImage.value,
  //     productStock: item.value!.item!.hasVariant == 0
  //         ? item.value!.item!.stock.toString()
  //         : variantStock.value.toString(),
  //     quantity: counter.value.toString(),
  //     options: cartOptions,
  //   );
  //
  //   try {
  //     final cartCTRL = Get.find<CartController>();
  //     cartCTRL.getData();
  //   } catch (e) {}
  //
  //   Get.snackbar(
  //     'Success'.tr, // Title of the snackbar
  //     'Added Successfully'.tr, // Message
  //     snackPosition: SnackPosition.TOP, // Position on the screen
  //     backgroundColor: Colors.green.withOpacity(0.8),
  //     colorText: Colors.white,
  //     duration: const Duration(seconds: 3),
  //   );
  // }

  // last function
  // void addToCart() {
  //   // ✅ تحقق من المخزون لو المنتج له Variants
  //   if (item.value!.item!.hasVariant != 0 && variantStock.value == 0) {
  //     Get.snackbar(
  //       'Error'.tr,
  //       'The product is currently not available'.tr,
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red.withOpacity(0.8),
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 3),
  //     );
  //     return;
  //   }
  //
  //   // ✅ تحقق من المخزون لو المنتج بدون Variants
  //   if (item.value!.item!.hasVariant == 0 &&
  //       (item.value!.item!.stock == null || item.value!.item!.stock == 0)) {
  //     Get.snackbar(
  //       'Error'.tr,
  //       'The product is currently not available'.tr,
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red.withOpacity(0.8),
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 3),
  //     );
  //     return;
  //   }
  //
  //   List<int> optionIds = [];
  //   List<String> names = [];
  //   List<int> optionId = [];
  //   List<String> optionNames = [];
  //   List<double> optionPrices = [];
  //   double optionsPrice = 0;
  //
  //   print(item.value!.item!.price.toString());
  //
  //   for (var selectedOption in selectedOptions) {
  //     optionIds.add(selectedOption.id!);
  //     names.add(selectedOption.names ?? '');
  //     optionId.add(selectedOption.optionId ?? 0);
  //     optionNames.add(selectedOption.optionName ?? '');
  //     optionPrices.add(selectedOption.optionPrice ?? 0);
  //     optionsPrice += (selectedOption.optionPrice ?? 0);
  //   }
  //
  //   final cartOptions = CartOptions(
  //     optionsId: optionIds,
  //     attribute: Attribute(
  //       names: names,
  //       optionName: optionNames,
  //       optionPrice: optionPrices,
  //       optionId: optionId,
  //     ),
  //     attributePrice: optionsPrice,
  //     name: item.value?.item?.name ?? '',
  //     slug: item.value?.item?.slug ?? '',
  //     photo: item.value?.item?.photo ?? '',
  //     price: item.value!.item!.hasVariant == 0
  //         ? double.parse(item.value!.item!.price.toString())
  //         : double.parse(variantPrice.value),
  //     itemType: item.value?.item?.isType,
  //     qty: counter.value.toString(),
  //   );
  //
  //   CartRepo().addToCartLocal(
  //     productId: id.toString(),
  //     productName: "${item.value?.item?.name} ${variantName.value}",
  //     variantId: variantId.value.toString(),
  //     productPrice: item.value!.item!.hasVariant == 0
  //         ? item.value!.item!.price.toString()
  //         : variantPrice.value,
  //     productImage: item.value!.item!.hasVariant == 0
  //         ? item.value!.item!.photo.toString()
  //         : variantImage.value,
  //     productStock: item.value!.item!.hasVariant == 0
  //         ? item.value!.item!.stock.toString()
  //         : variantStock.value.toString(),
  //     quantity: counter.value.toString(),
  //     options: cartOptions,
  //   );
  //
  //   try {
  //     final cartCTRL = Get.find<CartController>();
  //     cartCTRL.getData();
  //   } catch (e) {}
  //
  //   Get.snackbar(
  //     'Success'.tr,
  //     'Added Successfully'.tr,
  //     snackPosition: SnackPosition.TOP,
  //     backgroundColor: Colors.green.withOpacity(0.8),
  //     colorText: Colors.white,
  //     duration: const Duration(seconds: 3),
  //   );
  // }

  Future<void> addToCart({
    required int id,
    required RxInt counter,
    required RxString variantId,
    required RxString variantPrice,
    required RxString variantImage,
    required RxString variantName,
    required Rx<ItemDetails?> item,
    // required CartOptions cartOptions,
  }) async {
    final cartRepo = CartRepo();

    List<int> optionIds = [];
    List<String> names = [];
    List<int> optionId = [];
    List<String> optionNames = [];
    List<double> optionPrices = [];
    double optionsPrice = 0;

    print(item.value!.item!.price.toString());

    for (var selectedOption in selectedOptions) {
      optionIds.add(selectedOption.id!);
      names.add(selectedOption.names ?? '');
      optionId.add(selectedOption.optionId ?? 0);
      optionNames.add(selectedOption.optionName ?? '');
      optionPrices.add(selectedOption.optionPrice ?? 0);
      optionsPrice += (selectedOption.optionPrice ?? 0);
    }

    final cartOptions = CartOptions(
      optionsId: optionIds,
      attribute: Attribute(
        names: names,
        optionName: optionNames,
        optionPrice: optionPrices,
        optionId: optionId,
      ),
      attributePrice: optionsPrice,
      name: item.value?.item?.name ?? '',
      slug: item.value?.item?.slug ?? '',
      photo: item.value?.item?.photo ?? '',
      price: item.value!.item!.hasVariant == 0
          ? double.parse(item.value!.item!.price.toString())
          : double.parse(variantPrice.value),
      itemType: item.value?.item?.isType,
      qty: counter.value.toString(),
    );

    try {
      final existingItem = await cartRepo.findOfflineCartItem(
        productId: id.toString(),
        variantId: variantId.value.isEmpty ? null : variantId.value,
        optionsJson: jsonEncode(cartOptions),
      );

      // حساب الكمية المتوفرة في المخزون
      final int availableStock = item.value!.item!.hasVariant == 0
          ? item.value!.item!.stock!
          : int.tryParse(item.value!.item!.variants
                  .firstWhere(
                      (element) => element.id.toString() == variantId.value)
                  .stock
                  .toString()) ??
              0;

      if (existingItem != null) {
        final newQty =
            int.parse(existingItem.quantity.toString() ?? '0') + counter.value;

        if (newQty > availableStock) {
          Get.snackbar(
            'Error'.tr,
            'You have reached the available stock limit'.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          return;
        }

        await cartRepo.updateCartItemOffLine(
          id: existingItem.id!,
          quantity: newQty,
        );
      } else {
        if (counter.value > availableStock) {
          Get.snackbar(
            'Error'.tr,
            'Not enough stock available'.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          return;
        }

        cartRepo.addToCartLocal(
          productId: id.toString(),
          productName: "${item.value?.item?.name} ${variantName.value}",
          variantId: variantId.value.isEmpty ? null : variantId.value,
          productPrice: item.value!.item!.hasVariant == 0
              ? item.value!.item!.price.toString()
              : variantPrice.value,
          productImage: item.value!.item!.hasVariant == 0
              ? item.value!.item!.photo.toString()
              : variantImage.value,
          productStock: availableStock.toString(),
          quantity: counter.value.toString(),
          options: cartOptions,
          shippingPrice: item.value?.item?.shippingPrice!.toString(),
        );
      }
      Get.snackbar(
        'Success'.tr,
        'Item added to cart'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      cartRepo.getOffLineCarts();
    } catch (e) {
      debugPrint("Error in addToCart: $e");
      Get.snackbar(
        'Error'.tr,
        'Failed to add item to cart'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // void addToCart() {
  //   List<int> optionIds = [];
  //   List<String> names = [];
  //   List<int> optionId = [];
  //   List<String> optionNames = [];
  //   List<double> optionPrices = [];
  //   double optionsPrice = 0;
  //   print(item.value!.item!.price.toString());
  //   for (var selectedOption in selectedOptions) {
  //     optionIds.add(selectedOption.id!);
  //     names.add(selectedOption.names ?? '');
  //     optionId.add(selectedOption.optionId ?? 0);
  //     optionNames.add(selectedOption.optionName ?? '');
  //     optionPrices.add(selectedOption.optionPrice ?? 0);
  //     optionsPrice += (selectedOption.optionPrice ?? 0);
  //   }
  //
  //   final cartOptions = CartOptions(
  //     optionsId: optionIds,
  //     attribute: Attribute(
  //         names: names,
  //         optionName: optionNames,
  //         optionPrice: optionPrices,
  //         optionId: optionId),
  //     attributePrice: optionsPrice,
  //     name: item.value?.item?.name ?? '',
  //     slug: item.value?.item?.slug ?? '',
  //     photo: item.value?.item?.photo ?? '',
  //     price: item.value!.item!.hasVariant == 0 ? double.parse(item.value!.item!.price.toString()) :double.parse(variantPrice.value),
  //     // mainPrice: double.parse(item.value!.item!.price!) ?? 0,
  //     itemType: item.value?.item?.isType,
  //     qty: counter.value.toString(),
  //   );
  //
  //   CartRepo().addToCartLocal(
  //     productId: id.toString(),
  //     productName: "${item.value?.item?.name} ${variantName.value}",
  //     variantId: variantId.value.toString(),
  //     productPrice:item.value!.item!.hasVariant == 0 ? item.value!.item!.price.toString() :variantPrice.value,
  //     productImage:item.value!.item!.hasVariant == 0 ? item.value!.item!.photo.toString() : variantImage.value,
  //     productStock: item.value!.item!.hasVariant == 0 ? item.value!.item!.stock.toString() :variantStock.value.toString(),
  //     quantity: counter.value.toString(),
  //     options: cartOptions,
  //   );
  //   try {
  //     final cartCTRL = Get.find<CartController>();
  //     cartCTRL.getData();
  //   } catch (e) {}
  //   Get.snackbar(
  //     'Success'.tr, // Title of the snackbar
  //     'Added Successfully'.tr, // Message
  //     snackPosition: SnackPosition.TOP, // Position on the screen
  //     backgroundColor: Colors.green.withOpacity(0.8),
  //     colorText: Colors.white,
  //     duration: const Duration(seconds: 3),
  //   );
  //   // renderSuccess(message: 'Added Successfully'.tr);
  // }

  void minusCount() {
    if (counter.value > 1) {
      counter.value--;
    }
  }

  bool isSelected(int variantId) {
    return selectedOptions.any((element) => element.id == variantId);
  }

  // void selectVariant(Variant variant) {
  //   selectedOptions.clear(); // Allow only one selection at a time
  //   selectedOptions.add(OptionSelection(
  //     id: variant.id!,
  //     names: variant.name ?? '',
  //     optionName: variant.sku ?? '',
  //     optionPrice: double.tryParse(variant.price ?? "0") ?? 0,
  //   ));
  // }

  void getDetails() async {
    loading.value = true;
    item.value = await DataParser().getProductDetails(id: id);

    log("message ${item.value!.item!.shippingPrice}");

    // for (var attribute in item.value!.variants!) {
    //   try {
    //     // selectedOptions.add(OptionSelection(
    //     //   id: attribute.id,
    //     //   names: attribute.name ?? '',
    //     //   optionName: attribute.options?.first.name ?? '',
    //     //   optionPrice: attribute.options?.first.price?.toDouble(),
    //     // ));
    //     // ignore: empty_catches
    //   } catch (e) {}
    // }
    if (item.value != null && item.value!.variants.isNotEmpty) {
      // Automatically select the first variant
      selectVariant(item.value!.variants.first);
    }
    loading.value = false;
  }

  void selectAttribute({required OptionSelection selection}) {
    final item = selectedOptions
        .firstWhereOrNull((element) => element.names == selection.names);
    selectedOptions.remove(item);
    selectedOptions.add(selection);
  }
}
