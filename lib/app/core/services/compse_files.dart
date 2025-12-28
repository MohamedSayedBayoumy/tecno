import 'dart:developer';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';

import '../../models/files_compress.dart';

class UniversalCompressor {
  /// يستقبل أي ملف ويرجّع لك نتيجة الضغط
  Future<CompressedFileResult> compress(File input) async {
    final originalSize = await input.length();
    final mimeType = lookupMimeType(input.path) ?? 'application/octet-stream';

    if (mimeType.startsWith('image/')) {
      return _compressImage(input, mimeType, originalSize);
    } else {
      return _zipFile(input, mimeType, originalSize);
    }
  }

  // ----------------- Image -----------------
  Future<CompressedFileResult> _compressImage(
    File input,
    String mimeType,
    int originalSize,
  ) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = p.join(
      tempDir.path,
      '${p.basenameWithoutExtension(input.path)}_compressed${p.extension(input.path)}',
    );

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      input.path,
      targetPath,
      quality: 70,
      format: _getCompressFormat(mimeType),
    );

    final resultFile = compressedFile ?? input;
    final compressedSize = await (resultFile as XFile).length();

    final result = CompressedFileResult(
      file: resultFile,
      originalSize: originalSize,
      compressedSize: compressedSize,
      ratio: compressedSize / originalSize,
      mimeType: mimeType,
    );
    log(result.toString());
    return result;
  }

  CompressFormat _getCompressFormat(String mimeType) {
    if (mimeType.contains('png')) return CompressFormat.png;
    if (mimeType.contains('heic')) return CompressFormat.heic;
    return CompressFormat.jpeg;
  }

  // ----------------- Video -----------------

  // ----------------- Other types (ZIP) -----------------
  Future<CompressedFileResult> _zipFile(
    File input,
    String mimeType,
    int originalSize,
  ) async {
    final tempDir = await getTemporaryDirectory();
    final zipPath = p.join(
      tempDir.path,
      '${p.basenameWithoutExtension(input.path)}_compressed.zip',
    );

    final encoder = ZipFileEncoder();
    encoder.create(zipPath);
    encoder.addFile(input);
    encoder.close();

    final resultFile = File(zipPath);
    final compressedSize = await resultFile.length();

    return CompressedFileResult(
      file: resultFile as XFile,
      originalSize: originalSize,
      compressedSize: compressedSize,
      ratio: compressedSize / originalSize,
      mimeType: 'application/zip',
    );
  }
}
