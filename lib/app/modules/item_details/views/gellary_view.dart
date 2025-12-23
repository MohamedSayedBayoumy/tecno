import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/common/sizer.dart';

class NaturalHeightCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const NaturalHeightCarousel({super.key, required this.imageUrls});

  @override
  State<NaturalHeightCarousel> createState() => _NaturalHeightCarouselState();
}

class _NaturalHeightCarouselState extends State<NaturalHeightCarousel> {
  int currentIndex = 0;

  void _openImageFullScreen(int initialIndex, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        PageController controller = PageController(initialPage: initialIndex);
        return Dialog(
          backgroundColor: Colors.grey.withOpacity(0.1),
          insetPadding: const EdgeInsets.all(10),
          child: ViewImageWidget(controller: controller, widget: widget),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imageUrls.asMap().entries.map((entry) {
            return InkWell(
                onTap: () => _openImageFullScreen(entry.key, context),
                child: Image.network(
                  entry.value,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/no_image.png");
                  },
                ));
          }).toList(),
          options: CarouselOptions(
            height: 400,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        sizer(height: 20),
        Obx(() => AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: widget.imageUrls.length,
              effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: mainColor,
                  dotColor: Colors.grey,
                  paintStyle: PaintingStyle.stroke),
            )),
      ],
    );
  }
}

class ViewImageWidget extends StatelessWidget {
  const ViewImageWidget({
    super.key,
    required this.controller,
    required this.widget,
  });

  final PageController controller;
  final NaturalHeightCarousel widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        PageView.builder(
          controller: controller,
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index) {
            final imageUrl = widget.imageUrls[index];
            return GestureDetector(
              onLongPress: () => _handleImageLongPress(imageUrl),
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/no_image.png',
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Future<void> _handleImageLongPress(String imageUrl) async {
    if (kIsWeb) {
      _showSnack('Saving images is only supported on mobile devices',
          isError: true);
      return;
    }

    final hasPermission = await _requestMediaPermission();
    if (!hasPermission) {
      _showSnack(_permissionErrorMessage(), isError: true);
      return;
    }

    _showSnack(_savingMessage());

    try {
      final saved = await GallerySaver.saveImage(imageUrl, toDcim: true);
      if (saved == true) {
        _showSnack(_successMessage());
      } else {
        _showSnack('Unable to save image. Please try again.', isError: true);
      }
    } catch (error) {
      _showSnack('Something went wrong while saving the image', isError: true);
    }
  }

  Future<bool> _requestMediaPermission() async {
    if (kIsWeb) {
      return false;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final photosStatus = await Permission.photos.request();
      if (photosStatus.isGranted || photosStatus.isLimited) {
        return true;
      }
      final addOnlyStatus = await Permission.photosAddOnly.request();
      return addOnlyStatus.isGranted || addOnlyStatus.isLimited;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) {
        return true;
      }
      final manageStatus = await Permission.manageExternalStorage.request();
      if (manageStatus.isGranted) {
        return true;
      }
      final photosStatus = await Permission.photos.request();
      return photosStatus.isGranted;
    }

    return false;
  }

  String _permissionErrorMessage() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Photo library permission is required to save images';
    }
    return 'Storage permission is required to save images';
  }

  String _savingMessage() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Saving image to Photos...';
    }
    return 'Saving image to gallery...';
  }

  String _successMessage() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Image saved to your Photos';
    }
    return 'Image saved to your gallery';
  }

  void _showSnack(String message, {bool isError = false}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'Gallery',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
      backgroundColor:
          (isError ? Colors.redAccent : Colors.black87).withOpacity(0.85),
      colorText: Colors.white,
    );
  }
}
