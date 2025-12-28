import 'package:flutter/material.dart';

import 'transaction_card_widget.dart';

class ListOfInvoicesWidget extends StatelessWidget {
  const ListOfInvoicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        return const TransactionCardWidget();
      },
    );
  }
}
