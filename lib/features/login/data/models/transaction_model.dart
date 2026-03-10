class TransactionModel {
  final String id;
  final String accountId;
  final String type; // 'income', 'expense', 'transfer'
  final double amount;
  final String currency;
  final String description;
  final String? counterpartyName;
  final String? counterpartyAccount;
  final DateTime date;
  final String status; // 'completed', 'pending', 'failed'
  final String? referenceNumber;
  final String? category; // 'food', 'transport', 'salary', etc.

  TransactionModel({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.currency,
    required this.description,
    this.counterpartyName,
    this.counterpartyAccount,
    required this.date,
    required this.status,
    this.referenceNumber,
    this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      accountId: json['accountId'],
      type: json['type'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      description: json['description'],
      counterpartyName: json['counterpartyName'],
      counterpartyAccount: json['counterpartyAccount'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      referenceNumber: json['referenceNumber'],
      category: json['category'],
    );
  }

  bool get isIncome => type == 'income';
  bool get isExpense => type == 'expense';
  bool get isTransfer => type == 'transfer';
  
  String get formattedType {
    switch (type) {
      case 'income':
        return 'Ingreso';
      case 'expense':
        return 'Gasto';
      case 'transfer':
        return 'Transferencia';
      default:
        return 'Movimiento';
    }
  }
}