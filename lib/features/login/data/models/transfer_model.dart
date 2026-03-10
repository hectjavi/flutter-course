class TransferModel {
  final String id;
  final String sourceAccountId;
  final String destinationAccountId;
  final double amount;
  final String currency;
  final String? description;
  final String confirmationToken;
  final DateTime createdAt;
  final String status; 

  TransferModel({
    required this.id,
    required this.sourceAccountId,
    required this.destinationAccountId,
    required this.amount,
    required this.currency,
    this.description,
    required this.confirmationToken,
    required this.createdAt,
    required this.status,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      id: json['id'],
      sourceAccountId: json['sourceAccountId'],
      destinationAccountId: json['destinationAccountId'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      description: json['description'],
      confirmationToken: json['confirmationToken'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceAccountId': sourceAccountId,
      'destinationAccountId': destinationAccountId,
      'amount': amount,
      'currency': currency,
      'description': description,
      'confirmationToken': confirmationToken,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}