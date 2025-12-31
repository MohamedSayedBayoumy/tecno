import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/constants/styles.dart';

class InvoiceQrCodeWidget extends StatelessWidget {
  final String qrData;
  const InvoiceQrCodeWidget({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 50.0,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
