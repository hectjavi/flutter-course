class AccountModel {
  final String id;
  final String accountNumber;
  final String accountType;
  final double balance;
  final String currency;
  final String bankName;
  final String status;

  AccountModel({
    required this.id,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.currency,
    required this.bankName,
    required this.status,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      accountNumber: json['accountNumber'],
      accountType: json['accountType'],
      balance: json['balance'].toDouble(),
      currency: json['currency'],
      bankName: json['bankName'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNumber': accountNumber,
      'accountType': accountType,
      'balance': balance,
      'currency': currency,
      'bankName': bankName,
      'status': status,
    };
  }
}