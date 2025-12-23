// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:marker_icon/marker_icon.dart';
// import 'package:r7/app/core/constants/strings.dart';
// import 'package:r7/app/modules/home_module/home/controllers/home_controller.dart';

// class mapMarker extends StatefulWidget {
//   LatLng jobLat;
//   String companyImage;
//   double distance;
//   mapMarker(
//       {required this.jobLat,
//       required this.companyImage,
//       required this.distance});

//   @override
//   State<mapMarker> createState() => _mapMarkerState();
// }

// class _mapMarkerState extends State<mapMarker> {
//   final controller = Get.find<HomeController>();

//   List<Marker> markers = [];

//   @override
//   void initState() {
//     addUserMarker();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//         markers: Set<Marker>.of(markers),
//         circles: <Circle>{
//           Circle(
//             circleId: const CircleId('job'),
//             center: widget.jobLat,
//             radius: widget.distance,
//             strokeWidth: 1,
//             strokeColor: checkDistance() ? Colors.green : Colors.red,
//             fillColor: checkDistance()
//                 ? Colors.green.withOpacity(.2)
//                 : Colors.red.withOpacity(.2),
//           )
//         },
//         myLocationEnabled: true,
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         zoomGesturesEnabled: true,
//         initialCameraPosition: CameraPosition(target: widget.jobLat, zoom: 15));
//   }

//   void addUserMarker() async {
//     markers.add(
//       Marker(
//         icon: await MarkerIcon.downloadResizePictureCircle(widget.companyImage,
//             size: 100,
//             addBorder: true,
//             borderColor: Colors.white,
//             borderSize: 15),
//         position: widget.jobLat,
//         markerId: const MarkerId('company'),
//       ),
//     );
//     final userLocation = LatLng(controller.lat.value, controller.lng.value);

//     markers.add(
//       Marker(
//         icon: await MarkerIcon.downloadResizePictureCircle(
//             controller.profile.value?.imageUrl ?? imagePlaceHolder,
//             size: 100,
//             addBorder: true,
//             borderColor: Colors.white,
//             borderSize: 15),
//         position: userLocation,
//         markerId: const MarkerId('employee'),
//       ),
//     );
//     setState(() {});
//   }

//   bool checkDistance() {
//     final userLocation = LatLng(controller.lat.value, controller.lng.value);

//     final distance = calculateDistance(widget.jobLat.latitude,
//         widget.jobLat.longitude, userLocation.latitude, userLocation.longitude);
//     if (distance <= 150) {
//       return true;
//     }
//     return false;
//   }

//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
// }
