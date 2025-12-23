import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../widgets/loading_google_map.dart';
import '../widgets/search_header_google_map_widget.dart';
import '../controllers/addresses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key, this.isFullView = true});
  final bool isFullView;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isFullView == false,
      child: Scaffold(
        body: GetBuilder<AddressesController>(
          builder: (controller) => Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: GoogleMap(
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(30.0444, 31.2357),
                    zoom: 2.0,
                  ),
                  markers: controller.markers,
                  onCameraIdle: () {},
                ),
              ),
              if (isFullView == true) ...[
                Positioned(
                  left: 10,
                  right: 10,
                  child: SafeArea(child: SearchHeaderGoogleMapWidget()),
                ),
                Positioned(
                  top: 95,
                  left: 0.0,
                  right: 0.0,
                  child: LoadingGoogleMap(controller: controller),
                ),
                if (controller.latLong != null) ...[
                  Positioned(
                    bottom: 10.0,
                    left: 20.0,
                    right: 20.0,
                    child: CustomAppButton(
                      text: "Apply",
                      action: () {
                        if (controller.latLong != null) {
                          controller.confirmation(
                            context,
                            controller.markers.first.infoWindow.title!,
                          );
                        } else {
                          Get.back();
                        }
                      },
                    ),
                  ),
                ]
              ],
            ],
          ),
        ),
      ),
    );
  }
}
