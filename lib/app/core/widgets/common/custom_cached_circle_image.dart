import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../constants/app_assets.dart';
import 'custom_asset_image.dart';

// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedCircleImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const CachedCircleImage({
    super.key,
    required this.imageUrl,
    this.radius = 25,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius - 2,
      backgroundColor: Colors.grey.shade200,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              // useOldImageOnUrlChange: false,
              // cacheManager: CacheManager(
              //   Config(
              //     'noCache',
              //     stalePeriod: const Duration(seconds: 1),
              //     maxNrOfCacheObjects: 0,
              //   ),
              // ),
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 70,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => const CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                strokeWidth: 3,
              ),
              errorWidget: (context, url, error) => const CustomAssetsImage(
                imagePath: Assets.assetsImagesNewVersionUser,
                width: 90,
                height: 90,
              ),
            )
          : const CustomAssetsImage(
              imagePath: Assets.assetsImagesNewVersionUser,
              width: 90,
              height: 90,
            ),
    );
  }
}
