import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../controllers/addresses_controller.dart';

class SearchHeaderGoogleMapWidget extends StatelessWidget {
  SearchHeaderGoogleMapWidget({super.key});

  final controller = Get.find<AddressesController>();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: InkWell(
              onTap: () {
                if (controller.latLong != null) {
                  controller.confirmation(
                    context,
                    controller.markers.first.infoWindow.title!,
                  );
                } else {
                  Get.back();
                }
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: controller.searchController,
              googleAPIKey: "AIzaSyDdsACzhqR7UN69z4sDKZr27CASpT2i4mA",
              boxDecoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              inputDecoration: InputDecoration(
                hintText: "search_about".tr,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              debounceTime: 200,
              countries: const ["eg"],
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                controller.selectLocation(prediction);
              },
              itemClick: (Prediction prediction) {
                controller.itemClickOnSearchMap(prediction);
              },
              seperatedBuilder: const Divider(),
              containerHorizontalPadding: 10,
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      const CustomAssetsImage(
                        imagePath:
                            Assets.assetsImagesNewVersionFluentLocation24Filled,
                        height: 25,
                        width: 25,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: Text(
                          prediction.description ?? "",
                          style: Styles.styleMedium15,
                        ),
                      )
                    ],
                  ),
                );
              },
              isCrossBtnShown: true,
            ),
          ),
        ],
      ),
    );
  }
}
