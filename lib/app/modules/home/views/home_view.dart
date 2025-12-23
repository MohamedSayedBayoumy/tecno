import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/common/app_bar/custom_app_bar.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

import '../../../core/widgets/common/custom_cached_circle_image.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controllers/home_controller.dart';
import '../widgets/explore_more_widget.dart';
import '../widgets/product_item_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/user_location_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        if (connected) {
          return Obx(() => controller.loading.value == true
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLoading(
                      width: 50,
                      height: 50,
                      size: 100,
                    ),
                  ],
                )
              : Column(
                  children: [
                    CustomAppBar(),
                    sizer(),
                    const SearchBarWidget(),
                    sizer(),
                    const UserLocationWidget(),
                    sizer(),
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        controller: controller.scrollController,
                        children: [
                          images(),
                          sizer(),
                          categories(context),
                          sizer(),
                          brands(context),
                          sizer(),
                          if (controller
                                  .home.value?.featuredProducts.isNotEmpty ??
                              false) ...[
                            featuredProducts(),
                          ],
                          sizer(),
                          featuredCategories(),
                          if (controller
                                  .featuredCategories.value!.links!.next ==
                              null) ...[
                            ExploreMoreWidget(controller: controller)
                          ] else ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomLoading(
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ));
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
            ],
          );
        }
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget images() {
    final sliders = controller.home.value?.sliders ?? [];
    return CarouselSlider(
      options: CarouselOptions(
        height: kToolbarHeight * 4,
        aspectRatio: 1.0,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: sliders.map((e) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.indigo.withOpacity(.1)),
                  color: Colors.indigo.withOpacity(.1)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: e.photo!,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/noimage.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget categories(BuildContext context) {
    final categories = controller.home.value?.categories ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(
          text: "product_department".tr,
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Wrap(
                runSpacing: 14,
                spacing: MediaQuery.sizeOf(context).width * .03,
                runAlignment: WrapAlignment.center,
                children: categories
                    .map((e) => SizedBox(
                          width: (MediaQuery.of(context).size.width - 10) / 6,
                          child: InkWell(
                            overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            onTap: () => Get.toNamed(
                              Routes.ITEM_FILTERS,
                              arguments: {'category_id': e.id},
                            ),
                            child: Column(
                              children: [
                                CachedCircleImage(imageUrl: e.photo!),
                                const SizedBox(height: 8.0),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    e.name ?? '',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: Styles.styleSemiBold13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ))
      ],
    );
  }

  Widget featuredProducts() {
    final featuredProducts = controller.home.value?.featuredProducts ?? [];
    return Column(
      children: [
        sectionHeader(text: 'Featured Products'.tr),
        SizedBox(
          height: 330,
          child: ListView.builder(
            itemCount: featuredProducts.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final item = featuredProducts[index];
              return ProductItemWidget(item: item);
            },
          ),
        )
      ],
    );
  }

  Widget featuredCategories() {
    final featuredCategories = controller.featuredCategories.value?.data ?? [];

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels ==
            scrollNotification.metrics.maxScrollExtent) {
          if (controller.featuredCategories.value?.links?.next != null) {
            controller.loadMoreFeaturedCategories();
          }
        }
        return false;
      },
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == featuredCategories.length) {
            return controller.isLoadingMore.value
                ? const SizedBox()
                : const SizedBox();
          }

          final category = featuredCategories[index];
          return category.items?.isNotEmpty ?? false
              ? Column(
                  children: [
                    sectionHeader(text: category.name ?? ''),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 310,
                      ),
                      itemCount: category.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = category.items![index];
                        return ProductItemWidget(item: item);
                      },
                    ),
                  ],
                )
              : const SizedBox();
        },
        separatorBuilder: (context, index) => sizer(),
        itemCount: featuredCategories.length + 1,
      ),
    );
  }

  Widget brands(BuildContext context) {
    final brands = controller.home.value?.brands ?? [];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: sectionHeader(text: 'brands'.tr)),
            TextButton(
              
              onPressed: () {
                Get.toNamed(Routes.brands);
              },
              child: Text(
                "more".tr,
                style: Styles.styleBold15.copyWith(
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Wrap(
                runSpacing: 14,
                spacing: MediaQuery.sizeOf(context).width * .03,
                runAlignment: WrapAlignment.center,
                children: brands
                    .map((e) => InkWell(
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          onTap: () => Get.toNamed(
                            Routes.ITEM_FILTERS,
                            arguments: {'brand_id': e.id},
                          ),
                          child: SizedBox(
                            width: (MediaQuery.of(context).size.width - 10) / 6,
                            child: Column(
                              children: [
                                CachedCircleImage(imageUrl: e.photo!),
                                const SizedBox(height: 8.0),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    e.name ?? '',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: Styles.styleSemiBold13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ))
      ],
    );
  }

  Widget sectionHeader({required String text}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: labelStyle(text: text, style: Styles.styleBold20),
              ),
            ),
            sizer(),
          ],
        ),
      ],
    );
  }

  Widget image({
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
