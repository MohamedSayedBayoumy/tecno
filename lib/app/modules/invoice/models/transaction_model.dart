class WalletStatementResponse {
  final int balance;
  final List<WalletTransaction> transactions;

  const WalletStatementResponse({
    required this.balance,
    required this.transactions,
  });

  /// Initial values for all variables
  factory WalletStatementResponse.empty() => const WalletStatementResponse(
        balance: 0,
        transactions: <WalletTransaction>[],
      );

  factory WalletStatementResponse.fromJson(dynamic json) {
    if (json is List) {
      return WalletStatementResponse(
        balance: 0,
        transactions: json
            .map((e) => WalletTransaction.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    final jsonMap = json as Map<String, dynamic>;
    return WalletStatementResponse(
      balance: int.tryParse(jsonMap['balance']?.toString() ?? '0') ?? 0,
      transactions: (jsonMap['transactions'] as List<dynamic>?)
              ?.map(
                  (e) => WalletTransaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <WalletTransaction>[],
    );
  }

  Map<String, dynamic> toJson() => {
        'balance': balance,
        'transactions': transactions.map((e) => e.toJson()).toList(),
      };
}

class WalletTransaction {
  final int id;
  final String code;
  final String description;
  final int debit;
  final int credit;
  final String date;
  final String time;
  final String client;
  final int total;
  final int isInvoiced;

  const WalletTransaction({
    required this.id,
    required this.code,
    required this.description,
    required this.debit,
    required this.credit,
    required this.date,
    required this.time,
    this.client = '',
    this.total = 0,
    this.isInvoiced = 0,
  });

  /// Initial values for all variables
  factory WalletTransaction.empty() => const WalletTransaction(
        id: 0,
        code: '',
        description: '',
        debit: 0,
        credit: 0,
        date: '',
        time: '',
      );

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      code: json['code']?.toString() ?? '',
      description: json['description']?.toString() ??
          (json['code'] != null ? "Invoice #${json['code']}" : ''),
      debit: int.tryParse(json['debit']?.toString() ?? '0') ?? 0,
      credit: int.tryParse(json['credit']?.toString() ?? '0') ??
          (int.tryParse(json['total']?.toString() ?? '0') ?? 0),
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
      client: json['client']?.toString() ?? '',
      total: int.tryParse(json['total']?.toString() ?? '0') ?? 0,
      isInvoiced: int.tryParse(json['is_invoiced']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'description': description,
        'debit': debit,
        'credit': credit,
        'date': date,
        'time': time,
        'client': client,
        'total': total,
        'is_invoiced': isInvoiced,
      };

  WalletTransaction copyWith({
    int? id,
    String? code,
    String? description,
    int? debit,
    int? credit,
    String? date,
    String? time,
    String? client,
    int? total,
    int? isInvoiced,
  }) {
    return WalletTransaction(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      date: date ?? this.date,
      time: time ?? this.time,
      client: client ?? this.client,
      total: total ?? this.total,
      isInvoiced: isInvoiced ?? this.isInvoiced,
    );
  }
}
