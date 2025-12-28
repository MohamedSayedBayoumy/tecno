
import 'package:image_picker/image_picker.dart';

class CompressedFileResult {
  final XFile file;          // الملف بعد الضغط
  final int originalSize;   // حجم الملف قبل الضغط بالبايت
  final int compressedSize; // حجم الملف بعد الضغط
  final double ratio;       // نسبة الضغط
  final String mimeType;    // نوع الملف

  CompressedFileResult({
    required this.file,
    required this.originalSize,
    required this.compressedSize,
    required this.ratio,
    required this.mimeType,
  });

  @override
  String toString() {
    return 'CompressedFileResult('
        'mimeType: $mimeType, '
        'originalSize: $originalSize, '
        'compressedSize: $compressedSize, '
        'ratio: ${ratio.toStringAsFixed(2)}'
        ')';
  }
}
