import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

/// Simple model representing a picked image file
class PickedImageFile {
  final String path;
  final String name;
  final int sizeBytes;
  final String? mimeType;
  final Uint8List? bytes;

  const PickedImageFile({
    required this.path,
    required this.name,
    required this.sizeBytes,
    this.mimeType,
    this.bytes,
  });
}

/// Simple model representing a picked video file
class PickedVideoFile {
  final String path;
  final String name;
  final int sizeBytes;
  final String? mimeType;
  final Duration? duration;

  const PickedVideoFile({
    required this.path,
    required this.name,
    required this.sizeBytes,
    this.mimeType,
    this.duration,
  });
}

/// Service to pick single or multiple images from gallery or camera
class PickImageFileServices {
  PickImageFileServices({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Pick a single image from [source] (gallery by default)
  Future<PickedImageFile?> pickSingleImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 90,
  }) async {
    // Use file_picker for Android gallery, image_picker for camera and iOS
 

    final XFile? x = await _picker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );
    if (x == null) return null;
    return _toPicked(x);
  }

  /// Pick multiple images from gallery
  Future<List<PickedImageFile>> pickMultipleImages({
    int imageQuality = 90,
  }) async {
    // Use file_picker for Android, image_picker for iOS
 
    final List<XFile> files = await _picker.pickMultiImage(
      imageQuality: imageQuality,
    );
    final List<PickedImageFile> result = [];
    for (final x in files) {
      result.add(await _toPicked(x));
    }
    return result;
  }

  /// Pick a single video from [source] (gallery by default)
  Future<PickedVideoFile?> pickSingleVideo({
    ImageSource source = ImageSource.gallery,
    Duration? maxDuration,
  }) async {
    // Use file_picker for Android gallery, image_picker for camera and iOS
 

    final XFile? x = await _picker.pickVideo(
      source: source,
      maxDuration: maxDuration,
    );
    if (x == null) return null;
    return _toPickedVideo(x);
  }

  // /// Pick multiple videos from gallery
  // /// Note: This uses pickMultipleMedia and filters for videos only
  // Future<List<PickedVideoFile>> pickMultipleVideos() async {
  //   final List<XFile> files = await _picker.pickMultipleMedia();
  //   final List<PickedVideoFile> result = [];
  //   for (final x in files) {
  //     // Filter for videos only
  //     final mimeType = x.mimeType?.toLowerCase() ?? '';
  //     if (mimeType.startsWith('video/')) {
  //       result.add(await _toPickedVideo(x));
  //     }
  //   }
  //   return result;
  // }

  Future<PickedImageFile> _toPicked(XFile x) async {
    final String path = x.path;
    final String name = x.name;
    final int size = await x.length();
    // Load bytes lazily; reading here for convenience
    final Uint8List bytes = await x.readAsBytes();
    String? mime;
    if (x.mimeType != null) {
      mime = x.mimeType;
    } else if (path.toLowerCase().endsWith('.png')) {
      mime = 'image/png';
    } else if (path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg')) {
      mime = 'image/jpeg';
    } else if (path.toLowerCase().endsWith('.webp')) {
      mime = 'image/webp';
    }
    return PickedImageFile(
      path: path,
      name: name,
      sizeBytes: size,
      mimeType: mime,
      bytes: bytes,
    );
  }

  Future<PickedImageFile> _toPickedFromFile(
    String path,
    String name,
    int size,
  ) async {
    final file = File(path);
    final Uint8List bytes = await file.readAsBytes();
    String? mime;
    if (path.toLowerCase().endsWith('.png')) {
      mime = 'image/png';
    } else if (path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg')) {
      mime = 'image/jpeg';
    } else if (path.toLowerCase().endsWith('.webp')) {
      mime = 'image/webp';
    } else if (path.toLowerCase().endsWith('.gif')) {
      mime = 'image/gif';
    } else if (path.toLowerCase().endsWith('.bmp')) {
      mime = 'image/bmp';
    }
    return PickedImageFile(
      path: path,
      name: name,
      sizeBytes: size,
      mimeType: mime,
      bytes: bytes,
    );
  }

  Future<PickedVideoFile> _toPickedVideo(XFile x) async {
    final String path = x.path;
    final String name = x.name;
    final int size = await x.length();
    String? mime;
    if (x.mimeType != null) {
      mime = x.mimeType;
    } else if (path.toLowerCase().endsWith('.mp4')) {
      mime = 'video/mp4';
    } else if (path.toLowerCase().endsWith('.mov')) {
      mime = 'video/quicktime';
    } else if (path.toLowerCase().endsWith('.avi')) {
      mime = 'video/x-msvideo';
    } else if (path.toLowerCase().endsWith('.mkv')) {
      mime = 'video/x-matroska';
    } else if (path.toLowerCase().endsWith('.webm')) {
      mime = 'video/webm';
    }
    // Note: Duration extraction would require additional packages like video_player
    // For now, we'll leave it as null
    return PickedVideoFile(
      path: path,
      name: name,
      sizeBytes: size,
      mimeType: mime,
      duration: null,
    );
  }

  Future<PickedVideoFile> _toPickedVideoFromFile(
    String path,
    String name,
    int size,
  ) async {
    String? mime;
    if (path.toLowerCase().endsWith('.mp4')) {
      mime = 'video/mp4';
    } else if (path.toLowerCase().endsWith('.mov')) {
      mime = 'video/quicktime';
    } else if (path.toLowerCase().endsWith('.avi')) {
      mime = 'video/x-msvideo';
    } else if (path.toLowerCase().endsWith('.mkv')) {
      mime = 'video/x-matroska';
    } else if (path.toLowerCase().endsWith('.webm')) {
      mime = 'video/webm';
    } else if (path.toLowerCase().endsWith('.3gp')) {
      mime = 'video/3gpp';
    } else if (path.toLowerCase().endsWith('.flv')) {
      mime = 'video/x-flv';
    }
    // Note: Duration extraction would require additional packages like video_player
    // For now, we'll leave it as null
    return PickedVideoFile(
      path: path,
      name: name,
      sizeBytes: size,
      mimeType: mime,
      duration: null,
    );
  }
}
