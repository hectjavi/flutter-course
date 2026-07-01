import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/account.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const AccountModel._();

  const factory AccountModel({
    required String id,
    required String accountNumber,
    required String accountType,
    required double balance,
    required String currency,
    required String bankName,
    required String status,
  }) = _AccountModel;

  factory AccountModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AccountModelFromJson(json);

  factory AccountModel.fromEntity(
    Account entity,
  ) {
    return AccountModel(
      id: entity.id,
      accountNumber: entity.accountNumber,
      accountType: entity.accountType,
      balance: entity.balance,
      currency: entity.currency,
      bankName: entity.bankName,
      status: entity.status,
    );
  }

  Account toEntity() {
    return Account(
      id: id,
      accountNumber: accountNumber,
      accountType: accountType,
      balance: balance,
      currency: currency,
      bankName: bankName,
      status: status,
    );
  }
}