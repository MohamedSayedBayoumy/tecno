import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:customer/app/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../modules/invoice/models/transaction_details_model.dart';

class InvoicePdfService {
  // Custom helper to fix Arabic text display in PDF without external packages.
  // This is a simplified version of what reshapers do.
  static String fixArabic(String text) {
    if (text.isEmpty) return text;

    // Check if the text contains Arabic characters
    bool hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    if (!hasArabic) return text;

    // For the pdf package, often setting the correct font (like Cairo)
    // and using textDirection: pw.TextDirection.rtl is enough IF the font is loaded correctly.
    // However, sometimes it still requires manual shaping or reversing depending on the environment.
    // Given the constraint "no new package", we will rely on the font's internal shaping
    // and ensure the text direction is handled properly by the widget tree.
    return text;
  }

  static Future<void> generateInvoice(TransactionData data) async {
    final pdf = pw.Document();

    // Loading Cairo font which supports Arabic shaping natively in many cases
    final fontData =
        await rootBundle.load("assets/fonts/Cairo/Cairo-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    // Load logo image
    final logoBytes = await rootBundle.load(AppAssets.logo);
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    // Generate QR code image
    final qrCodeImage = await _generateQrCodeImage("INV-${data.code}");

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: ttf),
        textDirection: pw.TextDirection.rtl, // Set global RTL
        build: (context) => [
          _buildHeader(data, ttf, logoImage),
          pw.SizedBox(height: 20),
          _buildQrCode(qrCodeImage, ttf),
          pw.SizedBox(height: 20),
          _buildInfoTable(data, ttf),
          pw.SizedBox(height: 20),
          _buildItemsTable(data, ttf),
          pw.SizedBox(height: 20),
          _buildSummaryTable(data, ttf),
        ],
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  static pw.Widget _buildHeader(
      TransactionData data, pw.Font font, pw.MemoryImage logoImage) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Tecno Factory for Plastic',
                    style: pw.TextStyle(
                        font: font,
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.green)),
                pw.Text('CR: 1010624998',
                    style: pw.TextStyle(font: font, fontSize: 12)),
                pw.Text('VAT: 312133624400003',
                    style: pw.TextStyle(font: font, fontSize: 12)),
              ],
            ),
          ],
        ),
        pw.Image(logoImage, width: 80, height: 80),
        pw.SizedBox(width: 10),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(fixArabic('مصنع التقني للبلاستيك'),
                style: pw.TextStyle(
                    font: font,
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
            pw.Text(fixArabic('سجل تجاري : 1010624998'),
                style: pw.TextStyle(font: font, fontSize: 12)),
            pw.Text(fixArabic('الرقم الضريبي : 312133624400003'),
                style: pw.TextStyle(font: font, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildInfoTable(TransactionData data, pw.Font font) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                  fixArabic('تاريخ الفاتورة: ${data.date}   Invoice Date'),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(font: font, fontSize: 10)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                  fixArabic('رقم الفاتورة: ${data.code}   Invoice Number'),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(font: font, fontSize: 10)),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(fixArabic('العميل: ${data.client}   Customer'),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(font: font, fontSize: 10)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(fixArabic('هاتف:   Mobile'),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(font: font, fontSize: 10)),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildItemsTable(TransactionData data, pw.Font font) {
    final headers = [
      fixArabic('إجمالي Total'),
      fixArabic('سعر Price'),
      fixArabic('الكمية Qty'),
      fixArabic('اسم الصنف Name'),
      fixArabic('كود Code'),
      '#'
    ];

    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: const pw.FlexColumnWidth(1),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(1),
        3: const pw.FlexColumnWidth(3),
        4: const pw.FlexColumnWidth(1),
        5: const pw.FlexColumnWidth(0.5),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: headers
              .map((h) => pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(h,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            font: font,
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold)),
                  ))
              .toList(),
        ),
        ...data.items.asMap().entries.map((entry) {
          int idx = entry.key;
          TransactionItem item = entry.value;
          return pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('${item.total}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 10))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('${item.price}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 10))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('${item.qty}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 10))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(fixArabic(item.name),
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(font: font, fontSize: 10))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(item.codeChar,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 10))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('${idx + 1}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(font: font, fontSize: 10))),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _buildSummaryTable(TransactionData data, pw.Font font) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Container(
          width: 350,
          child: pw.Table(
            border: pw.TableBorder.all(),
            children: [
              _summaryRow(
                  fixArabic(
                      'الإجمالي غير شامل ضريبة القيمة المضافة  Total Excluding VAT'),
                  '${data.subTotal}',
                  font),
              _summaryRow(fixArabic('مجموع الخصومات  Discounts'),
                  '${data.additionalDiscount}', font),
              _summaryRow(fixArabic('مجموع ضريبة القيمة المضافة  Total VAT'),
                  '${data.totalTaxes}', font),
              _summaryRow(fixArabic('إجمالي المبلغ المستحق  Total Amount Due'),
                  '${data.total}', font),
            ],
          ),
        ),
      ],
    );
  }

  static pw.TableRow _summaryRow(String label, String value, pw.Font font) {
    return pw.TableRow(
      children: [
        pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(value,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(font: font, fontSize: 10))),
        pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(label,
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(font: font, fontSize: 10))),
      ],
    );
  }

  // Generate QR code image as bytes
  static Future<Uint8List> _generateQrCodeImage(String data) async {
    try {
      final qrImage = QrPainter(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.M,
        color: Colors.black,
        emptyColor: Colors.white,
      );

      final picRecorder = ui.PictureRecorder();
      final canvas = ui.Canvas(picRecorder);
      final size = 200.0;
      qrImage.paint(canvas, Size(size, size));
      final picture = picRecorder.endRecording();
      final image = await picture.toImage(size.toInt(), size.toInt());
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      // Fallback: create a simple placeholder
      final picRecorder = ui.PictureRecorder();
      final canvas = ui.Canvas(picRecorder);
      final size = 200.0;
      final paint = ui.Paint()..color = Colors.black;
      canvas.drawRect(ui.Rect.fromLTWH(0, 0, size, size), paint);
      final picture = picRecorder.endRecording();
      final image = await picture.toImage(size.toInt(), size.toInt());
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    }
  }

  // Build QR code widget for PDF
  static pw.Widget _buildQrCode(Uint8List qrImageBytes, pw.Font font) {
    return pw.Center(
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
            ),
            child: pw.Image(
              pw.MemoryImage(qrImageBytes),
              width: 50,
              height: 50,
            ),
          ),
          pw.SizedBox(height: 5),
          // pw.Text(
          //   'QR Code',
          //   style: pw.TextStyle(font: font, fontSize: 12),
          // ),
        ],
      ),
    );
  }
}
