import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../controllers/invoice_controller.dart';

class LastUpdateWidget extends StatefulWidget {
  const LastUpdateWidget({super.key});

  @override
  State<LastUpdateWidget> createState() => _LastUpdateWidgetState();
}

class _LastUpdateWidgetState extends State<LastUpdateWidget> {
  Timer? _timer;
  int _minutes = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!mounted) return;
      setState(() => _minutes++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Get.find<InvoiceController>().getInvoices();
  }

  @override
  Widget build(BuildContext context) {
    if (_minutes == 0) {
      return const SizedBox.shrink();
    }
    return InkWell(
      onTap: _refresh,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xfff3f3f4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: mainColor, size: 20),
              const SizedBox(width: 5),
              Text(
                "last_updated_minutes_ago"
                    .tr
                    .replaceAll("{minutes}", _minutes.toString()),
                style: Styles.styleRegular13.copyWith(color: mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
