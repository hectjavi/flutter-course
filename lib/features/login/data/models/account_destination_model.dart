class AccountDestinationModel {
  final String id;
  final String accountNumber;
  final String accountHolderName;
  final String bankName;
  final String? alias;

  AccountDestinationModel({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.bankName,
    this.alias,
  });

  factory AccountDestinationModel.fromJson(Map<String, dynamic> json) {
    return AccountDestinationModel(
      id: json['id'],
      accountNumber: json['accountNumber'],
      accountHolderName: json['accountHolderName'],
      bankName: json['bankName'],
      alias: json['alias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNumber': accountNumber,
      'accountHolderName': accountHolderName,
      'bankName': bankName,
      'alias': alias,
    };
  }

  String get displayName => alias ?? accountHolderName;
}