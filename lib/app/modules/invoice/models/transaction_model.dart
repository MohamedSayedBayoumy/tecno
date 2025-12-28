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

  factory WalletStatementResponse.fromJson(Map<String, dynamic> json) {
    return WalletStatementResponse(
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      transactions: (json['transactions'] as List<dynamic>?)
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
  final String description;
  final int debit;
  final int credit;
  final String date;
  final String time;

  const WalletTransaction({
    required this.description,
    required this.debit,
    required this.credit,
    required this.date,
    required this.time,
  });

  /// Initial values for all variables
  factory WalletTransaction.empty() => const WalletTransaction(
        description: '',
        debit: 0,
        credit: 0,
        date: '',
        time: '',
      );

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      description: json['description'] as String? ?? '',
      debit: (json['debit'] as num?)?.toInt() ?? 0,
      credit: (json['credit'] as num?)?.toInt() ?? 0,
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'description': description,
        'debit': debit,
        'credit': credit,
        'date': date,
        'time': time,
      };

  WalletTransaction copyWith({
    String? description,
    int? debit,
    int? credit,
    String? date,
    String? time,
  }) {
    return WalletTransaction(
      description: description ?? this.description,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
