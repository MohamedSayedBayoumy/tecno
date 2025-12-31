class TransactionDetailsResponse {
  final bool status;
  final String message;
  final TransactionData data;

  TransactionDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionDetailsResponse.fromJson(Map<String, dynamic> json) {
    return TransactionDetailsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: TransactionData.fromJson(json['data'] ?? {}),
    );
  }
}

class TransactionData {
  final int id;
  final String code;
  final String date;
  final String client;
  final String? status;
  final int isInvoiced;
  final List<dynamic> taxes;
  final String additionalDiscount;
  final double totalTaxes;
  final double subTotal;
  final double total;
  final List<TransactionItem> items;

  TransactionData({
    required this.id,
    required this.code,
    required this.date,
    required this.client,
    this.status,
    required this.isInvoiced,
    required this.taxes,
    required this.additionalDiscount,
    required this.totalTaxes,
    required this.subTotal,
    required this.total,
    required this.items,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'] ?? 0,
      code: json['code']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      client: json['client']?.toString() ?? '',
      status: json['status']?.toString(),
      isInvoiced: json['is_invoiced'] ?? 0,
      taxes: json['taxes'] ?? [],
      additionalDiscount: json['additional_discount']?.toString() ?? '0.00',
      totalTaxes:
          double.tryParse(json['total_taxes']?.toString() ?? '0') ?? 0.0,
      subTotal: double.tryParse(json['sub_total']?.toString() ?? '0') ?? 0.0,
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0.0,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class TransactionItem {
  final String codeChar;
  final String name;
  final int qty;
  final double price;
  final double total;

  TransactionItem({
    required this.codeChar,
    required this.name,
    required this.qty,
    required this.price,
    required this.total,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      codeChar: json['code_char']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      qty: json['qty'] ?? 0,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0.0,
    );
  }
}
